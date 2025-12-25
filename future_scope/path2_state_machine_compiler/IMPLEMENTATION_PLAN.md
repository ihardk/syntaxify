# State Machine Compiler: Implementation Plan

**Duration:** 5-7 sessions (~16-22 hours)
**Target:** Production-ready MVP
**Risk:** LOW-MEDIUM

---

## Phase Breakdown

| Phase | Sessions | Duration | Output |
|-------|----------|----------|--------|
| **Phase 1:** Foundation | 1-2 | 4-5h | DSL models, minimal runtime |
| **Phase 2:** Compiler | 3-4 | 6-8h | State machine analyzer + generators |
| **Phase 3:** Integration | 5 | 3-4h | Build pipeline + example |
| **Phase 4:** Polish | 6-7 | 3-5h | Testing, validation, docs |

---

## SESSION 1: Feature DSL Models + Minimal Runtime

**Duration:** 2-3 hours
**Goal:** Define data structures for feature definitions + tiny runtime library

### Deliverables

#### 1. Feature Definition Models (`lib/src/models/feature/`)

**File:** `feature_definition.dart`
```dart
@freezed
class FeatureDefinition with _$FeatureDefinition {
  const factory FeatureDefinition({
    required String name,
    required List<StateDefinition> states,
    required List<IntentDefinition> intents,
    required List<TransitionDefinition> transitions,
    @Default([]) List<EffectDefinition> effects,
  }) = _FeatureDefinition;
}
```

**File:** `state_definition.dart`
```dart
@freezed
class StateDefinition with _$StateDefinition {
  const factory StateDefinition({
    required String name,
    @Default([]) List<FieldDefinition> fields,
    String? description,
  }) = _StateDefinition;
}
```

**File:** `intent_definition.dart`
```dart
@freezed
class IntentDefinition with _$IntentDefinition {
  const factory IntentDefinition({
    required String name,
    @Default([]) List<FieldDefinition> inputs,
    String? description,
  }) = _IntentDefinition;
}
```

**File:** `transition_definition.dart`
```dart
@freezed
class TransitionDefinition with _$TransitionDefinition {
  const factory TransitionDefinition({
    required String fromState,
    required String onIntent,
    required String toState,
    @Default([]) List<EffectType> effects,
    String? guard, // Optional condition
  }) = _TransitionDefinition;
}
```

**File:** `field_definition.dart`
```dart
@freezed
class FieldDefinition with _$FieldDefinition {
  const factory FieldDefinition({
    required String name,
    required String type,
    String? defaultValue,
  }) = _FieldDefinition;
}
```

**File:** `effect_definition.dart`
```dart
sealed class EffectType {
  const EffectType();
}

class NavigateEffect extends EffectType {
  final String route;
  const NavigateEffect(this.route);
}

class CustomEffect extends EffectType {
  final String name;
  final Map<String, dynamic>? params;
  const CustomEffect(this.name, {this.params});
}

class ShowDialogEffect extends EffectType {
  final String message;
  const ShowDialogEffect(this.message);
}
```

#### 2. Minimal Runtime Library (`lib/src/runtime/`)

**File:** `engine.dart`
```dart
/// Base class for all feature engines.
///
/// Implements unidirectional data flow:
/// Intent → Reducer → (New State, Effects)
abstract class Engine<S, I> {
  /// Current state
  S get state;

  /// Initial state (must be overridden)
  S get initialState;

  /// Dispatch an intent
  void dispatch(I intent);

  /// Pure reducer function (must be overridden)
  ReduceResult<S> reduce(S state, I intent);

  /// Effect runner (user implements)
  EffectRunner? get effectRunner;
}
```

**File:** `reduce_result.dart`
```dart
/// Result of a state reduction
@freezed
class ReduceResult<S> with _$ReduceResult<S> {
  const factory ReduceResult(
    S state, [
    @Default([]) List<Effect> effects,
  ]) = _ReduceResult<S>;
}
```

**File:** `effect.dart`
```dart
/// Base class for all effects
sealed class Effect {
  const Effect();
}

class Navigate extends Effect {
  final String route;
  final Map<String, dynamic>? arguments;
  const Navigate(this.route, {this.arguments});
}

class Custom extends Effect {
  final String name;
  final Map<String, dynamic>? data;
  const Custom(this.name, {this.data});
}
```

**File:** `effect_runner.dart`
```dart
/// User implements this to handle effects
abstract class EffectRunner {
  Future<void> run(Effect effect, EngineDispatcher dispatch);
}

/// Allows effects to dispatch intents back to engine
typedef EngineDispatcher = void Function(dynamic intent);
```

**File:** `engine_impl.dart` (Generated base)
```dart
/// Concrete implementation of Engine
class EngineImpl<S, I> extends ChangeNotifier implements Engine<S, I> {
  EngineImpl({
    required this.initialState,
    required this.reducer,
    this.effectRunner,
  }) : _state = initialState;

  @override
  final S initialState;

  final ReduceResult<S> Function(S state, I intent) reducer;

  @override
  final EffectRunner? effectRunner;

  S _state;

  @override
  S get state => _state;

  @override
  void dispatch(I intent) {
    final result = reduce(_state, intent);

    _state = result.state;
    notifyListeners();

    // Execute effects asynchronously
    for (final effect in result.effects) {
      _executeEffect(effect);
    }
  }

  @override
  ReduceResult<S> reduce(S state, I intent) {
    return reducer(state, intent);
  }

  Future<void> _executeEffect(Effect effect) async {
    if (effectRunner != null) {
      await effectRunner!.run(effect, dispatch);
    }
  }
}
```

**File:** `engine_provider.dart` (Flutter widget)
```dart
/// Provides engine to widget tree
class EngineProvider<E extends Engine> extends InheritedNotifier<E> {
  const EngineProvider({
    required E engine,
    required Widget child,
    Key? key,
  }) : super(key: key, notifier: engine, child: child);

  static E of<E extends Engine>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<
        EngineProvider<E>>();
    assert(provider != null, 'No EngineProvider found in context');
    return provider!.notifier!;
  }
}
```

**File:** `engine_builder.dart` (Flutter widget)
```dart
/// Builds UI based on engine state
class EngineBuilder<S> extends StatelessWidget {
  const EngineBuilder({
    required this.engine,
    required this.builder,
    Key? key,
  }) : super(key: key);

  final Engine<S, dynamic> engine;
  final Widget Function(BuildContext context, S state) builder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: engine as ChangeNotifier,
      builder: (context, _) {
        return builder(context, engine.state);
      },
    );
  }
}
```

### Actions
1. Create all model files under `lib/src/models/feature/`
2. Create all runtime files under `lib/src/runtime/`
3. Run `dart run build_runner build` (for Freezed)
4. Write unit tests for runtime (Engine dispatch, EngineBuilder)

### Validation
- [ ] All models compile
- [ ] Freezed generation works
- [ ] EngineImpl can dispatch intents
- [ ] EngineProvider/Builder work in Flutter
- [ ] Unit tests pass (basic engine behavior)

**Session 1 Output:** ~800 lines of foundation code

---

## SESSION 2: Feature DSL Parser

**Duration:** 3-4 hours
**Goal:** Parse FeatureDefinition from Dart files

### Deliverables

#### 1. Feature Parser (`lib/src/parser/`)

**File:** `feature_parser.dart`
```dart
/// Parses FeatureDefinition from Dart source code
class FeatureParser {
  final FileSystem fileSystem;

  FeatureParser({required this.fileSystem});

  /// Parse a .feature.dart file
  Future<FeatureDefinition> parseFeature(String filePath) async {
    final content = await fileSystem.readFile(filePath);
    final parseResult = parseString(content: content);

    final visitor = FeatureDefinitionVisitor();
    parseResult.unit.accept(visitor);

    if (visitor.feature == null) {
      throw Exception('No FeatureDefinition found in $filePath');
    }

    return visitor.feature!;
  }
}
```

**File:** `feature_definition_visitor.dart`
```dart
/// Extracts FeatureDefinition from AST
class FeatureDefinitionVisitor extends RecursiveAstVisitor<void> {
  FeatureDefinition? feature;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name == 'FeatureDefinition') {
      feature = _extractFeatureDefinition(node);
    }
    super.visitMethodInvocation(node);
  }

  FeatureDefinition _extractFeatureDefinition(MethodInvocation node) {
    final args = node.argumentList.arguments;

    // Extract named arguments
    final nameArg = _findNamedArg(args, 'name');
    final statesArg = _findNamedArg(args, 'states');
    final intentsArg = _findNamedArg(args, 'intents');
    final transitionsArg = _findNamedArg(args, 'transitions');

    return FeatureDefinition(
      name: _extractStringLiteral(nameArg),
      states: _extractStates(statesArg),
      intents: _extractIntents(intentsArg),
      transitions: _extractTransitions(transitionsArg),
    );
  }

  List<StateDefinition> _extractStates(Expression? expr) {
    // Parse list of StateDefinition calls
    // ...
  }

  // Similar for intents, transitions
}
```

#### 2. State Machine Validator (`lib/src/validation/`)

**File:** `state_machine_validator.dart`
```dart
/// Validates state machine correctness
class StateMachineValidator {
  List<ValidationError> validate(FeatureDefinition feature) {
    final errors = <ValidationError>[];

    // Rule 1: All states referenced in transitions must exist
    for (final transition in feature.transitions) {
      if (!_stateExists(feature, transition.fromState)) {
        errors.add(ValidationError(
          'Unknown state: ${transition.fromState}',
          severity: ErrorSeverity.error,
        ));
      }
      if (!_stateExists(feature, transition.toState)) {
        errors.add(ValidationError(
          'Unknown state: ${transition.toState}',
          severity: ErrorSeverity.error,
        ));
      }
    }

    // Rule 2: All intents referenced in transitions must exist
    for (final transition in feature.transitions) {
      if (!_intentExists(feature, transition.onIntent)) {
        errors.add(ValidationError(
          'Unknown intent: ${transition.onIntent}',
          severity: ErrorSeverity.error,
        ));
      }
    }

    // Rule 3: Warn about unreachable states
    final reachableStates = _computeReachableStates(feature);
    for (final state in feature.states) {
      if (!reachableStates.contains(state.name)) {
        errors.add(ValidationError(
          'Unreachable state: ${state.name}',
          severity: ErrorSeverity.warning,
        ));
      }
    }

    // Rule 4: Check for ambiguous transitions
    final ambiguous = _findAmbiguousTransitions(feature);
    for (final pair in ambiguous) {
      errors.add(ValidationError(
        'Ambiguous transition: ${pair.$1} + ${pair.$2}',
        severity: ErrorSeverity.error,
      ));
    }

    return errors;
  }

  bool _stateExists(FeatureDefinition feature, String stateName) {
    return feature.states.any((s) => s.name == stateName);
  }

  Set<String> _computeReachableStates(FeatureDefinition feature) {
    // BFS from initial state (first state in list)
    final reachable = <String>{};
    final queue = <String>[feature.states.first.name];

    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      if (reachable.contains(current)) continue;

      reachable.add(current);

      // Add all states reachable via transitions
      for (final transition in feature.transitions) {
        if (transition.fromState == current) {
          queue.add(transition.toState);
        }
      }
    }

    return reachable;
  }
}
```

### Actions
1. Implement FeatureParser using Dart analyzer
2. Implement StateMachineValidator with 4+ validation rules
3. Write tests for parser (parse valid/invalid features)
4. Write tests for validator (detect errors/warnings)

### Validation
- [ ] Can parse FeatureDefinition from Dart file
- [ ] Detects missing states/intents
- [ ] Warns about unreachable states
- [ ] Detects ambiguous transitions
- [ ] Parser tests pass (10+ cases)
- [ ] Validator tests pass (15+ rules)

**Session 2 Output:** ~600 lines (parser + validator)

---

## SESSION 3: State & Intent Code Generators

**Duration:** 3-4 hours
**Goal:** Generate sealed classes for states and intents

### Deliverables

#### 1. State Generator (`lib/src/generators/`)

**File:** `state_generator.dart`
```dart
/// Generates sealed state classes
class StateGenerator {
  final DartFormatter _formatter = DartFormatter();
  final DartEmitter _emitter = DartEmitter(useNullSafetySyntax: true);

  String generate(FeatureDefinition feature) {
    final library = Library(
      (b) => b
        ..comments.addAll(_generateHeader(feature))
        ..body.addAll([
          // Sealed base class
          _generateSealedBase(feature),
          // State implementations
          ..._generateStateClasses(feature),
        ]),
    );

    final code = library.accept(_emitter).toString();
    return _formatter.format(code);
  }

  Class _generateSealedBase(FeatureDefinition feature) {
    final className = '${feature.name}State';

    return Class(
      (b) => b
        ..name = className
        ..modifier = ClassModifier.sealed
        ..docs.add('/// State for ${feature.name} feature')
        ..constructors.add(
          Constructor((b) => b..constant = true),
        ),
    );
  }

  List<Class> _generateStateClasses(FeatureDefinition feature) {
    return feature.states.map((state) {
      final className = state.name;
      final baseClass = '${feature.name}State';

      return Class(
        (b) => b
          ..name = className
          ..extend = refer(baseClass)
          ..docs.add('/// ${state.description ?? className}')
          ..fields.addAll(_generateFields(state.fields))
          ..constructors.add(_generateConstructor(state)),
      );
    }).toList();
  }

  Constructor _generateConstructor(StateDefinition state) {
    return Constructor(
      (b) => b
        ..constant = state.fields.isEmpty
        ..optionalParameters.addAll(
          state.fields.map(
            (field) => Parameter(
              (p) => p
                ..name = field.name
                ..named = true
                ..required = field.defaultValue == null
                ..toThis = true
                ..defaultTo = field.defaultValue != null
                    ? Code(field.defaultValue!)
                    : null,
            ),
          ),
        ),
    );
  }
}
```

#### 2. Intent Generator

**File:** `intent_generator.dart`
```dart
/// Generates sealed intent classes
class IntentGenerator {
  // Similar structure to StateGenerator
  String generate(FeatureDefinition feature) {
    // Generate sealed IntentBase + intent classes
  }
}
```

### Actions
1. Implement StateGenerator using code_builder
2. Implement IntentGenerator
3. Write golden tests (snapshot generated code)
4. Test with booking example

### Validation
- [ ] Generates sealed state classes
- [ ] Generates sealed intent classes
- [ ] Handles fields with defaults
- [ ] Generated code compiles
- [ ] Golden tests match snapshots
- [ ] Booking example works

**Session 3 Output:** ~500 lines (state + intent generators)

---

## SESSION 4: Engine Generator

**Duration:** 3-4 hours
**Goal:** Generate Engine with reduce() method

### Deliverables

#### 1. Engine Generator (`lib/src/generators/`)

**File:** `engine_generator.dart`
```dart
/// Generates feature engine with reducer
class EngineGenerator {
  String generate(FeatureDefinition feature) {
    final library = Library(
      (b) => b
        ..comments.addAll(_generateHeader(feature))
        ..directives.addAll([
          Directive.import('package:flutter/foundation.dart'),
          Directive.import('../runtime/engine.dart'),
          Directive.import('../runtime/reduce_result.dart'),
          Directive.import('../runtime/effect.dart'),
          Directive.import('${_toSnakeCase(feature.name)}_state.dart'),
          Directive.import('${_toSnakeCase(feature.name)}_intent.dart'),
        ])
        ..body.add(_generateEngineClass(feature)),
    );

    final code = library.accept(_emitter).toString();
    return _formatter.format(code);
  }

  Class _generateEngineClass(FeatureDefinition feature) {
    final className = '${feature.name}Engine';
    final stateType = '${feature.name}State';
    final intentType = '${feature.name}Intent';

    return Class(
      (b) => b
        ..name = className
        ..extend = refer('ChangeNotifier')
        ..implements.add(refer('Engine<$stateType, $intentType>'))
        ..fields.addAll([
          _generateStateField(feature),
          _generateEffectRunnerField(),
        ])
        ..constructors.add(_generateConstructor(feature))
        ..methods.addAll([
          _generateInitialStateGetter(feature),
          _generateStateGetter(),
          _generateDispatchMethod(),
          _generateReduceMethod(feature),
          _generateExecuteEffectMethod(),
        ]),
    );
  }

  Method _generateReduceMethod(FeatureDefinition feature) {
    // Generate exhaustive pattern matching for all transitions
    final cases = feature.transitions.map((transition) {
      return _generateTransitionCase(transition, feature);
    }).join('\n');

    return Method(
      (b) => b
        ..name = 'reduce'
        ..annotations.add(refer('override'))
        ..returns = refer('ReduceResult<${feature.name}State>')
        ..requiredParameters.addAll([
          Parameter((p) => p..name = 'state'..type = refer('${feature.name}State')),
          Parameter((p) => p..name = 'intent'..type = refer('${feature.name}Intent')),
        ])
        ..body = Code('''
          return switch ((state, intent)) {
            $cases
            _ => ReduceResult(state),
          };
        '''),
    );
  }

  String _generateTransitionCase(
    TransitionDefinition transition,
    FeatureDefinition feature,
  ) {
    final fromState = transition.fromState;
    final toState = transition.toState;
    final onIntent = transition.onIntent;

    // Find state/intent definitions to get fields
    final toStateDef = feature.states.firstWhere((s) => s.name == toState);
    final intentDef = feature.intents.firstWhere((i) => i.name == onIntent);

    // Extract field names from intent
    final intentFields = intentDef.inputs.map((f) => ':final ${f.name}').join(', ');

    // Construct new state with fields
    final stateFields = toStateDef.fields.map((field) {
      // Try to map from intent input or previous state
      return '${field.name}: ${_resolveFieldSource(field, transition, feature)}';
    }).join(', ');

    // Generate effects
    final effects = transition.effects.map(_generateEffect).join(', ');

    return '''
      ($fromState(), $onIntent($intentFields)) => ReduceResult(
        $toState($stateFields),
        [$effects],
      ),
    ''';
  }

  String _resolveFieldSource(
    FieldDefinition field,
    TransitionDefinition transition,
    FeatureDefinition feature,
  ) {
    // Try to find field in intent inputs
    final intent = feature.intents.firstWhere((i) => i.name == transition.onIntent);
    if (intent.inputs.any((f) => f.name == field.name)) {
      return field.name; // From intent
    }

    // Try to find field in fromState
    final fromState = feature.states.firstWhere((s) => s.name == transition.fromState);
    if (fromState.fields.any((f) => f.name == field.name)) {
      return 'state.${field.name}'; // From previous state
    }

    // Fallback to default or null
    return field.defaultValue ?? 'null';
  }

  String _generateEffect(EffectType effect) {
    if (effect is NavigateEffect) {
      return "Navigate('${effect.route}')";
    } else if (effect is CustomEffect) {
      return "Custom('${effect.name}')";
    }
    return '';
  }
}
```

### Actions
1. Implement EngineGenerator
2. Generate exhaustive pattern matching for transitions
3. Handle field resolution (from intent or previous state)
4. Generate effect instantiation
5. Write tests for generated engines

### Validation
- [ ] Generates working engine class
- [ ] reduce() handles all transitions
- [ ] Exhaustive pattern matching (no missing cases)
- [ ] Effects are generated correctly
- [ ] Field resolution works (intent → state → default)
- [ ] Generated engine compiles and runs

**Session 4 Output:** ~800 lines (complex generator logic)

---

## SESSION 5: Build Pipeline Integration

**Duration:** 3-4 hours
**Goal:** Integrate into `syntaxify build` command

### Deliverables

#### 1. Feature Build Use Case (`lib/src/use_cases/`)

**File:** `build_features_use_case.dart`
```dart
class BuildFeaturesUseCase {
  final FileSystem fileSystem;
  final FeatureParser parser;
  final StateMachineValidator validator;
  final StateGenerator stateGenerator;
  final IntentGenerator intentGenerator;
  final EngineGenerator engineGenerator;
  final Logger logger;

  BuildFeaturesUseCase({
    required this.fileSystem,
    required this.parser,
    required this.validator,
    required this.stateGenerator,
    required this.intentGenerator,
    required this.engineGenerator,
    required this.logger,
  });

  Future<BuildResult> execute(BuildContext context) async {
    final errors = <String>[];
    final warnings = <String>[];

    // 1. Find all .feature.dart files
    final featureFiles = await fileSystem.glob('**/*.feature.dart');
    logger.info('Found ${featureFiles.length} feature definitions');

    for (final featureFile in featureFiles) {
      try {
        // 2. Parse feature definition
        final feature = await parser.parseFeature(featureFile);
        logger.detail('Parsing ${feature.name} feature');

        // 3. Validate state machine
        final validationErrors = validator.validate(feature);
        for (final error in validationErrors) {
          if (error.severity == ErrorSeverity.error) {
            errors.add('${feature.name}: ${error.message}');
          } else {
            warnings.add('${feature.name}: ${error.message}');
          }
        }

        if (validationErrors.any((e) => e.severity == ErrorSeverity.error)) {
          continue; // Skip generation if validation failed
        }

        // 4. Generate state classes
        final stateCode = stateGenerator.generate(feature);
        final statePath = context.join(
          context.outputDir,
          'features',
          '${_toSnakeCase(feature.name)}_state.dart',
        );
        await fileSystem.writeFile(statePath, stateCode);
        logger.success('Generated ${feature.name} states');

        // 5. Generate intent classes
        final intentCode = intentGenerator.generate(feature);
        final intentPath = context.join(
          context.outputDir,
          'features',
          '${_toSnakeCase(feature.name)}_intent.dart',
        );
        await fileSystem.writeFile(intentPath, intentCode);
        logger.success('Generated ${feature.name} intents');

        // 6. Generate engine
        final engineCode = engineGenerator.generate(feature);
        final enginePath = context.join(
          context.outputDir,
          'features',
          '${_toSnakeCase(feature.name)}_engine.dart',
        );
        await fileSystem.writeFile(enginePath, engineCode);
        logger.success('Generated ${feature.name} engine');

      } catch (e) {
        errors.add('Failed to build ${featureFile}: $e');
        logger.error('Failed to build ${featureFile}', error: e);
      }
    }

    return BuildResult(
      success: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }
}
```

#### 2. Update build_all.dart

Add feature building step:
```dart
// After component building
logger.section('Building Features');
final featureBuildResult = await buildFeaturesUseCase.execute(context);
if (!featureBuildResult.success) {
  // Handle errors
}
```

### Actions
1. Create BuildFeaturesUseCase
2. Integrate into build_all.dart
3. Update CLI to support features
4. Test with booking example

### Validation
- [ ] `dart run syntaxify build` processes .feature.dart files
- [ ] Generated code appears in lib/syntaxify/features/
- [ ] Validation errors shown to user
- [ ] Warnings displayed but don't block build
- [ ] Booking example builds successfully

**Session 5 Output:** ~400 lines (integration)

---

## SESSION 6: Booking Example + Documentation

**Duration:** 2-3 hours
**Goal:** Complete working example + user docs

### Deliverables

#### 1. Booking Example

**File:** `example/features/booking.feature.dart`
```dart
// Full booking feature definition from OVERVIEW.md
```

**File:** `example/lib/booking_effects.dart`
```dart
// User-implemented effect runner
class BookingEffectRunner extends EffectRunner {
  final BookingApi api;

  BookingEffectRunner(this.api);

  @override
  Future<void> run(Effect effect, EngineDispatcher dispatch) async {
    if (effect is Custom && effect.name == 'StartBooking') {
      final engine = /* get engine somehow */;
      final state = engine.state as BookingInProgress;

      try {
        final booking = await api.bookService(
          service: state.service,
          slot: state.slot,
        );
        dispatch(BookingConfirmed(booking));
      } catch (e) {
        dispatch(BookingFailed(e.toString()));
      }
    }
  }
}
```

**File:** `example/lib/screens/home_screen.dart`
```dart
// 4 screens using generated engine
```

#### 2. Documentation

**File:** `generator/docs/state_machines.md`
```markdown
# State Machines Guide

## Introduction

Syntaxify State Machine Compiler generates complete state management code...

## Quick Start

1. Create a feature definition...
2. Run `dart run syntaxify build`...
3. Implement effect runner...
4. Use in screens...

## Concepts

### State
### Intent
### Engine
### Effects

## Examples

### Simple Counter
### Todo List
### Booking Flow

## Best Practices

### When to Use State Machines
### Structuring Features
### Testing Strategies
```

### Actions
1. Complete booking example (4 screens)
2. Write state machines guide
3. Update main README with state machine section
4. Create video/GIF demo

### Validation
- [ ] Booking example runs in example app
- [ ] Can complete full booking flow
- [ ] Documentation is clear
- [ ] README updated

**Session 6 Output:** ~600 lines (example + docs)

---

## SESSION 7: Testing & Validation

**Duration:** 2-3 hours
**Goal:** Comprehensive test coverage

### Deliverables

#### 1. Unit Tests

**File:** `test/generators/state_generator_test.dart`
```dart
void main() {
  group('StateGenerator', () {
    test('generates sealed base class', () { });
    test('generates state implementations', () { });
    test('handles fields correctly', () { });
    // ...
  });
}
```

**File:** `test/generators/engine_generator_test.dart`
```dart
void main() {
  group('EngineGenerator', () {
    test('generates reduce method', () { });
    test('handles all transitions', () { });
    test('resolves fields from intent', () { });
    // ...
  });
}
```

#### 2. Integration Tests

**File:** `test/integration/state_machine_e2e_test.dart`
```dart
void main() {
  test('End-to-end booking feature', () async {
    // 1. Parse feature definition
    final feature = await parser.parseFeature('test/fixtures/booking.feature.dart');

    // 2. Validate
    final errors = validator.validate(feature);
    expect(errors, isEmpty);

    // 3. Generate code
    final stateCode = stateGenerator.generate(feature);
    final intentCode = intentGenerator.generate(feature);
    final engineCode = engineGenerator.generate(feature);

    // 4. Write to temp directory
    // 5. Compile generated code
    // 6. Test engine behavior
  });
}
```

#### 3. Golden Tests

**File:** `test/golden/booking_feature_golden_test.dart`
```dart
void main() {
  test('Booking state generation matches snapshot', () {
    final generated = stateGenerator.generate(bookingFeature);
    expectGolden(generated, 'booking_state.dart.golden');
  });
}
```

### Actions
1. Write 30+ unit tests for generators
2. Write 5+ integration tests
3. Write 10+ golden tests
4. Achieve 80%+ coverage

### Validation
- [ ] All tests pass
- [ ] 80%+ code coverage
- [ ] Golden tests track regressions
- [ ] Integration tests validate end-to-end

**Session 7 Output:** ~800 lines (tests)

---

## Total Effort Summary

| Session | Focus | Lines | Time |
|---------|-------|-------|------|
| 1 | Models + Runtime | 800 | 2-3h |
| 2 | Parser + Validator | 600 | 3-4h |
| 3 | State/Intent Generators | 500 | 3-4h |
| 4 | Engine Generator | 800 | 3-4h |
| 5 | Integration | 400 | 3-4h |
| 6 | Example + Docs | 600 | 2-3h |
| 7 | Testing | 800 | 2-3h |
| **Total** | **Complete MVP** | **~4,500** | **18-25h** |

---

## Risk Mitigation

### Risk 1: Parser Complexity
**Mitigation:** Use Dart analyzer (proven), focus on simple DSL first

### Risk 2: Field Resolution
**Mitigation:** Start with explicit field mapping, add smart inference later

### Risk 3: Effect Execution
**Mitigation:** Keep minimal, user implements business logic

### Risk 4: Testing Generated Code
**Mitigation:** Use golden tests, compile generated code in tests

---

## Success Criteria

- [ ] Can define booking feature in <100 lines
- [ ] Generated code compiles without errors
- [ ] Booking flow works end-to-end
- [ ] Zero callbacks in screen code
- [ ] Tests pass with 80%+ coverage
- [ ] Documentation is clear and complete

---

## Next Phase (Optional)

**Session 8-10:** Advanced Features
- State diagram visualization
- Time-travel debugging
- DevTools integration
- More examples (auth, cart, chat)

**This plan is READY TO EXECUTE.**

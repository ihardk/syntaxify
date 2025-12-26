# Annotation-Based State Machine Compiler: Missing Components

**Created:** 2025-12-26
**Context:** What's missing from the annotation-based approach vs v1+ architecture
**Status:** Gap analysis for implementation

---

## 📋 Overview

We pivoted from **DSL-based** (`FeatureDefinition()`) to **annotation-based** (`@Feature`) approach.

**Why annotation-based is better:**
- ✅ Type-safe (compile-time errors)
- ✅ IDE autocomplete works
- ✅ Familiar pattern (like Freezed/JsonSerializable)
- ✅ No new syntax to learn
- ✅ Lower learning curve

**Viability:** 8/10 (vs 6/10 for DSL)

---

## 🔴 CRITICAL GAPS (Must Implement for MVP)

### GAP #1: Annotation Definitions
**Status:** ❌ NOT DEFINED

**Missing:** The actual annotation classes

**Need:**
```dart
// lib/src/annotations/feature.dart
class Feature {
  final String name;
  final String? description;

  const Feature(this.name, {this.description});
}

class State {
  final String? name;  // Optional - infer from class name
  final bool isInitial;

  const State({this.name, this.isInitial = false});
}

class Transition {
  final Type from;
  final Type on;
  final String? guard;  // Optional guard function name

  const Transition({required this.from, required this.on, this.guard});
}

class Effect {
  final String type;  // 'Navigate', 'Custom', 'ShowDialog'
  final Map<String, dynamic>? data;

  const Effect(this.type, {this.data});
}

class Guard {
  const Guard();
}

class EffectHandler {
  const EffectHandler();
}
```

**Impact:** CRITICAL - Can't write features without these
**Effort:** 1-2h

---

### GAP #2: Annotation Parser
**Status:** ❌ NOT IMPLEMENTED

**Missing:** Parser that reads annotated classes and builds internal model

**Need:**
```dart
// lib/src/parser/annotation_parser.dart
class AnnotationParser {
  /// Parse a .feature.dart file and extract feature definition
  FeatureModel parse(String filePath);
}

class FeatureModel {
  final String name;
  final List<StateModel> states;
  final List<IntentModel> intents;
  final List<TransitionModel> transitions;
  final Map<String, GuardModel> guards;
  final Map<String, EffectHandlerModel> effectHandlers;
}
```

**Implementation Steps:**
1. Use Dart `analyzer` package to parse file
2. Find classes with `@Feature` annotation
3. Extract `@State` methods/getters → StateModel
4. Extract `@Transition` methods → TransitionModel + IntentModel
5. Extract `@Effect` annotations → effect metadata
6. Extract `@Guard` methods → GuardModel
7. Build complete FeatureModel

**Similar to:** `ComponentExtractor` in current Syntaxify

**Impact:** CRITICAL - Core of the compiler
**Effort:** 6-8h

---

### GAP #3: Field Resolution Strategy
**Status:** ❌ NOT DEFINED

**Missing:** How to determine state fields from annotations

**Problem:**
```dart
@Feature('Booking')
class BookingFeature {
  @Transition(from: BookingIdle, on: SelectService)
  ServiceSelected selectService(Service service) {
    return ServiceSelected(service);  // ← Where does 'service' field come from?
  }
}
```

**Options:**

**Option A: Infer from return statement**
```dart
ServiceSelected selectService(Service service) {
  return ServiceSelected(service);  // Analyze AST: service field inferred
}
```

**Option B: Explicit field annotation**
```dart
@Transition(from: BookingIdle, on: SelectService)
@StateFields(['service'])  // ← Explicit
ServiceSelected selectService(Service service) {
  return ServiceSelected(service);
}
```

**Option C: Analyze constructor (RECOMMENDED)**
```dart
// Parser analyzes ServiceSelected class constructor
class ServiceSelected extends BookingState {
  final Service service;
  const ServiceSelected(this.service);
}
// Infer: ServiceSelected requires 'service' field
```

**Recommendation:** Option C (analyze generated state class constructor)

**Impact:** CRITICAL - Determines state class structure
**Effort:** 3-4h

---

### GAP #4: Effect Expression in Annotations
**Status:** ❌ NOT DEFINED

**Missing:** How to attach effects to transitions

**Problem:**
```dart
@Transition(from: BookingIdle, on: SelectService)
ServiceSelected selectService(Service service) {
  // ❓ How to specify Navigate('/schedule') effect?
  return ServiceSelected(service);
}
```

**Options:**

**Option A: @Effect annotation on method**
```dart
@Transition(from: BookingIdle, on: SelectService)
@Effect('Navigate', route: '/schedule')
ServiceSelected selectService(Service service) {
  return ServiceSelected(service);
}
```

**Option B: Return ReduceResult explicitly**
```dart
@Transition(from: BookingIdle, on: SelectService)
ReduceResult<BookingState> selectService(Service service) {
  return ReduceResult(
    ServiceSelected(service),
    [Navigate('/schedule')],
  );
}
```

**Option C: Multiple @Effect annotations**
```dart
@Transition(from: BookingIdle, on: SelectService)
@Navigate('/schedule')
@Custom('trackSelection')
ServiceSelected selectService(Service service) {
  return ServiceSelected(service);
}
```

**Recommendation:** Option C (most declarative, multiple effects easy)

**Impact:** CRITICAL - Core feature
**Effort:** 2-3h

---

### GAP #5: State/Intent/Engine Generators
**Status:** ❌ NOT IMPLEMENTED

**Missing:** Code generators that output Flutter code

**Need:**

**5.1 State Generator**
```dart
// lib/src/generators/state_generator.dart
class StateGenerator {
  /// Generate sealed state class from FeatureModel
  String generate(FeatureModel feature) {
    // Output:
    // sealed class BookingState {}
    // class BookingIdle extends BookingState { ... }
    // class ServiceSelected extends BookingState { final Service service; ... }
  }
}
```

**5.2 Intent Generator**
```dart
class IntentGenerator {
  /// Generate sealed intent class from FeatureModel
  String generate(FeatureModel feature) {
    // Output:
    // sealed class BookingIntent {}
    // class SelectService extends BookingIntent { final Service service; ... }
  }
}
```

**5.3 Engine Generator**
```dart
class EngineGenerator {
  /// Generate Engine with reducer from FeatureModel
  String generate(FeatureModel feature) {
    // Output:
    // class BookingEngine extends Engine<BookingState, BookingIntent> {
    //   @override
    //   BookingState get initialState => BookingIdle();
    //
    //   @override
    //   ReduceResult<BookingState> reduce(BookingState state, BookingIntent intent) {
    //     return switch ((state, intent)) {
    //       (BookingIdle(), SelectService(:final service)) => ReduceResult(
    //         ServiceSelected(service),
    //         [Navigate('/schedule')],
    //       ),
    //       _ => ReduceResult(state),
    //     };
    //   }
    // }
  }
}
```

**Similar to:** Current Syntaxify component generators

**Impact:** CRITICAL - Core output
**Effort:** 10-12h (split across 3 generators)

---

### GAP #6: Flutter Integration Generators
**Status:** ❌ NOT IMPLEMENTED

**Missing:** Generate EngineBuilder, EngineProvider, Selectors, Context Extensions

**Need:**

**6.1 EngineProvider Generator**
```dart
// Generated: lib/syntaxify/generated/booking/booking_provider.dart
class BookingEngineProvider extends InheritedNotifier<BookingEngine> {
  const BookingEngineProvider({
    required BookingEngine engine,
    required Widget child,
    Key? key,
  }) : super(key: key, notifier: engine, child: child);

  static BookingEngine of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BookingEngineProvider>();
    return provider!.notifier!;
  }
}
```

**6.2 EngineBuilder Generator**
```dart
class BookingStateBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BookingState state) builder;

  @override
  Widget build(BuildContext context) {
    final engine = BookingEngineProvider.of(context);
    return ListenableBuilder(
      listenable: engine,
      builder: (context, _) => builder(context, engine.state),
    );
  }
}
```

**6.3 Selector Generator**
```dart
class BookingStateSelector<T> extends StatelessWidget {
  final T Function(BookingState state) selector;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    final engine = BookingEngineProvider.of(context);
    return ListenableBuilder(
      listenable: engine,
      builder: (context, _) {
        final value = selector(engine.state);
        return builder(context, value);
      },
    );
  }
}
```

**6.4 Context Extension Generator**
```dart
extension BookingStateContext on BuildContext {
  BookingEngine get bookingEngine => BookingEngineProvider.of(this);
  BookingState get bookingState => bookingEngine.state;

  void dispatchBookingIntent(BookingIntent intent) {
    bookingEngine.dispatch(intent);
  }

  T watchBookingState<T>(T Function(BookingState state) selector) {
    // Implementation with ListenableBuilder
  }
}
```

**Impact:** HIGH - Critical for DX
**Effort:** 6-8h

---

### GAP #7: Runtime Library
**Status:** ❌ NOT IMPLEMENTED

**Missing:** The base Engine, ReduceResult, Effect classes

**Need:**
```dart
// lib/syntaxify/runtime/engine.dart
abstract class Engine<S, I> extends ChangeNotifier {
  S get state;
  S get initialState;

  ReduceResult<S> reduce(S state, I intent);

  void dispatch(I intent);
}

// lib/syntaxify/runtime/reduce_result.dart
class ReduceResult<S> {
  final S state;
  final List<Effect> effects;

  const ReduceResult(this.state, [this.effects = const []]);
}

// lib/syntaxify/runtime/effect.dart
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

class ShowDialog extends Effect {
  final String message;
  final String? title;

  const ShowDialog(this.message, {this.title});
}

// lib/syntaxify/runtime/effect_runner.dart
abstract class EffectRunner {
  Future<void> run(Effect effect, void Function(dynamic) dispatch);
}
```

**Impact:** CRITICAL - Foundation
**Effort:** 4-5h

---

### GAP #8: Build System Integration
**Status:** ❌ NOT INTEGRATED

**Missing:** How annotation-based compiler integrates with `syntaxify build`

**Need:**

**8.1 Feature File Detection**
```dart
// Update lib/src/use_cases/build_all.dart
final featureFiles = await _findFeatureFiles(config);

Future<List<String>> _findFeatureFiles(SyntaxifyConfig config) async {
  // Find all *.feature.dart files
  // Similar to how we find *.meta.dart files
}
```

**8.2 Feature Build Pipeline**
```dart
// For each .feature.dart file:
// 1. Parse annotations → FeatureModel
// 2. Validate transitions, states, etc.
// 3. Generate state classes → lib/syntaxify/generated/{feature}/states.dart
// 4. Generate intent classes → lib/syntaxify/generated/{feature}/intents.dart
// 5. Generate engine → lib/syntaxify/generated/{feature}/engine.dart
// 6. Generate Flutter integration → lib/syntaxify/generated/{feature}/widgets.dart
// 7. Write files to disk
```

**8.3 Watch Mode Support**
```dart
// syntaxify build --watch
// Should rebuild when .feature.dart files change
```

**Impact:** CRITICAL - Makes it usable
**Effort:** 3-4h

---

### GAP #9: Validation System
**Status:** ❌ NOT IMPLEMENTED

**Missing:** Compile-time validation of state machine

**Need:**
```dart
// lib/src/validation/feature_validator.dart
class FeatureValidator {
  List<ValidationError> validate(FeatureModel feature) {
    final errors = <ValidationError>[];

    // 1. Check for duplicate state names
    // 2. Check for ambiguous transitions (same from+on)
    // 3. Check for unknown states in transitions
    // 4. Check for unreachable states
    // 5. Check for missing initial state
    // 6. Check for field type mismatches
    // 7. Check for circular dependencies

    return errors;
  }
}

class ValidationError {
  final String message;
  final String? suggestion;
  final String? filePath;
  final int? line;
}
```

**Error Examples:**
```
❌ ERROR: Unknown state 'Procesing' in transition
   → Did you mean 'Processing'?
   at booking.feature.dart:15

❌ ERROR: Ambiguous transition
   from: Idle, on: SelectService → ServiceSelected
   from: Idle, on: SelectService → Loading
   at booking.feature.dart:20

⚠️  WARNING: Unreachable state 'Orphan'
   No transitions lead to this state
   at booking.feature.dart:25
```

**Impact:** HIGH - Prevents bugs
**Effort:** 4-5h

---

### GAP #10: Testing Infrastructure
**Status:** ❌ NOT IMPLEMENTED

**Missing:** Tests for annotation parsing, code generation, runtime

**Need:**

**10.1 Annotation Parser Tests**
```dart
// test/parser/annotation_parser_test.dart
void main() {
  group('AnnotationParser', () {
    test('parses @Feature annotation', () { ... });
    test('parses @State getters', () { ... });
    test('parses @Transition methods', () { ... });
    test('infers intent from method parameters', () { ... });
    test('extracts @Effect annotations', () { ... });
    test('handles guards', () { ... });
  });
}
```

**10.2 Generator Tests**
```dart
// test/generators/state_generator_test.dart
void main() {
  group('StateGenerator', () {
    test('generates sealed state class', () { ... });
    test('generates state subclasses with fields', () { ... });
    test('generates copyWith methods', () { ... });
    test('generates toString methods', () { ... });
  });
}
```

**10.3 Runtime Tests**
```dart
// test/runtime/engine_test.dart
void main() {
  group('Engine', () {
    test('initializes with initial state', () { ... });
    test('dispatch() updates state', () { ... });
    test('dispatch() executes effects', () { ... });
    test('notifyListeners() called on state change', () { ... });
  });
}
```

**10.4 Integration Tests**
```dart
// test/integration/booking_feature_e2e_test.dart
void main() {
  group('Booking Feature E2E', () {
    test('complete flow from idle to confirmed', () {
      final engine = BookingEngine();

      // Initial
      expect(engine.state, isA<BookingIdle>());

      // Select service
      engine.dispatch(SelectService(massage));
      expect(engine.state, isA<ServiceSelected>());

      // Select schedule
      engine.dispatch(SelectSchedule(slot));
      expect(engine.state, isA<ScheduleSelected>());

      // Confirm
      engine.dispatch(ConfirmBooking());
      expect(engine.state, isA<BookingConfirmed>());
    });
  });
}
```

**Impact:** HIGH - Ensures correctness
**Effort:** 8-10h

---

### GAP #11: Documentation & Examples
**Status:** ❌ NOT CREATED

**Missing:** User guide, API reference, examples

**Need:**

**11.1 User Guide**
```markdown
# State Machine Compiler User Guide

## Quick Start

1. Create a feature file:

```dart
// lib/features/booking.feature.dart
import 'package:syntaxify/syntaxify.dart';

@Feature('Booking')
class BookingFeature {
  @State(isInitial: true)
  BookingIdle get idle => BookingIdle();

  @Transition(from: BookingIdle, on: SelectService)
  @Navigate('/schedule')
  ServiceSelected selectService(Service service) {
    return ServiceSelected(service);
  }
}
```

2. Run build:
```bash
syntaxify build
```

3. Use in app:
```dart
BookingEngineProvider(
  engine: BookingEngine(),
  child: BookingStateBuilder(
    builder: (context, state) => switch (state) {
      BookingIdle() => ServiceListScreen(),
      ServiceSelected() => ScheduleScreen(),
      // ...
    },
  ),
)
```
```

**11.2 API Reference**
- Annotation reference (@Feature, @State, @Transition, @Effect, @Guard)
- Runtime API (Engine, ReduceResult, Effect types)
- Flutter widgets (EngineProvider, EngineBuilder, Selectors)

**11.3 Examples**
- Simple counter (hello world)
- Todo list (CRUD)
- Auth flow (async effects)
- Booking flow (multi-screen)
- Shopping cart (complex state)

**Impact:** HIGH - Determines adoption
**Effort:** 6-8h

---

## 🟡 HIGH PRIORITY GAPS (Needed Soon)

### GAP #12: Guard Implementation
**Status:** ❌ NOT IMPLEMENTED

**Missing:** How guards are defined and used

**Need:**
```dart
@Feature('Booking')
class BookingFeature {
  @Transition(from: FormInput, on: Submit, guard: 'isFormValid')
  Submitting submit() {
    return Submitting();
  }

  @Guard()
  bool isFormValid(FormInput state, Submit intent) {
    return state.email.isNotEmpty && state.password.length >= 8;
  }
}
```

**Generated:**
```dart
class BookingEngine extends Engine<BookingState, BookingIntent> {
  @override
  ReduceResult<BookingState> reduce(BookingState state, BookingIntent intent) {
    return switch ((state, intent)) {
      (FormInput() s, Submit() i) => {
        if (_guards.isFormValid(s, i)) {
          return ReduceResult(Submitting());
        }
        return ReduceResult(state); // Guard failed, stay
      },
      // ...
    };
  }
}
```

**Impact:** MEDIUM-HIGH
**Effort:** 3-4h

---

### GAP #13: Effect Handler Implementation
**Status:** ❌ NOT IMPLEMENTED

**Missing:** How users implement custom effect handlers

**Need:**
```dart
@Feature('Booking')
class BookingFeature {
  @Transition(from: ScheduleSelected, on: ConfirmBooking)
  @Custom('startBooking')
  BookingInProgress confirmBooking() {
    return BookingInProgress();
  }

  @EffectHandler()
  Future<void> startBooking(Custom effect, void Function(BookingIntent) dispatch) async {
    final data = effect.data!;
    final service = data['service'] as Service;
    final slot = data['slot'] as DateTime;

    try {
      final booking = await api.createBooking(service, slot);
      dispatch(BookingSuccess(booking));
    } catch (e) {
      dispatch(BookingFailed(e.toString()));
    }
  }
}
```

**Generated Engine Integration:**
```dart
class BookingEngine extends Engine<BookingState, BookingIntent> {
  final BookingFeature _feature = BookingFeature();

  Future<void> _executeEffect(Effect effect) async {
    if (effect is Custom && effect.name == 'startBooking') {
      await _feature.startBooking(effect, dispatch);
    }
    // ... other effects
  }
}
```

**Impact:** HIGH - Core feature
**Effort:** 4-5h

---

### GAP #14: Selector Optimization
**Status:** ❌ NOT IMPLEMENTED

**Missing:** Efficient selector implementation (prevent unnecessary rebuilds)

**Need:**
```dart
class BookingStateSelector<T> extends StatefulWidget {
  final T Function(BookingState state) selector;
  final Widget Function(BuildContext context, T value) builder;

  @override
  State<BookingStateSelector<T>> createState() => _BookingStateSelectorState<T>();
}

class _BookingStateSelectorState<T> extends State<BookingStateSelector<T>> {
  late T _previousValue;

  @override
  void initState() {
    super.initState();
    final engine = BookingEngineProvider.of(context);
    _previousValue = widget.selector(engine.state);
  }

  @override
  Widget build(BuildContext context) {
    final engine = BookingEngineProvider.of(context);
    return ListenableBuilder(
      listenable: engine,
      builder: (context, _) {
        final newValue = widget.selector(engine.state);

        // Only rebuild if value changed
        if (newValue != _previousValue) {
          _previousValue = newValue;
        }

        return widget.builder(context, _previousValue);
      },
    );
  }
}
```

**Impact:** MEDIUM - Performance
**Effort:** 2-3h

---

### GAP #15: Error Messages & Diagnostics
**Status:** ❌ NOT IMPLEMENTED

**Missing:** Helpful error messages during build

**Need:**

**Example Good Errors:**
```
❌ ERROR: Missing initial state
   Feature 'Booking' has no state marked with @State(isInitial: true)

   Add this to one of your state getters:
   @State(isInitial: true)
   BookingIdle get idle => BookingIdle();

   at lib/features/booking.feature.dart

❌ ERROR: Transition references unknown state
   @Transition(from: BookingIdle, on: SelectService)
                     ^^^^^^^^^^^
   State 'BookingIdle' is not defined in this feature

   Did you mean one of these?
   - BookingIdleState
   - BookingLoading

   at lib/features/booking.feature.dart:15

⚠️  WARNING: Unreachable code
   State 'Orphan' has no incoming transitions
   This state will never be reached

   Consider removing it or adding a transition to it

   at lib/features/booking.feature.dart:42
```

**Impact:** HIGH - Developer experience
**Effort:** 3-4h

---

## 🟢 NICE TO HAVE GAPS (Future)

### GAP #16: State Visualization
**Status:** ❌ NOT IMPLEMENTED

**Missing:** Generate state diagrams from features

**Need:**
```bash
syntaxify diagram booking.feature.dart
# Output: booking_state_machine.svg
```

**Impact:** MEDIUM - Helps understanding
**Effort:** 3-4h
**Priority:** Can defer to post-MVP

---

### GAP #17: Time-Travel Debugging
**Status:** ❌ NOT IMPLEMENTED

**Missing:** DevTools panel for debugging

**Impact:** HIGH - Killer feature
**Effort:** 6-8h
**Priority:** HIGH but can ship without

---

### GAP #18: State Persistence
**Status:** ❌ NOT IMPLEMENTED

**Missing:** Auto-save/restore state

**Impact:** HIGH - Real apps need this
**Effort:** 6-8h
**Priority:** HIGH but can ship without

---

### GAP #19: Middleware System
**Status:** ❌ NOT IMPLEMENTED

**Missing:** Logging, analytics hooks

**Impact:** HIGH - Extensibility
**Effort:** 4-5h
**Priority:** MEDIUM

---

## 📊 Summary: What's Missing

### Must Have (MVP) - 11 Critical Gaps
| # | Gap | Effort | Status |
|---|-----|--------|--------|
| 1 | Annotation Definitions | 1-2h | ❌ |
| 2 | Annotation Parser | 6-8h | ❌ |
| 3 | Field Resolution Strategy | 3-4h | ❌ |
| 4 | Effect Expression | 2-3h | ❌ |
| 5 | State/Intent/Engine Generators | 10-12h | ❌ |
| 6 | Flutter Integration Generators | 6-8h | ❌ |
| 7 | Runtime Library | 4-5h | ❌ |
| 8 | Build System Integration | 3-4h | ❌ |
| 9 | Validation System | 4-5h | ❌ |
| 10 | Testing Infrastructure | 8-10h | ❌ |
| 11 | Documentation & Examples | 6-8h | ❌ |

**Total MVP:** ~55-70 hours = **14-18 sessions**

---

### High Priority (Post-MVP) - 4 Gaps
| # | Gap | Effort | Priority |
|---|-----|--------|----------|
| 12 | Guard Implementation | 3-4h | HIGH |
| 13 | Effect Handler Implementation | 4-5h | HIGH |
| 14 | Selector Optimization | 2-3h | MED |
| 15 | Error Messages | 3-4h | HIGH |

**Total Post-MVP:** ~12-16 hours = **3-4 sessions**

---

### Nice to Have (v1.1+) - 4 Gaps
| # | Gap | Effort | Priority |
|---|-----|--------|----------|
| 16 | State Visualization | 3-4h | MED |
| 17 | Time-Travel Debugging | 6-8h | HIGH |
| 18 | State Persistence | 6-8h | HIGH |
| 19 | Middleware System | 4-5h | MED |

**Total Future:** ~20-25 hours = **5-6 sessions**

---

## 🎯 Recommended Roadmap

### Phase 1: Core MVP (55-70h)
**Goal:** Working annotation-based state machine compiler

**Deliverables:**
- ✅ Can write features with annotations
- ✅ Can run `syntaxify build`
- ✅ Generates state/intent/engine classes
- ✅ Generates Flutter integration widgets
- ✅ Validates state machine
- ✅ Basic documentation + examples
- ✅ Test coverage 70%+

**Timeline:** 3-4 weeks intensive (or 6-8 weeks normal)

---

### Phase 2: Production Hardening (12-16h)
**Goal:** Production-ready with guards, effect handlers, better errors

**Deliverables:**
- ✅ Guards work
- ✅ Effect handlers work
- ✅ Selectors optimized
- ✅ Excellent error messages

**Timeline:** 1 week

---

### Phase 3: Advanced Features (20-25h)
**Goal:** Killer features (time-travel, persistence)

**Deliverables:**
- ✅ State visualization
- ✅ Time-travel debugging
- ✅ State persistence
- ✅ Middleware system

**Timeline:** 1-2 weeks

---

## 💡 Key Insights

### Annotation-Based is Simpler Than DSL
- ❌ No custom DSL parser needed
- ✅ Use Dart analyzer (same as ComponentExtractor)
- ✅ IDE support for free
- ✅ Type checking for free

### But Still Non-Trivial
- ⚠️ Field resolution is complex (analyze return statements)
- ⚠️ Effect expression needs careful design
- ⚠️ Guard/effect handler integration needs thought

### Compared to DSL-Based
| Aspect | DSL-Based | Annotation-Based |
|--------|-----------|------------------|
| Parser complexity | HIGH | MEDIUM |
| Type safety | LOW | HIGH |
| IDE support | NONE | FULL |
| Learning curve | HIGH | MEDIUM |
| Total effort | 60-70h | 55-70h |

**Result:** Annotation-based is EQUAL effort but BETTER DX

---

## 🚨 Critical Decisions Needed

### Decision #1: Effect Syntax
**Options:**
- A: `@Navigate('/schedule')` (direct annotation)
- B: `@Effect('Navigate', route: '/schedule')` (generic)
- C: Return `ReduceResult` explicitly

**Recommendation:** A (most declarative)

---

### Decision #2: Field Resolution
**Options:**
- A: Infer from return statement AST
- B: Explicit `@StateFields(['service'])`
- C: Analyze state class constructor

**Recommendation:** C (most reliable)

---

### Decision #3: Scope for v0.3.0
**Options:**
- A: MVP only (11 gaps, 55-70h)
- B: MVP + Production (15 gaps, 67-86h)
- C: Complete (19 gaps, 87-111h)

**Recommendation:** A (MVP only)
- Ship fast (3-4 weeks)
- Get user feedback
- Iterate based on real needs

---

## 📝 Next Steps

1. **Review** this gap analysis
2. **Decide** which scope (MVP / MVP+ / Complete)
3. **Decide** critical syntax questions (effects, fields)
4. **Execute** or defer to complete UI compiler first (GAP #3-7)

**Key Question:** Build state machine compiler now, or complete Syntaxify UI compiler first?

**Syntaxify UI Compiler Remaining:** 5 gaps (GAP #3-7 from CRITICAL_GAPS_ANALYSIS.md)
**State Machine Compiler:** 11 gaps (55-70h)

**Recommendation:**
- If you want **incremental value**, finish UI compiler (1-2 weeks)
- If you want **transformation**, start state machine (3-4 weeks)
- If you want **both**, sequential: UI → State Machine (5-6 weeks total)

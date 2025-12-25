# Minimal Runtime Specification

**Purpose:** Define the tiny runtime library (~300 lines) that powers generated state machines.

**Key Principle:** Keep runtime minimal - complexity lives in generated code, not runtime.

---

## Architecture

```
Generated Engine (user-specific)
        ↓
   Engine<S, I> (abstract)
        ↓
EngineImpl<S, I> (concrete implementation)
        ↓
  ChangeNotifier (Flutter)
```

**Size:** ~300 lines total
**Dependencies:** Flutter SDK only (ChangeNotifier)
**Zero magic:** Everything is explicit

---

## Core Interfaces

### 1. Engine<S, I>

**Purpose:** Abstract base for all feature engines

```dart
/// Base class for state machine engines
///
/// [S] = State type (sealed class)
/// [I] = Intent type (sealed class)
abstract class Engine<S, I> {
  /// Current state
  S get state;

  /// Initial state (set by generated code)
  S get initialState;

  /// Dispatch an intent
  void dispatch(I intent);

  /// Pure reducer: (State, Intent) → (New State, Effects)
  ReduceResult<S> reduce(S state, I intent);

  /// Optional effect runner (user implements)
  EffectRunner? get effectRunner;
}
```

**Key Properties:**
- `reduce()` is **pure** - no side effects
- `dispatch()` orchestrates state update + effect execution
- `effectRunner` is dependency-injected by user

---

### 2. ReduceResult<S>

**Purpose:** Return type from reducer

```dart
@freezed
class ReduceResult<S> with _$ReduceResult<S> {
  const factory ReduceResult(
    S state, [
    @Default([]) List<Effect> effects,
  ]) = _ReduceResult<S>;
}
```

**Usage:**
```dart
ReduceResult<S> reduce(S state, I intent) {
  return ReduceResult(
    newState,          // Updated state
    [effect1, effect2], // Effects to execute
  );
}
```

---

### 3. Effect (Sealed Class)

**Purpose:** Represent side effects

```dart
/// Base class for all side effects
sealed class Effect {
  const Effect();
}

/// Navigate to a route
class Navigate extends Effect {
  final String route;
  final Map<String, dynamic>? arguments;

  const Navigate(this.route, {this.arguments});
}

/// Show dialog
class ShowDialog extends Effect {
  final String message;
  final String? title;

  const ShowDialog(this.message, {this.title});
}

/// Custom user-defined effect
class Custom extends Effect {
  final String name;
  final Map<String, dynamic>? data;

  const Custom(this.name, {this.data});
}
```

**Extensibility:** Users add effects via `Custom`

---

### 4. EffectRunner

**Purpose:** User implements to handle effects

```dart
/// Handles effect execution
abstract class EffectRunner {
  /// Execute an effect
  ///
  /// [effect] - The effect to execute
  /// [dispatch] - Callback to dispatch intents back to engine
  Future<void> run(Effect effect, EngineDispatcher dispatch);
}

/// Function type for dispatching intents from effects
typedef EngineDispatcher = void Function(dynamic intent);
```

**Example Implementation:**
```dart
class MyEffectRunner extends EffectRunner {
  final MyApi api;

  MyEffectRunner(this.api);

  @override
  Future<void> run(Effect effect, EngineDispatcher dispatch) async {
    if (effect is Custom && effect.name == 'loadUser') {
      try {
        final user = await api.getUser();
        dispatch(UserLoaded(user));
      } catch (e) {
        dispatch(LoadFailed(e.toString()));
      }
    }
  }
}
```

---

## Concrete Implementation

### EngineImpl<S, I>

**Purpose:** Default implementation of Engine

```dart
/// Concrete engine implementation
class EngineImpl<S, I> extends ChangeNotifier implements Engine<S, I> {
  EngineImpl({
    required this.initialState,
    required this.reducer,
    this.effectRunner,
  }) : _state = initialState;

  @override
  final S initialState;

  /// Reducer function (injected by generated code)
  final ReduceResult<S> Function(S state, I intent) reducer;

  @override
  final EffectRunner? effectRunner;

  /// Current state (private)
  S _state;

  @override
  S get state => _state;

  @override
  void dispatch(I intent) {
    // 1. Run reducer (pure function)
    final result = reduce(_state, intent);

    // 2. Update state
    _state = result.state;

    // 3. Notify listeners (triggers UI rebuild)
    notifyListeners();

    // 4. Execute effects asynchronously
    for (final effect in result.effects) {
      _executeEffect(effect);
    }
  }

  @override
  ReduceResult<S> reduce(S state, I intent) {
    return reducer(state, intent);
  }

  /// Execute a single effect
  Future<void> _executeEffect(Effect effect) async {
    // Built-in effects handled by runtime
    if (effect is Navigate) {
      _handleNavigate(effect);
      return;
    }

    if (effect is ShowDialog) {
      _handleShowDialog(effect);
      return;
    }

    // Custom effects delegated to user's EffectRunner
    if (effectRunner != null) {
      try {
        await effectRunner!.run(effect, dispatch);
      } catch (e) {
        // Log error but don't crash
        debugPrint('Effect execution failed: $e');
      }
    }
  }

  /// Handle navigation effect
  void _handleNavigate(Navigate effect) {
    // Requires NavigationContext (see below)
    final navigator = NavigationContext.instance.navigator;
    if (navigator != null) {
      navigator.pushNamed(
        effect.route,
        arguments: effect.arguments,
      );
    }
  }

  /// Handle dialog effect
  void _handleShowDialog(ShowDialog effect) {
    // Requires NavigationContext
    final context = NavigationContext.instance.context;
    if (context != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: effect.title != null ? Text(effect.title!) : null,
          content: Text(effect.message),
        ),
      );
    }
  }
}
```

**Key Design Decisions:**
- Uses `ChangeNotifier` (standard Flutter pattern)
- Built-in effects (Navigate, ShowDialog) handled automatically
- Custom effects delegated to user
- Errors in effect execution don't crash app

---

## Flutter Integration

### EngineProvider

**Purpose:** Provide engine to widget tree

```dart
/// Provides engine to descendant widgets
class EngineProvider<E extends Engine> extends InheritedNotifier<E> {
  const EngineProvider({
    required E engine,
    required Widget child,
    Key? key,
  }) : super(key: key, notifier: engine, child: child);

  /// Retrieve engine from context
  static E of<E extends Engine>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<
        EngineProvider<E>>();

    assert(
      provider != null,
      'No EngineProvider<$E> found in context. '
      'Make sure to wrap your widget tree with EngineProvider.',
    );

    return provider!.notifier!;
  }

  /// Try to retrieve engine (returns null if not found)
  static E? maybeOf<E extends Engine>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<
        EngineProvider<E>>();
    return provider?.notifier;
  }
}
```

**Usage:**
```dart
void main() {
  final authEngine = AuthEngine();

  runApp(
    EngineProvider(
      engine: authEngine,
      child: MyApp(),
    ),
  );
}

// In widgets:
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final engine = EngineProvider.of<AuthEngine>(context);
    // Use engine...
  }
}
```

---

### EngineBuilder

**Purpose:** Rebuild UI when state changes

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

**Usage:**
```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final engine = EngineProvider.of<AuthEngine>(context);

    return EngineBuilder<AuthState>(
      engine: engine,
      builder: (context, state) {
        // Rebuild when state changes
        return switch (state) {
          Idle() => LoginForm(),
          Loading() => CircularProgressIndicator(),
          Authenticated(:final user) => Text('Hello ${user.name}'),
          Error(:final message) => Text('Error: $message'),
        };
      },
    );
  }
}
```

---

### NavigationContext (Global Navigation Access)

**Purpose:** Allow effects to access Navigator without BuildContext

```dart
/// Global navigation context for effects
class NavigationContext {
  NavigationContext._();

  static final instance = NavigationContext._();

  GlobalKey<NavigatorState>? navigatorKey;
  BuildContext? context;

  NavigatorState? get navigator => navigatorKey?.currentState;
}
```

**Setup:**
```dart
void main() {
  final navigatorKey = GlobalKey<NavigatorState>();
  NavigationContext.instance.navigatorKey = navigatorKey;

  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      // ...
    ),
  );
}
```

**Why Global?**
- Effects execute outside widget tree
- Can't pass BuildContext to async functions
- Alternative: Use routing package (go_router, auto_route)

---

## Testing Support

### MockEngine

**Purpose:** Test engine behavior without Flutter

```dart
/// Mock engine for testing
class MockEngine<S, I> implements Engine<S, I> {
  MockEngine({
    required this.initialState,
    required this.reducer,
  }) : _state = initialState;

  @override
  final S initialState;

  final ReduceResult<S> Function(S state, I intent) reducer;

  @override
  EffectRunner? effectRunner;

  S _state;

  @override
  S get state => _state;

  final List<I> dispatchedIntents = [];
  final List<Effect> executedEffects = [];

  @override
  void dispatch(I intent) {
    dispatchedIntents.add(intent);

    final result = reduce(_state, intent);
    _state = result.state;

    executedEffects.addAll(result.effects);
  }

  @override
  ReduceResult<S> reduce(S state, I intent) {
    return reducer(state, intent);
  }

  /// Reset for next test
  void reset() {
    _state = initialState;
    dispatchedIntents.clear();
    executedEffects.clear();
  }
}
```

**Usage in Tests:**
```dart
test('Login flow', () {
  final engine = MockEngine(
    initialState: const Idle(),
    reducer: authReducer,
  );

  // Dispatch login intent
  engine.dispatch(Login(email: 'test@example.com', password: 'pass'));

  // Assert state changed
  expect(engine.state, isA<Loading>());

  // Assert effects executed
  expect(engine.executedEffects, contains(Custom('authenticateUser')));

  // Simulate API success
  engine.dispatch(LoginSuccess(user: testUser, token: 'token123'));

  // Assert final state
  expect(engine.state, isA<Authenticated>());
  expect((engine.state as Authenticated).user, testUser);
});
```

---

## Performance Considerations

### 1. State Immutability

**Rule:** States are immutable (use `const` constructors)

```dart
// ✅ Good: Immutable
class Authenticated extends AuthState {
  final User user;
  const Authenticated({required this.user});
}

// ❌ Bad: Mutable
class Authenticated extends AuthState {
  User user; // Not final!
  Authenticated({required this.user});
}
```

**Why:** Enables equality checks, time-travel debugging

---

### 2. Shallow Copies

**Rule:** Only copy changed data

```dart
// ✅ Good: Reuse unchanged objects
ReduceResult(
  UserProfile(
    user: state.user, // Reuse
    settings: newSettings, // Only this changed
  ),
)

// ❌ Bad: Copy everything
ReduceResult(
  UserProfile(
    user: User.from(state.user), // Unnecessary copy
    settings: newSettings,
  ),
)
```

---

### 3. Effect Batching

**Optimization:** Batch multiple effects

```dart
@override
void dispatch(I intent) {
  final result = reduce(_state, intent);
  _state = result.state;
  notifyListeners();

  // Batch effects (execute in next microtask)
  if (result.effects.isNotEmpty) {
    scheduleMicrotask(() {
      for (final effect in result.effects) {
        _executeEffect(effect);
      }
    });
  }
}
```

---

## Error Handling

### 1. Effect Failures

**Strategy:** Log but don't crash

```dart
Future<void> _executeEffect(Effect effect) async {
  try {
    // Execute effect
  } catch (e, stackTrace) {
    debugPrint('Effect execution failed: $e');
    debugPrint(stackTrace.toString());

    // Optionally dispatch error intent
    if (e is Exception) {
      dispatch(EffectFailed(error: e.toString()) as I);
    }
  }
}
```

### 2. Reducer Exceptions

**Strategy:** Never throw in reducer (return error state instead)

```dart
// ❌ Bad: Throw in reducer
ReduceResult<S> reduce(S state, I intent) {
  if (invalidCondition) {
    throw Exception('Invalid state transition');
  }
  // ...
}

// ✅ Good: Return error state
ReduceResult<S> reduce(S state, I intent) {
  if (invalidCondition) {
    return ReduceResult(
      Error(message: 'Invalid state transition'),
    );
  }
  // ...
}
```

---

## Runtime Size

### Total Lines of Code

| File | Lines | Purpose |
|------|-------|---------|
| engine.dart | 30 | Abstract interface |
| reduce_result.dart | 15 | Freezed model |
| effect.dart | 40 | Effect types |
| effect_runner.dart | 20 | Effect interface |
| engine_impl.dart | 120 | Concrete implementation |
| engine_provider.dart | 30 | Flutter integration |
| engine_builder.dart | 25 | Flutter widget |
| navigation_context.dart | 20 | Global navigation |
| mock_engine.dart | 50 | Testing support |
| **TOTAL** | **~350** | **Minimal runtime** |

**Zero external dependencies** (except Flutter SDK)

---

## Summary

The minimal runtime provides:
- ✅ Abstract Engine interface
- ✅ Concrete implementation (EngineImpl)
- ✅ Flutter integration (Provider/Builder)
- ✅ Effect execution framework
- ✅ Testing support (MockEngine)
- ✅ ~350 lines total

**All complexity lives in GENERATED code, not runtime.**

**Next:** See EXAMPLES.md for real-world usage patterns.

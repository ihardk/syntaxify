# State Machine Compiler: Refined Architecture (v1+)

**Version:** v1+ (Simplified from v2)
**Status:** Production-ready without runtime complexity

---

## Design Philosophy

### What v1+ Is
- **Compile-time state machine compiler**
- **Pure reducers with effects as data**
- **Simple architecture (Engine + ChangeNotifier)**
- **Production-ready for 90% of use cases**

### What v1+ Is NOT
- Not a full state runtime (no separate Runtime class)
- Not structured concurrency (no cancellation tokens)
- Not a framework (no scope supervisors)
- Not over-engineered (defers complexity to later)

**Philosophy:** Ship simple, iterate based on real needs.

---

## Core Architecture

```
User Action → dispatch(Intent)
                    ↓
            Engine.reduce(state, intent)  [PURE]
                    ↓
            ReduceResult(newState, effects)
                    ↓
        ┌───────────┴──────────┐
        ↓                      ↓
   Update State          Execute Effects
        ↓                      ↓
   notifyListeners()    EffectRunner.run()
        ↓                      ↓
     UI Rebuilds         Side Effects
                              ↓
                      dispatch(ResultIntent)
```

**Key:** Reducer is pure, effects executed after state update.

---

## Core Types

### 1. ReduceResult<S>

**Purpose:** Return both new state AND effects from reducer

```dart
@freezed
class ReduceResult<S> with _$ReduceResult<S> {
  const factory ReduceResult(
    S state,
    [@Default([]) List<Effect> effects],
  ) = _ReduceResult<S>;
}
```

**Why:**
- Separates pure (state) from impure (effects)
- Effects are data (inspectable, testable)
- Enables time-travel (log effects)

**Example:**
```dart
ReduceResult<S> reduce(S state, I intent) {
  return switch ((state, intent)) {
    (Idle(), Login(:final email, :final password)) => ReduceResult(
      Authenticating(),
      [Custom('authenticateUser', data: {'email': email})],
    ),

    (Authenticating(), LoginSuccess(:final user)) => ReduceResult(
      Authenticated(user: user),
      [
        Navigate('/home'),
        Custom('trackLogin'),
      ],
    ),

    _ => ReduceResult(state), // No change
  };
}
```

---

### 2. Effect (Sealed Class)

**Purpose:** Describe side effects as data

```dart
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

**Why sealed:**
- Exhaustive pattern matching
- Type-safe
- Compile-time validation

---

### 3. Engine (Pure Reducer)

**Purpose:** Define state machine behavior

```dart
abstract class Engine<S, I> {
  /// Initial state
  S get initialState;

  /// Pure reducer: (State, Intent) → (New State, Effects)
  ReduceResult<S> reduce(S state, I intent);
}
```

**Key:** `reduce()` is **pure** - no side effects, no async, no I/O.

**Example:**
```dart
class BookingEngine implements Engine<BookingState, BookingIntent> {
  @override
  BookingState get initialState => BookingIdle();

  @override
  ReduceResult<BookingState> reduce(
    BookingState state,
    BookingIntent intent,
  ) {
    return switch ((state, intent)) {
      // Define all transitions
      (BookingIdle(), SelectService(:final service)) => ReduceResult(
        ServiceSelected(service),
        [Navigate('/schedule')],
      ),

      // More transitions...

      _ => ReduceResult(state),
    };
  }
}
```

---

### 4. EngineImpl (Concrete Implementation)

**Purpose:** Orchestrate state updates and effect execution

```dart
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

  /// Optional effect runner (user implements)
  final EffectRunner? effectRunner;

  S _state;

  @override
  S get state => _state;

  /// Dispatch an intent
  void dispatch(I intent) {
    // 1. Reduce (pure function)
    final result = reduce(_state, intent);

    // 2. Update state (atomic)
    _state = result.state;

    // 3. Notify listeners (UI rebuilds)
    notifyListeners();

    // 4. Execute effects (async, isolated)
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
    // Built-in effects
    if (effect is Navigate) {
      _handleNavigate(effect);
      return;
    }

    if (effect is ShowDialog) {
      _handleShowDialog(effect);
      return;
    }

    // Custom effects
    if (effectRunner != null) {
      try {
        await effectRunner!.run(effect, dispatch);
      } catch (e) {
        debugPrint('Effect execution failed: $e');
      }
    }
  }

  void _handleNavigate(Navigate effect) {
    // Uses global NavigatorKey
    NavigationContext.instance.navigator?.pushNamed(
      effect.route,
      arguments: effect.arguments,
    );
  }

  void _handleShowDialog(ShowDialog effect) {
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

**Key design:**
- Extends `ChangeNotifier` (standard Flutter)
- Reducer is injected (generated code)
- Effect execution is isolated
- Errors don't crash app

---

### 5. EffectRunner (User Implements)

**Purpose:** Handle custom effects (API calls, business logic)

```dart
abstract class EffectRunner {
  Future<void> run(Effect effect, EngineDispatcher dispatch);
}

typedef EngineDispatcher = void Function(dynamic intent);
```

**Example Implementation:**
```dart
class BookingEffectRunner extends EffectRunner {
  final BookingApi api;

  BookingEffectRunner(this.api);

  @override
  Future<void> run(Effect effect, EngineDispatcher dispatch) async {
    if (effect is Custom && effect.name == 'authenticateUser') {
      final email = effect.data!['email'] as String;
      final password = effect.data!['password'] as String;

      try {
        final user = await api.login(email, password);
        dispatch(LoginSuccess(user));
      } catch (e) {
        dispatch(LoginFailed(e.toString()));
      }
    }

    if (effect is Custom && effect.name == 'trackLogin') {
      analytics.track('user_logged_in');
    }
  }
}
```

**Key:** User controls effect execution, can mock for tests.

---

## Flutter Integration

### EngineProvider (Same as Original)

```dart
class EngineProvider<E extends Engine> extends InheritedNotifier<E> {
  const EngineProvider({
    required E engine,
    required Widget child,
    Key? key,
  }) : super(key: key, notifier: engine, child: child);

  static E of<E extends Engine>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<
        EngineProvider<E>>();
    assert(provider != null, 'No EngineProvider found');
    return provider!.notifier!;
  }
}
```

### EngineBuilder (Same as Original)

```dart
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

---

## What's Different from v2 (Full Runtime)?

| Feature | v1+ (This) | v2 (Full Runtime) |
|---------|------------|-------------------|
| **Separate Runtime class** | ❌ No | ✅ Yes |
| **ReduceResult** | ✅ Yes | ✅ Yes |
| **Effects as data** | ✅ Yes | ✅ Yes |
| **Pure reducer** | ✅ Yes | ✅ Yes |
| **Cancellation tokens** | ❌ No | ✅ Yes |
| **Scope supervisor** | ❌ No | ✅ Yes |
| **Intent logging** | ❌ Manual | ✅ Built-in |
| **Selectors** | ❌ No | ✅ Yes |
| **Transactions** | ❌ No | ✅ Yes |
| **Concepts** | 5 | 12 |
| **Implementation** | 27h | 76h |
| **Learning curve** | Medium | High |

**Trade-off:** 90% of benefits for 35% of cost.

---

## What Can Be Added Later?

### Session 8: Intent Logging (Optional)
```dart
class EngineImpl<S, I> {
  final List<IntentRecord<I>> _history = [];

  void dispatch(I intent) {
    _history.add(IntentRecord(
      intent: intent,
      previousState: _state,
      timestamp: DateTime.now(),
    ));

    // ... rest of dispatch
  }
}
```

**Effort:** 2-3h

### Session 9-10: Time-Travel Debugging (Optional)
```dart
void replayTo(int index) {
  var state = initialState;
  for (var i = 0; i <= index; i++) {
    final result = reduce(state, _history[i].intent);
    state = result.state;
  }
  _state = state;
  notifyListeners();
}
```

**Effort:** 4-6h

### Session 11: Selectors (Optional)
```dart
final visibleTodos = Selector<TodoState, List<Todo>>(
  (state) => state.todos.where((t) => !t.done).toList(),
);
```

**Effort:** 3-4h

**Key:** Can add incrementally based on user demand.

---

## Benefits Over Original v1

### 1. Testability
```dart
// Before (v1): Hard to test effects
test('Login triggers API call', () {
  // How to verify API called without mocking engine internals?
});

// After (v1+): Easy to test effects
test('Login returns authenticateUser effect', () {
  final result = engine.reduce(Idle(), Login('test@example.com', 'pass'));
  expect(result.effects, contains(Custom('authenticateUser')));
});
```

### 2. Debuggability
```dart
// Can inspect effects before execution
final result = engine.reduce(state, intent);
print('Effects to execute: ${result.effects}');
```

### 3. Time-Travel Ready
```dart
// Future: Add logging with minimal changes
// No architecture rewrite needed
```

---

## Simplicity Maintained

**Concepts:** 5 (was 4, not 12)
1. State
2. Intent
3. Engine
4. ReduceResult ← NEW
5. Effect ← NEW

**Implementation:** 27h (was 25h, not 76h)

**Learning curve:** Medium (not High)

---

## Summary

v1+ gives you:
- ✅ Pure reducers (testable)
- ✅ Effects as data (inspectable)
- ✅ Simple architecture (ChangeNotifier)
- ✅ Production-ready (90% of needs)
- ✅ Extensible (can add features later)

Without:
- ❌ Runtime complexity
- ❌ Steep learning curve
- ❌ Over-engineering

**Philosophy:** Start simple, add complexity only when proven necessary.

This is the architecture we'll implement in Sessions 1-7.

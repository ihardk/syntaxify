# State Machine Compiler vs Bloc vs Riverpod

**Purpose:** Honest comparison with real code examples to help you choose.

**TL;DR:**
- **State Machine** → Multi-step workflows, wizards, onboarding
- **Riverpod** → Reactive data, simple state, computed values
- **Bloc** → Complex business logic, large teams, architecture enforcement

---

## 📊 Quick Comparison Matrix

| Feature | State Machine (v1+) | Bloc | Riverpod |
|---------|---------------------|------|----------|
| **Best for** | Workflows/wizards | Business logic | Reactive data |
| **Boilerplate** | ⭐⭐⭐⭐⭐ Low (generated) | ⭐⭐ High | ⭐⭐⭐⭐ Low |
| **Learning curve** | ⭐⭐⭐ Medium (state machines) | ⭐⭐ Steep (events/states) | ⭐⭐⭐ Medium (providers) |
| **Type safety** | ⭐⭐⭐⭐⭐ Compile-time | ⭐⭐⭐⭐ Runtime | ⭐⭐⭐⭐⭐ Compile-time |
| **Testability** | ⭐⭐⭐⭐⭐ Pure functions | ⭐⭐⭐⭐ Good | ⭐⭐⭐⭐ Good |
| **Visualization** | ⭐⭐⭐⭐⭐ State diagrams | ⭐⭐ Manual | ⭐ None |
| **Time-travel** | ⭐⭐⭐⭐⭐ Built-in ready | ⭐⭐⭐⭐ Bloc Observer | ⭐⭐ Manual |
| **Flexibility** | ⭐⭐⭐ Opinionated | ⭐⭐⭐⭐ Flexible | ⭐⭐⭐⭐⭐ Very flexible |
| **Reactive streams** | ⭐⭐ Not designed for | ⭐⭐⭐⭐⭐ Built-in | ⭐⭐⭐⭐⭐ Built-in |
| **Community** | ⭐ New | ⭐⭐⭐⭐⭐ Huge | ⭐⭐⭐⭐⭐ Huge |
| **Packages** | ⭐ None yet | ⭐⭐⭐⭐⭐ Many | ⭐⭐⭐⭐⭐ Many |
| **Documentation** | ⭐⭐⭐ Planned | ⭐⭐⭐⭐⭐ Excellent | ⭐⭐⭐⭐⭐ Excellent |

---

## 🔨 Real Example: Login Flow

Let's build the same login flow with all three approaches.

**Requirements:**
- Idle state (show login form)
- Loading state (show spinner)
- Authenticated state (show home screen)
- Error state (show error message)
- Track login attempts for analytics

---

### State Machine Approach

#### 1. Define Feature (Declarative)

```dart
// login.feature.dart
FeatureDefinition(
  name: 'Auth',

  states: [
    StateDefinition('Idle'),

    StateDefinition('Authenticating'),

    StateDefinition('Authenticated', fields: [
      Field('user', 'User'),
      Field('token', 'String'),
    ]),

    StateDefinition('Error', fields: [
      Field('message', 'String'),
    ]),
  ],

  intents: [
    IntentDefinition('Login', inputs: [
      Field('email', 'String'),
      Field('password', 'String'),
    ]),

    IntentDefinition('LoginSuccess', inputs: [
      Field('user', 'User'),
      Field('token', 'String'),
    ]),

    IntentDefinition('LoginFailed', inputs: [
      Field('error', 'String'),
    ]),

    IntentDefinition('Logout'),
  ],

  transitions: [
    Transition(
      from: 'Idle',
      on: 'Login',
      to: 'Authenticating',
      effects: [Custom('authenticateUser')],
    ),

    Transition(
      from: 'Authenticating',
      on: 'LoginSuccess',
      to: 'Authenticated',
      effects: [
        Navigate('/home'),
        Custom('trackLogin'),
      ],
    ),

    Transition(
      from: 'Authenticating',
      on: 'LoginFailed',
      to: 'Error',
    ),

    Transition(
      from: 'Authenticated',
      on: 'Logout',
      to: 'Idle',
      effects: [Navigate('/login')],
    ),
  ],
);
```

#### 2. Generated Code (Automatic)

```dart
// ✅ GENERATED: auth_state.dart
sealed class AuthState {}
class Idle extends AuthState {}
class Authenticating extends AuthState {}
class Authenticated extends AuthState {
  final User user;
  final String token;
  const Authenticated({required this.user, required this.token});
}
class Error extends AuthState {
  final String message;
  const Error({required this.message});
}

// ✅ GENERATED: auth_intent.dart
sealed class AuthIntent {}
class Login extends AuthIntent {
  final String email;
  final String password;
  const Login({required this.email, required this.password});
}
class LoginSuccess extends AuthIntent {
  final User user;
  final String token;
  const LoginSuccess({required this.user, required this.token});
}
// ... etc

// ✅ GENERATED: auth_engine.dart
class AuthEngine extends ChangeNotifier implements Engine<AuthState, AuthIntent> {
  @override
  AuthState get initialState => Idle();

  @override
  ReduceResult<AuthState> reduce(AuthState state, AuthIntent intent) {
    return switch ((state, intent)) {
      (Idle(), Login(:final email, :final password)) => ReduceResult(
        Authenticating(),
        [Custom('authenticateUser', data: {'email': email, 'password': password})],
      ),

      (Authenticating(), LoginSuccess(:final user, :final token)) => ReduceResult(
        Authenticated(user: user, token: token),
        [Navigate('/home'), Custom('trackLogin')],
      ),

      (Authenticating(), LoginFailed(:final error)) => ReduceResult(
        Error(message: error),
      ),

      (Authenticated(), Logout()) => ReduceResult(
        Idle(),
        [Navigate('/login')],
      ),

      _ => ReduceResult(state),
    };
  }
}
```

#### 3. User Implements Effects

```dart
// user_code/auth_effects.dart
class AuthEffectRunner extends EffectRunner {
  final AuthApi api;
  final Analytics analytics;

  @override
  Future<void> run(Effect effect, EngineDispatcher dispatch) async {
    if (effect is Custom && effect.name == 'authenticateUser') {
      try {
        final user = await api.login(
          effect.data!['email'],
          effect.data!['password'],
        );
        dispatch(LoginSuccess(user: user, token: user.token));
      } catch (e) {
        dispatch(LoginFailed(error: e.toString()));
      }
    }

    if (effect is Custom && effect.name == 'trackLogin') {
      analytics.track('user_logged_in');
    }
  }
}
```

#### 4. UI (Screen)

```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final engine = EngineProvider.of<AuthEngine>(context);

    return EngineBuilder<AuthState>(
      engine: engine,
      builder: (context, state) {
        return switch (state) {
          Idle() => LoginForm(
            onSubmit: (email, password) {
              engine.dispatch(Login(email: email, password: password));
            },
          ),

          Authenticating() => Center(child: CircularProgressIndicator()),

          Authenticated(:final user) => HomeScreen(user: user),

          Error(:final message) => Column(
            children: [
              Text('Error: $message'),
              LoginForm(onSubmit: (email, password) {
                engine.dispatch(Login(email: email, password: password));
              }),
            ],
          ),
        };
      },
    );
  }
}
```

**Lines of code:**
- Feature definition: ~60 lines
- Generated code: ~150 lines (don't count)
- Effect runner: ~25 lines
- UI: ~35 lines
- **Total user code: ~120 lines**

---

### Bloc Approach

#### 1. Define Events

```dart
// auth_event.dart
sealed class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested({required this.email, required this.password});
}

class LogoutRequested extends AuthEvent {}

// Internal events (for async results)
class _LoginSuccess extends AuthEvent {
  final User user;
  final String token;
  _LoginSuccess({required this.user, required this.token});
}

class _LoginFailure extends AuthEvent {
  final String error;
  _LoginFailure({required this.error});
}
```

#### 2. Define States

```dart
// auth_state.dart
sealed class AuthState {}

class AuthIdle extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final String token;
  AuthAuthenticated({required this.user, required this.token});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
```

#### 3. Define Bloc

```dart
// auth_bloc.dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi api;
  final Analytics analytics;

  AuthBloc({required this.api, required this.analytics}) : super(AuthIdle()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<_LoginSuccess>(_onLoginSuccess);
    on<_LoginFailure>(_onLoginFailure);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await api.login(event.email, event.password);
      add(_LoginSuccess(user: user, token: user.token));
    } catch (e) {
      add(_LoginFailure(error: e.toString()));
    }
  }

  void _onLoginSuccess(_LoginSuccess event, Emitter<AuthState> emit) {
    emit(AuthAuthenticated(user: event.user, token: event.token));
    analytics.track('user_logged_in');
    // Navigation handled separately
  }

  void _onLoginFailure(_LoginFailure event, Emitter<AuthState> emit) {
    emit(AuthError(message: event.error));
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthIdle());
    // Navigation handled separately
  }
}
```

#### 4. UI

```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
        if (state is AuthIdle && /* came from logout */) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      builder: (context, state) {
        return switch (state) {
          AuthIdle() => LoginForm(
            onSubmit: (email, password) {
              context.read<AuthBloc>().add(
                LoginRequested(email: email, password: password),
              );
            },
          ),

          AuthLoading() => Center(child: CircularProgressIndicator()),

          AuthAuthenticated(:final user) => HomeScreen(user: user),

          AuthError(:final message) => Column(
            children: [
              Text('Error: $message'),
              LoginForm(onSubmit: (email, password) {
                context.read<AuthBloc>().add(
                  LoginRequested(email: email, password: password),
                );
              }),
            ],
          ),
        };
      },
    );
  }
}
```

**Lines of code:**
- Events: ~25 lines
- States: ~25 lines
- Bloc: ~60 lines
- UI: ~45 lines
- **Total: ~155 lines**

---

### Riverpod Approach

#### 1. Define State

```dart
// auth_state.dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.idle() = _Idle;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({
    required User user,
    required String token,
  }) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}
```

#### 2. Define Notifier

```dart
// auth_provider.dart
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthApi api;
  final Analytics analytics;

  AuthNotifier({required this.api, required this.analytics})
      : super(const AuthState.idle());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();

    try {
      final user = await api.login(email, password);
      state = AuthState.authenticated(user: user, token: user.token);
      analytics.track('user_logged_in');
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void logout() {
    state = const AuthState.idle();
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    api: ref.watch(authApiProvider),
    analytics: ref.watch(analyticsProvider),
  );
});
```

#### 3. UI

```dart
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      if (next is _Authenticated) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
      if (next is _Idle && previous is _Authenticated) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    return switch (state) {
      _Idle() => LoginForm(
        onSubmit: (email, password) {
          ref.read(authProvider.notifier).login(email, password);
        },
      ),

      _Loading() => Center(child: CircularProgressIndicator()),

      _Authenticated(:final user) => HomeScreen(user: user),

      _Error(:final message) => Column(
        children: [
          Text('Error: $message'),
          LoginForm(onSubmit: (email, password) {
            ref.read(authProvider.notifier).login(email, password);
          }),
        ],
      ),
    };
  }
}
```

**Lines of code:**
- State (Freezed): ~10 lines
- Notifier: ~30 lines
- Provider: ~10 lines
- UI: ~40 lines
- **Total: ~90 lines**

---

## 📊 Code Comparison

| Metric | State Machine | Bloc | Riverpod |
|--------|---------------|------|----------|
| **User-written code** | 120 lines | 155 lines | 90 lines |
| **Generated code** | 150 lines | 0 lines | ~20 lines (Freezed) |
| **Total code** | 270 lines | 155 lines | 110 lines |
| **Files** | 4 (+ 1 feature def) | 4 | 3 |
| **Boilerplate** | Low (generated) | High (manual) | Low (Freezed) |
| **Testability** | ⭐⭐⭐⭐⭐ (pure reducer) | ⭐⭐⭐⭐ (mocktail) | ⭐⭐⭐⭐ (override providers) |

**Winner for this use case:** Riverpod (least code)

**BUT** - Let's look at a more complex workflow...

---

## 🛒 Complex Example: Checkout Flow

**Requirements:**
- Select shipping address (4 states)
- Choose payment method (3 states)
- Review order (1 state)
- Process payment (3 states)
- Navigation between steps
- Track analytics at each step
- Handle errors at any step

**Total: ~11 states, ~20 transitions**

---

### State Machine Approach

```dart
// checkout.feature.dart (50 lines)
FeatureDefinition(
  name: 'Checkout',
  states: [
    StateDefinition('SelectingShipping'),
    StateDefinition('ShippingSelected', fields: [Field('address', 'Address')]),
    StateDefinition('SelectingPayment', fields: [Field('address', 'Address')]),
    StateDefinition('PaymentSelected', fields: [
      Field('address', 'Address'),
      Field('payment', 'PaymentMethod'),
    ]),
    StateDefinition('ReviewingOrder', fields: [...]),
    StateDefinition('ProcessingPayment', fields: [...]),
    StateDefinition('PaymentSuccess', fields: [Field('orderId', 'String')]),
    StateDefinition('PaymentFailed', fields: [Field('error', 'String')]),
    // ... 11 states total
  ],

  transitions: [
    Transition(from: 'SelectingShipping', on: 'SelectAddress', to: 'ShippingSelected'),
    Transition(from: 'ShippingSelected', on: 'ContinueToPayment', to: 'SelectingPayment'),
    // ... 20 transitions total
    // Each with effects: [Navigate(...), Custom('track...')]
  ],
);
```

**User code:** ~50 lines (feature def) + ~40 lines (effect runner) = **90 lines**
**Generated:** ~400 lines (states, intents, engine)

---

### Bloc Approach

```dart
// checkout_event.dart (~40 lines)
sealed class CheckoutEvent {}
class SelectAddressRequested extends CheckoutEvent { ... }
class AddressSelected extends CheckoutEvent { ... }
class ContinueToPaymentRequested extends CheckoutEvent { ... }
class PaymentMethodSelected extends CheckoutEvent { ... }
class ReviewOrderRequested extends CheckoutEvent { ... }
class ProcessPaymentRequested extends CheckoutEvent { ... }
class _PaymentSuccess extends CheckoutEvent { ... }
class _PaymentFailure extends CheckoutEvent { ... }
// ... 20 events

// checkout_state.dart (~45 lines)
sealed class CheckoutState {}
class SelectingShipping extends CheckoutState {}
class ShippingSelected extends CheckoutState {
  final Address address;
  // ...
}
// ... 11 states

// checkout_bloc.dart (~200 lines)
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(...) : super(SelectingShipping()) {
    on<SelectAddressRequested>(_onSelectAddressRequested);
    on<AddressSelected>(_onAddressSelected);
    on<ContinueToPaymentRequested>(_onContinueToPayment);
    // ... 20 event handlers
  }

  Future<void> _onSelectAddressRequested(...) async {
    // Validate, emit states, track analytics
  }

  void _onAddressSelected(...) {
    emit(ShippingSelected(address: event.address));
    analytics.track('address_selected');
    // But how to navigate? BlocListener in UI
  }

  // ... 20 handler methods
}

// Navigation handled in UI with BlocListener
BlocListener<CheckoutBloc, CheckoutState>(
  listener: (context, state) {
    if (state is ShippingSelected) {
      Navigator.pushNamed('/payment');
    }
    if (state is PaymentSelected) {
      Navigator.pushNamed('/review');
    }
    // ... 10+ navigation cases
  },
)
```

**Total code:** ~40 (events) + ~45 (states) + ~200 (bloc) + ~60 (UI navigation) = **345 lines**

---

### Riverpod Approach

```dart
// checkout_state.dart (~50 lines with Freezed)
@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.selectingShipping() = _SelectingShipping;
  const factory CheckoutState.shippingSelected(Address address) = _ShippingSelected;
  const factory CheckoutState.selectingPayment(Address address) = _SelectingPayment;
  // ... 11 state variants
}

// checkout_provider.dart (~150 lines)
class CheckoutNotifier extends StateNotifier<CheckoutState> {
  final Analytics analytics;
  final PaymentApi paymentApi;

  CheckoutNotifier(...) : super(const CheckoutState.selectingShipping());

  void selectAddress(Address address) {
    state = CheckoutState.shippingSelected(address);
    analytics.track('address_selected');
    // How to trigger navigation? Not Riverpod's concern
  }

  void continueToPayment() {
    final currentState = state;
    if (currentState is _ShippingSelected) {
      state = CheckoutState.selectingPayment(currentState.address);
      analytics.track('continue_to_payment');
    }
  }

  // ... 20 methods for each action
}

// Navigation still in UI
ref.listen(checkoutProvider, (previous, next) {
  if (next is _ShippingSelected) {
    Navigator.pushNamed('/payment');
  }
  // ... 10+ navigation cases
});
```

**Total code:** ~50 (state) + ~150 (notifier) + ~60 (UI navigation) = **260 lines**

---

## 📊 Complex Workflow Comparison

| Metric | State Machine | Bloc | Riverpod |
|--------|---------------|------|----------|
| **User code** | 90 lines | 345 lines | 260 lines |
| **Generated** | 400 lines | 0 | ~30 lines |
| **Navigation** | Declarative (in transitions) | Manual (BlocListener) | Manual (ref.listen) |
| **Flow visibility** | ⭐⭐⭐⭐⭐ (feature def) | ⭐⭐ (scattered) | ⭐⭐ (scattered) |
| **Can visualize** | ✅ Yes (state diagram) | ❌ No | ❌ No |
| **Maintainability** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |

**Winner for complex workflows:** State Machine (73% less code, visual)

---

## 🎯 When to Use What?

### Use State Machine When:

✅ **Multi-step workflows** (booking, checkout, onboarding)
```dart
// Perfect fit - clear sequence of states
Idle → Selecting → Selected → Processing → Complete
```

✅ **Wizards with navigation**
```dart
// Navigation declarative in transitions
Transition(from: 'Step1', on: 'Next', to: 'Step2', effects: [Navigate('/step2')])
```

✅ **Complex authentication flows**
```dart
// 2FA, password reset, email verification
Unauthenticated → EnteringCredentials → Verifying2FA → Authenticated
```

✅ **Form validation with steps**
```dart
// Each step has validation state
FormStep1Invalid → FormStep1Valid → FormStep2...
```

✅ **Game state** (menu, playing, paused, game over)

❌ **Don't use for:**
- Simple counters, toggles, settings
- Real-time data streams (chat, stock prices)
- Large apps with many independent widgets
- Apps without clear workflows

---

### Use Bloc When:

✅ **Complex business logic** that needs isolation
```dart
// Separates events (what happened) from states (current situation)
// Good for complex domain logic
```

✅ **Large teams** needing architecture enforcement
```dart
// Bloc enforces separation of concerns
// Event → Bloc → State (unidirectional)
```

✅ **Need stream-based reactivity**
```dart
// Built on Streams, works well with real-time data
stream<AuthState> authStateStream
```

✅ **Testability is critical**
```dart
// Easy to test: verify events → states
blocTest('login emits authenticated state', ...)
```

✅ **Migration from AngularDart/Redux**
```dart
// Similar patterns to AngularDart
```

❌ **Don't use for:**
- Simple apps (too much boilerplate)
- Prototypes (slow to iterate)
- Solo developers (overhead not worth it)

---

### Use Riverpod When:

✅ **Reactive data** (computed values, derived state)
```dart
final totalProvider = Provider((ref) {
  final items = ref.watch(cartItemsProvider);
  return items.fold(0, (sum, item) => sum + item.price);
}); // Auto-recomputes when items change
```

✅ **Dependency injection**
```dart
final apiProvider = Provider((ref) => ApiService());
final authProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return AuthService(api); // Auto-wired
});
```

✅ **Simple state** (toggles, counters, settings)
```dart
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
ref.read(themeProvider.notifier).state = ThemeMode.dark; // Simple
```

✅ **Granular rebuilds** (performance-critical)
```dart
// Only widgets watching specific providers rebuild
Consumer(builder: (context, ref, child) {
  final count = ref.watch(counterProvider);
  return Text('$count'); // Only this rebuilds
});
```

✅ **Flexible apps** (needs change frequently)
```dart
// Riverpod doesn't enforce structure
// Good for exploration, bad for consistency
```

❌ **Don't use for:**
- Workflows with complex state machines
- Apps needing enforced architecture
- Junior teams (too flexible, inconsistent patterns)

---

## 🔬 Deep Dive: Testability

### State Machine Testing

```dart
test('Login flow', () {
  final engine = AuthEngine();

  // Test transition
  final result = engine.reduce(
    Idle(),
    Login(email: 'test@example.com', password: 'pass'),
  );

  // Assert new state
  expect(result.state, isA<Authenticating>());

  // Assert effects (without executing)
  expect(result.effects, [
    Custom('authenticateUser', data: {'email': 'test@example.com'}),
  ]);

  // Test success path
  final result2 = engine.reduce(
    Authenticating(),
    LoginSuccess(user: testUser, token: 'token123'),
  );

  expect(result2.state, isA<Authenticated>());
  expect(result2.effects, [
    Navigate('/home'),
    Custom('trackLogin'),
  ]);
});
```

**Pros:**
- ✅ Pure functions (easy to test)
- ✅ Effects inspectable (no mocking needed)
- ✅ All transitions testable
- ✅ Time-travel testable (replay intents)

---

### Bloc Testing

```dart
blocTest<AuthBloc, AuthState>(
  'login emits [loading, authenticated] when successful',
  build: () {
    when(() => api.login(any(), any())).thenAnswer(
      (_) async => testUser,
    );
    return AuthBloc(api: api, analytics: analytics);
  },
  act: (bloc) => bloc.add(LoginRequested(
    email: 'test@example.com',
    password: 'pass',
  )),
  expect: () => [
    AuthLoading(),
    AuthAuthenticated(user: testUser, token: 'token123'),
  ],
  verify: (_) {
    verify(() => api.login('test@example.com', 'pass')).called(1);
    verify(() => analytics.track('user_logged_in')).called(1);
  },
);
```

**Pros:**
- ✅ `blocTest` package simplifies testing
- ✅ Can verify async behavior
- ✅ Stream-based, predictable

**Cons:**
- ⚠️ Need to mock API (vs inspecting effects)
- ⚠️ More setup code

---

### Riverpod Testing

```dart
test('login sets authenticated state', () async {
  final container = ProviderContainer(
    overrides: [
      authApiProvider.overrideWithValue(mockApi),
      analyticsProvider.overrideWithValue(mockAnalytics),
    ],
  );

  when(() => mockApi.login(any(), any())).thenAnswer(
    (_) async => testUser,
  );

  final notifier = container.read(authProvider.notifier);

  await notifier.login('test@example.com', 'pass');

  final state = container.read(authProvider);
  expect(state, isA<_Authenticated>());
  expect((state as _Authenticated).user, testUser);

  verify(() => mockAnalytics.track('user_logged_in')).called(1);
});
```

**Pros:**
- ✅ Provider overrides (easy mocking)
- ✅ No widget tests needed
- ✅ Granular testing

**Cons:**
- ⚠️ Need to mock dependencies
- ⚠️ More setup than pure functions

---

## ⚡ Performance Comparison

### Rebuild Efficiency

**Scenario:** 1000-item list, update one item

#### State Machine
```dart
// Updates entire state
engine.dispatch(UpdateItem(index: 500));
// Triggers notifyListeners()
// → Entire widget tree rebuilds (inefficient)
```

**Performance:** ⭐⭐ (rebuilds everything)

**Optimization:**
```dart
// Need to add selectors (post-MVP feature)
final itemSelector = Selector((state) => state.items[index]);
```

---

#### Bloc
```dart
// Emits new state
emit(TodosUpdated(updatedList));
// → BlocBuilder rebuilds
```

**Performance:** ⭐⭐⭐ (rebuilds BlocBuilder scope)

**Optimization:**
```dart
BlocSelector<TodoBloc, TodoState, Todo>(
  selector: (state) => state.todos[index],
  builder: (context, todo) => TodoItem(todo),
);
```

---

#### Riverpod
```dart
// Update specific item
ref.read(todoItemProvider(id).notifier).update(...);
// → Only widgets watching that specific provider rebuild
```

**Performance:** ⭐⭐⭐⭐⭐ (granular rebuilds)

**Winner:** Riverpod (best performance for large apps)

---

## 🏢 Enterprise Considerations

### State Machine
**Pros:**
- ✅ Enforces workflow consistency
- ✅ Visualizable (state diagrams for stakeholders)
- ✅ Time-travel debugging
- ✅ Compile-time safety

**Cons:**
- ❌ New pattern (training needed)
- ❌ Small ecosystem
- ❌ No enterprise support

**Best for:** Fintech, healthcare, booking apps (regulated workflows)

---

### Bloc
**Pros:**
- ✅ Enforces architecture (good for teams)
- ✅ Mature ecosystem
- ✅ Clear separation of concerns
- ✅ Well-documented

**Cons:**
- ❌ Boilerplate heavy
- ❌ Slow iteration

**Best for:** Large teams, enterprise apps, long-term projects

---

### Riverpod
**Pros:**
- ✅ Flexible (adapts to any pattern)
- ✅ Mature ecosystem
- ✅ Great performance
- ✅ DI built-in

**Cons:**
- ❌ Too flexible (inconsistent patterns)
- ❌ No enforced architecture
- ❌ Junior teams struggle

**Best for:** Startups, flexible teams, experienced developers

---

## 🔄 Migration Paths

### From Bloc → State Machine

**When:** Your app is mostly workflows

```dart
// Before: Bloc
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> { ... }

// After: State Machine
FeatureDefinition(name: 'Checkout', ...)
```

**Effort:** Medium (can migrate feature-by-feature)

---

### From Riverpod → State Machine

**When:** Workflows becoming complex

```dart
// Before: Many providers with unclear flow
final step1Provider = StateNotifierProvider(...);
final step2Provider = StateNotifierProvider(...);
// How do they connect?

// After: Explicit state machine
FeatureDefinition(
  transitions: [
    Transition(from: 'Step1', on: 'Next', to: 'Step2'),
  ],
)
```

**Effort:** Medium (can coexist initially)

---

### From State Machine → Riverpod

**When:** Workflows were wrong fit

```dart
// Before: Overkill for simple reactive state
FeatureDefinition(name: 'Counter', ...) // 50 lines for counter

// After: Simple provider
final counterProvider = StateProvider<int>((ref) => 0);
```

**Effort:** Easy (simpler target)

---

## 🎯 Final Recommendation

### Choose State Machine If:
- 70% of your app is workflows/wizards
- You need visualization
- You want compile-time safety
- You're okay being early adopter

### Choose Bloc If:
- Large team needs architecture
- Complex business logic
- Long-term enterprise project
- Training resources needed

### Choose Riverpod If:
- Flexible app with changing requirements
- Performance critical
- Experienced team
- Reactive data-heavy app

### Mix Multiple?
**YES - Use both:**
```dart
// Riverpod for app-level state
final userProvider = Provider(...);
final settingsProvider = StateProvider(...);

// State Machine for workflows
final checkoutEngine = CheckoutEngine();
final onboardingEngine = OnboardingEngine();
```

**Best of both worlds.**

---

## 📊 Summary Table

| Use Case | State Machine | Bloc | Riverpod |
|----------|---------------|------|----------|
| **Counter app** | ⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Todo list** | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Login flow** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Checkout flow** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| **Onboarding wizard** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| **Chat app** | ⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Dashboard** | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Game** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |

---

**Bottom line:**
- State Machine ≠ replacement for Bloc/Riverpod
- State Machine = specialized tool for workflows
- Use the right tool for the job
- Mixing is okay (even recommended)

# Feature DSL Specification

**Version:** 1.0.0
**Status:** Draft

This document defines the syntax and semantics of Syntaxify's Feature Definition Language (FDL).

---

## Design Principles

1. **Dart-based** - Uses Dart syntax, no new language to learn
2. **Declarative** - Describes WHAT, not HOW
3. **Type-safe** - Leverages Dart's type system
4. **IDE-friendly** - Autocomplete and refactoring work
5. **Analyzable** - Can be parsed with Dart analyzer

---

## Core Syntax

### Feature Definition

```dart
FeatureDefinition(
  name: String,              // Required: Feature name (PascalCase)
  states: List<StateDefinition>,    // Required: All possible states
  intents: List<IntentDefinition>,  // Required: All possible intents
  transitions: List<TransitionDefinition>, // Required: State transitions
  effects: List<EffectDefinition>,  // Optional: Custom effects
)
```

**Example:**
```dart
FeatureDefinition(
  name: 'Auth',
  states: [...],
  intents: [...],
  transitions: [...],
)
```

---

### State Definition

```dart
StateDefinition(
  name: String,                // Required: State name (PascalCase)
  fields: List<FieldDefinition>, // Optional: State data
  description: String?,        // Optional: Documentation
)
```

**Rules:**
- First state in list is the initial state
- State names must be unique within feature
- State names should be nouns or adjectives (e.g., `Idle`, `Loading`, `Success`)

**Examples:**
```dart
// Simple state (no data)
StateDefinition('Idle')

// State with data
StateDefinition(
  'UserLoaded',
  fields: [
    Field('user', 'User'),
    Field('timestamp', 'DateTime'),
  ],
  description: 'User data successfully loaded',
)

// State with optional fields
StateDefinition(
  'Error',
  fields: [
    Field('message', 'String'),
    Field('code', 'int', defaultValue: '0'),
  ],
)
```

---

### Intent Definition

```dart
IntentDefinition(
  name: String,              // Required: Intent name (PascalCase)
  inputs: List<FieldDefinition>, // Optional: Input data
  description: String?,      // Optional: Documentation
)
```

**Rules:**
- Intent names must be unique within feature
- Intent names should be verbs (e.g., `LoadUser`, `SubmitForm`, `Cancel`)
- Intents represent user actions or external events

**Examples:**
```dart
// Simple intent (no data)
IntentDefinition('Refresh')

// Intent with inputs
IntentDefinition(
  'LoadUser',
  inputs: [
    Field('userId', 'String'),
  ],
  description: 'Load user data from API',
)

// Intent with multiple inputs
IntentDefinition(
  'SubmitForm',
  inputs: [
    Field('email', 'String'),
    Field('password', 'String'),
    Field('rememberMe', 'bool', defaultValue: 'false'),
  ],
)
```

---

### Transition Definition

```dart
TransitionDefinition(
  fromState: String,         // Required: Source state name
  onIntent: String,          // Required: Triggering intent name
  toState: String,           // Required: Destination state name
  effects: List<EffectType>, // Optional: Side effects to execute
  guard: String?,            // Optional: Conditional transition
)
```

**Rules:**
- `fromState`, `onIntent`, `toState` must reference existing definitions
- Multiple transitions with same (fromState, onIntent) = **ambiguous** (error)
- Transitions form a directed graph (cycles allowed)

**Examples:**
```dart
// Simple transition
Transition(
  from: 'Idle',
  on: 'LoadUser',
  to: 'Loading',
)

// Transition with effects
Transition(
  from: 'Loading',
  on: 'UserLoaded',
  to: 'Success',
  effects: [
    Navigate('/profile'),
    Custom('trackAnalytics'),
  ],
)

// Conditional transition (advanced)
Transition(
  from: 'FormInput',
  on: 'Submit',
  to: 'Submitting',
  guard: 'isFormValid', // Only transition if guard returns true
  effects: [
    Custom('submitForm'),
  ],
)
```

---

### Field Definition

```dart
Field(
  String name,            // Required: Field name (camelCase)
  String type,            // Required: Dart type
  {String? defaultValue}  // Optional: Default value expression
)
```

**Rules:**
- Field names must be valid Dart identifiers
- Types must be valid Dart types (String, int, User, DateTime, etc.)
- Default values are Dart expressions (e.g., `'0'`, `'DateTime.now()'`, `'null'`)

**Examples:**
```dart
Field('userId', 'String')
Field('count', 'int', defaultValue: '0')
Field('timestamp', 'DateTime', defaultValue: 'DateTime.now()')
Field('user', 'User?') // Nullable type
```

---

### Effect Types

Effects represent side effects that should be executed after a state transition.

#### Built-in Effects

**1. Navigate**
```dart
Navigate(String route, {Map<String, dynamic>? arguments})
```

Triggers navigation to a route.

**Examples:**
```dart
Navigate('/home')
Navigate('/profile', arguments: {'userId': '123'})
```

**2. ShowDialog**
```dart
ShowDialog(String message, {String? title})
```

Shows a dialog to the user.

**Examples:**
```dart
ShowDialog('Are you sure?', title: 'Confirmation')
ShowDialog('Operation successful')
```

**3. Custom**
```dart
Custom(String name, {Map<String, dynamic>? data})
```

User-defined effect (implemented in EffectRunner).

**Examples:**
```dart
Custom('trackAnalytics')
Custom('submitForm', data: {'endpoint': '/api/submit'})
Custom('playSound', data: {'file': 'success.mp3'})
```

---

## Complete Example: Auth Feature

```dart
// auth.feature.dart
FeatureDefinition(
  name: 'Auth',

  // All possible states
  states: [
    StateDefinition('Idle'),

    StateDefinition('Loading'),

    StateDefinition(
      'Authenticated',
      fields: [
        Field('user', 'User'),
        Field('token', 'String'),
      ],
      description: 'User successfully authenticated',
    ),

    StateDefinition(
      'Error',
      fields: [
        Field('message', 'String'),
      ],
      description: 'Authentication failed',
    ),
  ],

  // All possible intents
  intents: [
    IntentDefinition(
      'Login',
      inputs: [
        Field('email', 'String'),
        Field('password', 'String'),
      ],
      description: 'User attempts to log in',
    ),

    IntentDefinition(
      'LoginSuccess',
      inputs: [
        Field('user', 'User'),
        Field('token', 'String'),
      ],
      description: 'Login succeeded (from API)',
    ),

    IntentDefinition(
      'LoginFailed',
      inputs: [
        Field('error', 'String'),
      ],
      description: 'Login failed (from API)',
    ),

    IntentDefinition(
      'Logout',
      description: 'User logs out',
    ),

    IntentDefinition(
      'Retry',
      description: 'User retries after error',
    ),
  ],

  // State transitions
  transitions: [
    // Idle → Loading (when user submits login)
    Transition(
      from: 'Idle',
      on: 'Login',
      to: 'Loading',
      effects: [
        Custom('authenticateUser'), // Trigger API call
      ],
    ),

    // Loading → Authenticated (API success)
    Transition(
      from: 'Loading',
      on: 'LoginSuccess',
      to: 'Authenticated',
      effects: [
        Navigate('/home'),
        Custom('trackLogin'),
      ],
    ),

    // Loading → Error (API failure)
    Transition(
      from: 'Loading',
      on: 'LoginFailed',
      to: 'Error',
      effects: [
        ShowDialog('Login failed'),
      ],
    ),

    // Error → Loading (retry)
    Transition(
      from: 'Error',
      on: 'Retry',
      to: 'Loading',
      effects: [
        Custom('authenticateUser'),
      ],
    ),

    // Authenticated → Idle (logout)
    Transition(
      from: 'Authenticated',
      on: 'Logout',
      to: 'Idle',
      effects: [
        Navigate('/login'),
        Custom('clearSession'),
      ],
    ),
  ],
);
```

---

## Generated Code Specification

### State Classes

From the Auth example above, generates:

```dart
// GENERATED: auth_state.dart

sealed class AuthState {
  const AuthState();
}

class Idle extends AuthState {
  const Idle();
}

class Loading extends AuthState {
  const Loading();
}

class Authenticated extends AuthState {
  final User user;
  final String token;

  const Authenticated({
    required this.user,
    required this.token,
  });
}

class Error extends AuthState {
  final String message;

  const Error({required this.message});
}
```

### Intent Classes

```dart
// GENERATED: auth_intent.dart

sealed class AuthIntent {
  const AuthIntent();
}

class Login extends AuthIntent {
  final String email;
  final String password;

  const Login({
    required this.email,
    required this.password,
  });
}

class LoginSuccess extends AuthIntent {
  final User user;
  final String token;

  const LoginSuccess({
    required this.user,
    required this.token,
  });
}

class LoginFailed extends AuthIntent {
  final String error;

  const LoginFailed({required this.error});
}

class Logout extends AuthIntent {
  const Logout();
}

class Retry extends AuthIntent {
  const Retry();
}
```

### Engine Class

```dart
// GENERATED: auth_engine.dart

class AuthEngine extends ChangeNotifier implements Engine<AuthState, AuthIntent> {
  AuthEngine({this.effectRunner}) : _state = const Idle();

  @override
  final EffectRunner? effectRunner;

  AuthState _state;

  @override
  AuthState get state => _state;

  @override
  AuthState get initialState => const Idle();

  @override
  void dispatch(AuthIntent intent) {
    final result = reduce(_state, intent);

    _state = result.state;
    notifyListeners();

    for (final effect in result.effects) {
      _executeEffect(effect);
    }
  }

  @override
  ReduceResult<AuthState> reduce(
    AuthState state,
    AuthIntent intent,
  ) {
    return switch ((state, intent)) {
      // Idle → Loading
      (Idle(), Login(:final email, :final password)) => ReduceResult(
        const Loading(),
        [Custom('authenticateUser', data: {'email': email, 'password': password})],
      ),

      // Loading → Authenticated
      (Loading(), LoginSuccess(:final user, :final token)) => ReduceResult(
        Authenticated(user: user, token: token),
        [
          Navigate('/home'),
          Custom('trackLogin'),
        ],
      ),

      // Loading → Error
      (Loading(), LoginFailed(:final error)) => ReduceResult(
        Error(message: error),
        [ShowDialog('Login failed')],
      ),

      // Error → Loading
      (Error(:final message), Retry()) => ReduceResult(
        const Loading(),
        [Custom('authenticateUser', data: {'message': message})],
      ),

      // Authenticated → Idle
      (Authenticated(), Logout()) => ReduceResult(
        const Idle(),
        [
          Navigate('/login'),
          Custom('clearSession'),
        ],
      ),

      // Unhandled transitions (no-op)
      _ => ReduceResult(state),
    };
  }

  Future<void> _executeEffect(Effect effect) async {
    if (effectRunner != null) {
      await effectRunner!.run(effect, dispatch);
    }
  }
}
```

---

## Validation Rules

### Compile-Time Errors

1. **Unknown State Reference**
   ```dart
   Transition(
     from: 'Loading',
     on: 'Success',
     to: 'UnknownState', // ❌ ERROR: State 'UnknownState' not defined
   )
   ```

2. **Unknown Intent Reference**
   ```dart
   Transition(
     from: 'Idle',
     on: 'UnknownIntent', // ❌ ERROR: Intent 'UnknownIntent' not defined
     to: 'Loading',
   )
   ```

3. **Ambiguous Transitions**
   ```dart
   Transition(from: 'Idle', on: 'Start', to: 'Loading'),
   Transition(from: 'Idle', on: 'Start', to: 'Ready'), // ❌ ERROR: Ambiguous
   ```

4. **Duplicate State Names**
   ```dart
   StateDefinition('Loading'),
   StateDefinition('Loading'), // ❌ ERROR: Duplicate state name
   ```

5. **Duplicate Intent Names**
   ```dart
   IntentDefinition('Submit'),
   IntentDefinition('Submit'), // ❌ ERROR: Duplicate intent name
   ```

### Compile-Time Warnings

1. **Unreachable States**
   ```dart
   StateDefinition('Orphan'), // ⚠️ WARNING: No transitions lead to this state
   ```

2. **Dead-End States**
   ```dart
   StateDefinition('Terminal'), // ⚠️ WARNING: No transitions from this state
   ```

3. **Unused Intents**
   ```dart
   IntentDefinition('NeverUsed'), // ⚠️ WARNING: Intent not referenced in any transition
   ```

---

## Advanced Features (Future)

### Guards (Conditional Transitions)

```dart
Transition(
  from: 'FormInput',
  on: 'Submit',
  to: 'Submitting',
  guard: 'isFormValid', // Only transition if guard returns true
)

// Generates:
bool isFormValid(FormInput state, Submit intent) {
  return state.email.isNotEmpty && state.password.length >= 8;
}
```

### Wildcard Transitions

```dart
Transition(
  from: '*', // From any state
  on: 'Reset',
  to: 'Idle',
)
```

### Parameterized Effects

```dart
effects: [
  Navigate(route: state.nextRoute), // Use state data
  Custom('notify', data: {'userId': intent.userId}), // Use intent data
]
```

---

## Best Practices

### Naming Conventions

- **States:** Nouns or adjectives (`Idle`, `Loading`, `Authenticated`)
- **Intents:** Verbs (`Login`, `Submit`, `Cancel`, `Refresh`)
- **Features:** PascalCase (`Auth`, `Booking`, `Cart`)
- **Fields:** camelCase (`userId`, `email`, `isValid`)

### State Design

✅ **Good:** Explicit, descriptive states
```dart
StateDefinition('Idle')
StateDefinition('Loading')
StateDefinition('Success', fields: [Field('data', 'User')])
StateDefinition('Error', fields: [Field('message', 'String')])
```

❌ **Bad:** Generic states with flags
```dart
StateDefinition('AppState', fields: [
  Field('isLoading', 'bool'),
  Field('hasError', 'bool'),
  Field('data', 'User?'),
])
```

### Intent Design

✅ **Good:** Separate intents for different outcomes
```dart
IntentDefinition('LoadUser')
IntentDefinition('UserLoaded', inputs: [Field('user', 'User')])
IntentDefinition('UserLoadFailed', inputs: [Field('error', 'String')])
```

❌ **Bad:** Single intent with result flag
```dart
IntentDefinition('LoadUserComplete', inputs: [
  Field('success', 'bool'),
  Field('user', 'User?'),
  Field('error', 'String?'),
])
```

### Transition Design

✅ **Good:** Clear, atomic transitions
```dart
Transition(from: 'Idle', on: 'LoadUser', to: 'Loading')
Transition(from: 'Loading', on: 'UserLoaded', to: 'Success')
Transition(from: 'Loading', on: 'LoadFailed', to: 'Error')
```

❌ **Bad:** Long transition chains
```dart
Transition(from: 'Idle', on: 'LoadUser', to: 'ValidatingLoadingAuthenticatingFetchingParsingSuccess')
```

---

## Summary

The Feature DSL provides:
- ✅ Declarative state machine definition
- ✅ Type-safe states and intents
- ✅ Explicit transition rules
- ✅ Side effect isolation
- ✅ Compile-time validation
- ✅ IDE support (autocomplete, refactoring)

**Next:** See RUNTIME_SPECIFICATION.md for the execution model.

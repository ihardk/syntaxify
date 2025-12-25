# Path 2: State Machine Compiler - Overview

## Vision Statement

Transform Syntaxify from a **UI component generator** into a **full-stack state machine compiler** that generates complete application logic using the Elm Architecture / Redux / MVI pattern.

---

## The Problem We're Solving

### Current Flutter Pain Points

**Problem 1: State Scattered Everywhere**
```dart
// Screen 1
class HomeScreen extends StatefulWidget {
  final Service? selectedService; // ← State here

  onServiceTap(Service service) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScheduleScreen(
          service: service, // ← Passing state
        ),
      ),
    );
  }
}

// Screen 2
class ScheduleScreen extends StatefulWidget {
  final Service service; // ← Duplicated state
  final DateTime? selectedSlot; // ← More state here

  onSlotTap(DateTime slot) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmScreen(
          service: service, // ← Passing state again
          slot: slot,
        ),
      ),
    );
  }
}
```

**Issues:**
- State duplicated across screens
- Callback hell for data passing
- Hard to track state changes
- Can't time-travel debug
- Navigation tightly coupled to UI

---

**Problem 2: Callback Hell**
```dart
class BookingFlow extends StatefulWidget {
  final Function(Service)? onServiceSelected;
  final Function(DateTime)? onSlotSelected;
  final Function(Booking)? onBookingComplete;
  final Function(String)? onError;
  // ... 10 more callbacks
}
```

**Issues:**
- Callback spaghetti
- Hard to follow data flow
- Difficult to test
- Refactoring is nightmare

---

**Problem 3: Testing is Hard**
```dart
// How do you test this?
testWidgets('Booking flow', (tester) async {
  await tester.pumpWidget(HomeScreen());
  await tester.tap(find.text('Massage'));
  await tester.pumpAndSettle();
  // Now on ScheduleScreen? How did we get here?
  await tester.tap(find.text('3:00 PM'));
  await tester.pumpAndSettle();
  // Now on ConfirmScreen? What state do we have?
  await tester.tap(find.text('Confirm'));
  // What happens? Network call? Navigation? Who knows?
});
```

**Issues:**
- UI tests are brittle
- Can't test logic without widgets
- Hard to mock state
- No way to test state transitions in isolation

---

## Our Solution: State Machine Compiler

### The Mental Model

**Three Core Concepts:**

1. **State** - All possible application states (sealed union)
2. **Intent** - All possible user actions (sealed union)
3. **Engine** - Pure reducer: `(State, Intent) → (New State, Effects)`

**Data Flow (Unidirectional):**
```
Screen → Dispatch(Intent) → Engine.reduce()
                                ↓
                           (New State, Effects)
                                ↓
                    ┌───────────┴───────────┐
                    ↓                       ↓
              Update State              Execute Effects
                    ↓                       ↓
              UI Reacts               (API, Navigation, etc.)
                                            ↓
                                    Dispatch(Result Intent)
                                            ↓
                                      Engine.reduce()
```

**Key Properties:**
- ✅ **Unidirectional** - Data flows one way, easy to trace
- ✅ **Centralized** - All state in one place (Engine)
- ✅ **Pure** - Reducer has no side effects, fully testable
- ✅ **Isolated** - Side effects (API, navigation) are explicit
- ✅ **Declarative** - Screens just declare UI based on state
- ✅ **Debuggable** - Can record intents, replay state

---

## Example: Before vs After

### Before (Current Flutter)

**Pain Points Illustrated:**
```dart
// 4 screens, 200+ lines, spaghetti callbacks

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Service? _selectedService;

  void _onServiceTap(Service service) {
    setState(() => _selectedService = service);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScheduleScreen(
          service: service,
          onSlotSelected: (slot) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ConfirmScreen(
                  service: service,
                  slot: slot,
                  onConfirm: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProcessingScreen(),
                      ),
                    );

                    try {
                      final booking = await api.bookService(service, slot);
                      Navigator.popUntil(context, (route) => route.isFirst);
                      setState(() {
                        // Update home screen with booking
                      });
                    } catch (e) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Error'),
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: services.map((service) {
          return ListTile(
            title: Text(service.name),
            onTap: () => _onServiceTap(service),
          );
        }).toList(),
      ),
    );
  }
}
```

**Problems:**
- 7 levels of nested callbacks
- State management scattered
- Navigation logic mixed with UI
- Error handling ad-hoc
- Impossible to test without UI
- Can't understand flow without reading all code

---

### After (With State Machine Compiler)

**Step 1: Define Feature** (Declarative)
```dart
// booking_feature.dart
FeatureDefinition(
  name: 'Booking',

  states: [
    StateDefinition('Idle'),
    StateDefinition('ServiceSelected', fields: [
      Field('service', 'Service'),
    ]),
    StateDefinition('ScheduleSelected', fields: [
      Field('service', 'Service'),
      Field('slot', 'DateTime'),
    ]),
    StateDefinition('InProgress', fields: [
      Field('service', 'Service'),
      Field('slot', 'DateTime'),
    ]),
    StateDefinition('Success', fields: [
      Field('booking', 'Booking'),
    ]),
    StateDefinition('Failure', fields: [
      Field('reason', 'String'),
    ]),
  ],

  intents: [
    IntentDefinition('SelectService', inputs: [
      Field('service', 'Service'),
    ]),
    IntentDefinition('SelectSchedule', inputs: [
      Field('slot', 'DateTime'),
    ]),
    IntentDefinition('ConfirmBooking'),
    IntentDefinition('BookingConfirmed', inputs: [
      Field('booking', 'Booking'),
    ]),
    IntentDefinition('BookingFailed', inputs: [
      Field('reason', 'String'),
    ]),
  ],

  transitions: [
    Transition(
      from: 'Idle',
      on: 'SelectService',
      to: 'ServiceSelected',
      effects: [Navigate('/schedule')],
    ),
    Transition(
      from: 'ServiceSelected',
      on: 'SelectSchedule',
      to: 'ScheduleSelected',
      effects: [Navigate('/confirm')],
    ),
    Transition(
      from: 'ScheduleSelected',
      on: 'ConfirmBooking',
      to: 'InProgress',
      effects: [
        Navigate('/processing'),
        Custom('StartBooking'),
      ],
    ),
    Transition(
      from: 'InProgress',
      on: 'BookingConfirmed',
      to: 'Success',
      effects: [Navigate('/home')],
    ),
    Transition(
      from: 'InProgress',
      on: 'BookingFailed',
      to: 'Failure',
      effects: [Navigate('/home')],
    ),
  ],
);
```

**Step 2: Generated Code** (Automatic)
```dart
// ✅ GENERATED: booking_state.dart
sealed class BookingState {}
class BookingIdle extends BookingState {}
class ServiceSelected extends BookingState {
  final Service service;
  ServiceSelected(this.service);
}
// ... rest of states

// ✅ GENERATED: booking_intent.dart
sealed class BookingIntent {}
class SelectService extends BookingIntent {
  final Service service;
  SelectService(this.service);
}
// ... rest of intents

// ✅ GENERATED: booking_engine.dart
class BookingEngine extends Engine<BookingState, BookingIntent> {
  @override
  BookingState get initialState => BookingIdle();

  @override
  ReduceResult<BookingState> reduce(
    BookingState state,
    BookingIntent intent,
  ) {
    return switch ((state, intent)) {
      (BookingIdle(), SelectService(:final service)) => ReduceResult(
        ServiceSelected(service),
        [Navigate('/schedule')],
      ),
      (ServiceSelected(:final service), SelectSchedule(:final slot)) => ReduceResult(
        ScheduleSelected(service, slot),
        [Navigate('/confirm')],
      ),
      // ... all transitions (exhaustive)
      _ => ReduceResult(state),
    };
  }
}

// ✅ GENERATED: home_screen.dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final engine = EngineProvider.of<BookingEngine>(context);

    return EngineBuilder<BookingState>(
      engine: engine,
      builder: (context, state) {
        if (state is BookingSuccess) {
          return Text('Upcoming: ${state.booking.service.name}');
        }

        return ListView(
          children: services.map((service) {
            return ListTile(
              title: Text(service.name),
              onTap: () => engine.dispatch(SelectService(service)),
            );
          }).toList(),
        );
      },
    );
  }
}
```

**Step 3: User Implements Effects** (Business Logic)
```dart
// user_code/booking_effects.dart
class BookingEffectRunner extends EffectRunner {
  Future<void> run(Effect effect, EngineDispatcher dispatch) async {
    if (effect is CustomEffect && effect.name == 'StartBooking') {
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

**Benefits:**
- ✅ **50 lines** vs 200+ lines
- ✅ **Zero callbacks** - intents only
- ✅ **Centralized state** - one source of truth
- ✅ **Testable** - pure reducer function
- ✅ **Debuggable** - can log all intents
- ✅ **Type-safe** - exhaustive pattern matching
- ✅ **Navigable** - can visualize as state diagram

---

## Key Advantages

### 1. Unidirectional Data Flow
**Benefit:** Always know where data comes from and where it goes
```
User Action → Intent → Reducer → New State → UI Update
```
No mystery, no debugging hell.

### 2. Centralized State
**Benefit:** One source of truth
```dart
// OLD: State scattered across 4 screens
HomeScreen._selectedService
ScheduleScreen._selectedSlot
ConfirmScreen._isLoading
ProcessingScreen._error

// NEW: One state
BookingEngine.state
```

### 3. Pure Reducer (Testable)
**Benefit:** Test logic without UI
```dart
test('Selecting service navigates to schedule screen', () {
  final engine = BookingEngine();

  final result = engine.reduce(
    BookingIdle(),
    SelectService(massageService),
  );

  expect(result.state, isA<ServiceSelected>());
  expect(result.state.service, massageService);
  expect(result.effects, contains(Navigate('/schedule')));
});
```

### 4. Time-Travel Debugging
**Benefit:** Record intents, replay state
```dart
// Record session
final intents = [
  SelectService(massage),
  SelectSchedule(slot3pm),
  ConfirmBooking(),
  BookingFailed('Network error'),
];

// Replay
var state = BookingIdle();
for (final intent in intents) {
  state = engine.reduce(state, intent).state;
}

// state == BookingFailure('Network error')
```

### 5. Compile-Time Validation
**Benefit:** Catch errors before runtime
```dart
// ❌ Compiler ERROR: Missing transition handler
Transition(
  from: 'ServiceSelected',
  on: 'ConfirmBooking', // ← Skipped ScheduleSelected state
  to: 'InProgress',
)

// ✅ Compiler warning: Unreachable state
StateDefinition('Cancelled') // ← No transitions lead here
```

### 6. Visualizable
**Benefit:** Generate state diagrams automatically
```
[Idle] --SelectService--> [ServiceSelected]
                              ↓ SelectSchedule
                         [ScheduleSelected]
                              ↓ ConfirmBooking
                         [InProgress]
                              ↓ BookingConfirmed
                         [Success]
```

---

## Market Positioning

### Competitors

| Solution | Approach | Pain Points |
|----------|----------|-------------|
| **Bloc** | Stream-based state | Boilerplate heavy, steep learning curve |
| **Riverpod** | Provider pattern | Not opinionated, no structure |
| **GetX** | Global state | Magic, hard to test, not type-safe |
| **Redux** | Store + actions | Manual wiring, verbose |
| **MobX** | Reactive | Runtime overhead, not compile-time safe |

### Our Differentiator

**Syntaxify State Machine Compiler:**
- ✅ **Compile-time** - Zero runtime overhead
- ✅ **Code generation** - No manual wiring
- ✅ **Type-safe** - Exhaustive pattern matching
- ✅ **Opinionated** - One way to do things
- ✅ **Visual** - State diagrams from code
- ✅ **Testable** - Pure functions, no mocking
- ✅ **Debuggable** - Time-travel built-in

**Unique Value Prop:** "The only compile-time state machine compiler for Flutter that generates production-ready code from declarative feature definitions."

---

## Success Criteria

### Technical Success
- [ ] Generate complete state machine from 50-line definition
- [ ] Support 10+ screen flows without callback hell
- [ ] 100% type-safe transitions (exhaustive matching)
- [ ] Generate state diagrams automatically
- [ ] Time-travel debugging works out-of-box

### User Success
- [ ] 80% reduction in state management boilerplate
- [ ] Developers can understand flow from feature definition alone
- [ ] Testing becomes trivial (pure reducer tests)
- [ ] Onboarding takes <1 hour (vs days for Bloc)

### Market Success
- [ ] 100+ GitHub stars in first month
- [ ] 10+ production apps using it
- [ ] "This changes how I build Flutter apps" testimonials
- [ ] Featured in Flutter community newsletter

---

## Next Documents

1. **ARCHITECTURE.md** - Technical deep dive on compiler phases
2. **IMPLEMENTATION_PLAN.md** - Session-by-session breakdown
3. **DSL_SPECIFICATION.md** - Feature definition syntax
4. **RUNTIME_SPECIFICATION.md** - Minimal runtime design
5. **EXAMPLES.md** - Real-world use cases
6. **TESTING_STRATEGY.md** - How to validate correctness
7. **STATE_MACHINE_THEORY.md** - Formal semantics
8. **RISKS_AND_MITIGATIONS.md** - What could go wrong
9. **COMPARISON_TO_ALTERNATIVES.md** - vs Bloc/Riverpod/Redux

---

## Final Vision

**Syntaxify becomes the only tool that lets you:**

1. Define your app's logic declaratively (feature definitions)
2. Generate complete state management code (no manual wiring)
3. Visualize your app's behavior (state diagrams)
4. Test your app trivially (pure reducer tests)
5. Debug with time-travel (intent replay)
6. Ship with zero runtime overhead (compile-time only)

**All while writing less code than any alternative.**

That's the vision. Let's build it.

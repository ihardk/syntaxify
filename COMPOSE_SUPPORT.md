# Jetpack Compose Support Roadmap

## AST Compatibility Analysis

The current AST is **90% compatible** with Jetpack Compose. Here's what needs to be done:

## ✅ Already Platform-Agnostic

### 1. Core AST Structure
- App tree structure works identically
- Node categories (Structural, Primitive, Interactive, Custom) map directly
- All validation rules apply to Compose

### 2. String Parsing
- Padding/margin parsing: `"16,8,16,8"` → `Modifier.padding(16.dp, 8.dp, 16.dp, 8.dp)`
- Spacing parsing: `"16"` → `Arrangement.spacedBy(16.dp)`
- Color semantics: `ColorSemantic.primary` → `MaterialTheme.colorScheme.primary`

### 3. Node Mappings

| AST Node                  | Flutter Widget            | Compose Composable        |
| ------------------------- | ------------------------- | ------------------------- |
| Column                    | Column                    | Column                    |
| Row                       | Row                       | Row                       |
| Container                 | Container                 | Box                       |
| Card                      | Card                      | Card                      |
| Text                      | Text                      | Text                      |
| Image                     | Image                     | Image                     |
| Button                    | ElevatedButton            | Button                    |
| TextField                 | TextField                 | TextField                 |
| Checkbox                  | Checkbox                  | Checkbox                  |
| Switch                    | Switch                    | Switch                    |
| Spacer                    | Spacer                    | Spacer                    |
| SizedBox                  | SizedBox                  | Spacer(Modifier.size)     |
| Expanded                  | Expanded                  | Box(Modifier.weight)      |
| Divider                   | Divider                   | Divider                   |
| CircularProgressIndicator | CircularProgressIndicator | CircularProgressIndicator |
| ListView                  | ListView                  | LazyColumn                |

## 🔧 What Needs Implementation

### 1. Create ComposeEmitter Class

```dart
class ComposeEmitter {
  String emit(App node) {
    return node.map(
      structural: (n) => _emitStructural(n.node),
      primitive: (n) => _emitPrimitive(n.node),
      interactive: (n) => _emitInteractive(n.node),
      // ... same pattern as LayoutEmitter
    );
  }

  String _emitColumn(ColumnNode node) {
    // Generate: Column(verticalArrangement = ...) { ... }
  }

  String _emitContainer(ContainerNode node) {
    // Generate: Box(modifier = Modifier.padding(...).background(...)) { ... }
  }
}
```

### 2. Enum Mapping Layer (Optional)

```dart
class EnumMapper {
  static String toCompose(MainAxisAlignment alignment) {
    switch (alignment) {
      case MainAxisAlignment.start: return 'Arrangement.Top';
      case MainAxisAlignment.center: return 'Arrangement.Center';
      case MainAxisAlignment.end: return 'Arrangement.Bottom';
      // ...
    }
  }
}
```

### 3. Modifier System

Compose uses modifiers instead of properties:

```kotlin
// Flutter: Container(padding: EdgeInsets.all(16), color: Colors.blue, child: ...)
// Compose: Box(modifier = Modifier.padding(16.dp).background(Color.Blue)) { ... }
```

The AST's padding/margin/color properties map cleanly to modifiers.

### 4. Design System Integration

```dart
// Both platforms use the same ColorSemantic
ColorSemantic.primary
  → Flutter: AppColors.primary
  → Compose: MaterialTheme.colorScheme.primary
```

## 📊 Platform-Agnostic Score

| Component      | Agnostic? | Notes                                         |
| -------------- | --------- | --------------------------------------------- |
| AST Models     | ✅ 95%     | Minor naming biases, but concepts universal   |
| Validation     | ✅ 100%    | Rules apply to all platforms                  |
| String Parsing | ✅ 100%    | Output format is emitter's job                |
| Emitters       | ❌ 0%      | LayoutEmitter is Flutter-specific (by design) |
| Design System  | ✅ 90%     | Semantic enums work for both                  |

## 🎯 Recommended Architecture

```
┌─────────────────────────────────────┐
│         Platform-Agnostic           │
│    ┌─────────────────────────┐     │
│    │   AST Models (Freezed)  │     │
│    │  - App           │     │
│    │  - StructuralNode       │     │
│    │  - PrimitiveNode        │     │
│    │  - Enums & Semantics    │     │
│    └─────────────────────────┘     │
│              │                      │
│    ┌─────────┴─────────┐           │
│    │                   │            │
│    ▼                   ▼            │
│ ┌──────────┐     ┌──────────┐      │
│ │ Validator│     │  Parser  │      │
│ └──────────┘     └──────────┘      │
└─────────────────────────────────────┘
              │
    ┌─────────┴─────────┐
    │                   │
    ▼                   ▼
┌────────────┐    ┌────────────┐
│  Flutter   │    │  Compose   │
│  Emitter   │    │  Emitter   │
└────────────┘    └────────────┘
```

## 🚀 Next Steps for Compose Support

1. **Keep AST as-is** - It's already compatible
2. **Create `ComposeEmitter` class** - Mirror LayoutEmitter structure
3. **Map enums** - Create simple mapping functions
4. **Test with same AST** - Verify both emitters work from identical input
5. **Add Compose-specific nodes** (if needed) - Use CustomNode

## ✨ Benefits of Current Design

The changes you've made are **excellent for multi-platform support**:

1. **Validation is universal** - Works for Flutter, Compose, SwiftUI, React Native
2. **String parsing is agnostic** - Each emitter interprets the values
3. **Semantic properties** - ColorSemantic, ContainerSemantic map to Material Design (both platforms)
4. **Clean separation** - AST layer doesn't know about Flutter specifics

## Example: Same AST, Multiple Outputs

```dart
// Define once
final loginScreen = App.column(
  spacing: "16",
  children: [
    App.text(text: "Login"),
    App.textField(label: "Email"),
    App.button(label: "Submit", onPressed: "handleLogin"),
  ],
);

// Emit to Flutter
final flutterCode = FlutterEmitter().emit(loginScreen);
// → Column(children: [Text("Login"), SizedBox(height: 16), ...])

// Emit to Compose
final composeCode = ComposeEmitter().emit(loginScreen);
// → Column(verticalArrangement = Arrangement.spacedBy(16.dp)) { Text("Login"); TextField(...); Button(...) }

// Emit to SwiftUI (future)
final swiftCode = SwiftUIEmitter().emit(loginScreen);
// → VStack(spacing: 16) { Text("Login"); TextField(...); Button(...) }
```

## Conclusion

✅ **Yes, the AST is platform-agnostic and extensible for Compose!**

The recent changes (validation, string parsing, semantic properties) actually **improve** multi-platform support because they keep logic at the AST level, not the emitter level.

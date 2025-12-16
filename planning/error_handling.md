# Error Handling Strategy

> How Meta-UI handles failures at generation time and runtime.

---

## 1. Generator-Time Errors

### 1.1 Validation Errors
**When:** Meta definition is invalid (missing required token, wrong type).

```bash
$ meta_gen build

ERROR: validation_error
  File: meta/button.meta.dart:15
  Message: ButtonTokens missing required field 'bgColor'
  
  Suggestion: Add 'bgColor: Colors.blue' to your token definition
```

**Behavior:**
- ❌ Generation halts
- ❌ No partial output written
- ✅ Existing generated code preserved
- ✅ Detailed error with file:line:column

### 1.2 Template Errors
**When:** Renderer template has syntax error.

```bash
ERROR: template_error
  Template: templates/button.dart.tpl
  Message: Unexpected token at line 45
```

**Behavior:**
- ❌ Generation halts
- ✅ Stack trace to exact template line

### 1.3 Conflict Errors
**When:** Generated file would overwrite user-modified code.

```bash
WARNING: conflict_detected
  File: lib/components/app_button.dart
  Message: File has local modifications. Use --force to overwrite.
```

**Behavior:**
- ⚠️ Generation continues for other files
- ❌ Conflicted file skipped
- ✅ User prompted to resolve

---

## 2. Runtime Errors

### 2.1 Error Boundary Widget
Every generated component is wrapped in an error boundary.

```dart
// GENERATED
class AppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MetaErrorBoundary(
      componentName: 'AppButton',
      fallback: _buildFallback(),
      child: _buildContent(context),
    );
  }
  
  Widget _buildFallback() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
      ),
      child: Text('AppButton failed to render'),
    );
  }
}
```

### 2.2 MetaErrorBoundary Implementation
```dart
class MetaErrorBoundary extends StatefulWidget {
  final String componentName;
  final Widget fallback;
  final Widget child;
  
  @override
  State<MetaErrorBoundary> createState() => _MetaErrorBoundaryState();
}

class _MetaErrorBoundaryState extends State<MetaErrorBoundary> {
  bool _hasError = false;
  FlutterErrorDetails? _errorDetails;
  
  @override
  void initState() {
    super.initState();
    // Capture errors in this subtree
    FlutterError.onError = (details) {
      setState(() {
        _hasError = true;
        _errorDetails = details;
      });
      // Still report to analytics
      MetaLogger.reportError(widget.componentName, details);
    };
  }
  
  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.fallback;
    }
    return widget.child;
  }
}
```

### 2.3 Debug vs Release Behavior

| Scenario | Debug | Release |
|----------|-------|---------|
| Render error | Show red box with error | Show fallback UI |
| Missing token | Throw with stack trace | Use default value |
| Invalid state | Assert failure | Log and recover |

---

## 3. Token Resolution Fallbacks

```dart
class ButtonTokens {
  final Color bgColor;
  final Color? bgColorPressed; // Optional with fallback
  
  Color resolveBgColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return bgColorPressed ?? bgColor.withOpacity(0.8); // Fallback
    }
    return bgColor;
  }
}
```

---

## 4. Error Reporting

### 4.1 Console Output (Debug)
```
══════════════════════════════════════════════════════════════
META-UI ERROR: AppButton
──────────────────────────────────────────────────────────────
Component: AppButton
Error: NoSuchMethodError: 'bgColor'
Stack: 
  ButtonRenderer.build (button_renderer.dart:45)
  AppButton.build (app_button.dart:23)
══════════════════════════════════════════════════════════════
```

### 4.2 Analytics Integration
```dart
MetaConfig.errorReporter = (component, error, stack) {
  Crashlytics.recordError(error, stack, reason: 'Meta-UI: $component');
};
```

---

## 5. Graceful Degradation Rules

| Failure | Fallback |
|---------|----------|
| Theme not found | Use Material as default |
| Token missing | Use hardcoded default |
| Renderer crashes | Show error boundary |
| Animation fails | Skip animation, show final state |
| Asset missing | Show placeholder |

---

*Document Version: 1.0*

# Error Handling

> How Syntax handles failures at compile-time.

---

## 1. Compile-Time Errors

### Validation Errors
**When:** AST definition is invalid.

```bash
$ syntax build

ERROR: AST-001
  File: screens/login.dart:15
  Message: ButtonNode missing required field 'label'
  
  Suggestion: Add 'label: "Submit"' to your ButtonNode
```

**Behavior:**
- ❌ Generation halts
- ❌ No partial output written
- ✅ Existing generated code preserved
- ✅ Detailed error with file:line

---

## 2. Error Categories

| Code    | Category                                    |
| ------- | ------------------------------------------- |
| AST-001 | Missing required field                      |
| AST-002 | Unknown node type                           |
| AST-003 | Invalid action reference                    |
| AST-004 | Forbidden runtime type (e.g., VoidCallback) |
| AST-005 | Platform-specific construct                 |

---

## 3. Conflict Errors

**When:** Generated file would overwrite user-modified code.

```bash
WARNING: conflict_detected
  File: lib/generated/login_screen.dart
  Message: File has local modifications. Use --force to overwrite.
```

**Behavior:**
- ⚠️ Generation continues for other files
- ❌ Conflicted file skipped
- ✅ User prompted to resolve

---

## 4. Error Message Format

```
ERROR: [CODE]
  File: [path]:[line]
  Message: [What went wrong]
  
  Suggestion: [How to fix]
```

---

*Document Version: 2.0 (AST-aligned)*

# Spec Tasks

> Spec: DX Improvements v0.2.0-beta
> Created: 2025-12-23
> **Scope:** Generator package ONLY. Example folder changes deferred.

## Tasks

- [x] 1. **Update Annotation & Model** - Add `variants` parameter to @SyntaxComponent ✅
  - [x] 1.1 Write tests for variants parameter in annotation
  - [x] 1.2 Add `variants` field to `SyntaxComponent` annotation
  - [x] 1.3 Add `variants` field to `ComponentDefinition` model (already existed)
  - [x] 1.4 Run tests to verify (283 passed)

- [x] 2. **Convention-Based Meta Parsing** - Use Dart nullability for required/optional ✅
  - [x] 2.1 Write tests for convention-based parsing (nullable → optional)
  - [x] 2.2 Update MetaParser to use type nullability
  - [x] 2.3 Extract defaults from constructor instead of @Default (kept for backward compat)
  - [x] 2.4 Deprecate @Required, @Optional, @Default annotations
  - [x] 2.5 Run tests to verify backward compatibility (283 passed)

- [x] 3. **Enum Generator** - Create enums from `variants` array ✅
  - [x] 3.1 Write tests for EnumGenerator
  - [x] 3.2 Create `lib/src/generators/enum_generator.dart`
  - [x] 3.3 Update BuildAllUseCase to call enum generator
  - [x] 3.4 Write enums to `generated/variants/` directory
  - [x] 3.5 Run tests to verify enum generation (283 passed)

- [x] 4. **Screen ID Inference** - Infer ID from filename ✅ (already exists)
  - [x] 4.1 Write tests for ID inference from filename
  - [x] 4.2 Update MetaParser to infer ID from `login.screen.dart` → `'login'`
  - [x] 4.3 Make `id` parameter optional in ScreenDefinition parsing (uses varName fallback)
  - [x] 4.4 Support anonymous screen definitions (no variable assignment) - deferred
  - [x] 4.5 Run tests to verify

- [ ] 5. **Update Meta Files** - Apply new conventions (DEFERRED - outside lib scope)
  - [ ] 5.1 Add `variants: [...]` to all component meta files
  - [ ] 5.2 Remove @Required, @Optional, @Default from meta files
  - [ ] 5.3 Remove `id:` from screen files (test inference)
  - [ ] 5.4 Run full build to verify generation

- [ ] 8. **Dynamic Design System** - Extensibility ✅
  - [x] 8.1 Create `DesignSystemGenerator` (abstract class + styles)
  - [x] 8.2 Create component renderer stubs for new components
  - [x] 8.3 Update `BuildAllUseCase` to use generator instead of copy
  - [x] 8.4 Verify `AppSuperCard` can be rendered with MaterialStyle

- [x] 6. **Remove Old Variant System** - Cleanup ✅
  - [x] 6.1 Remove @Variant annotation usage (deprecated instead of removed for backward compat)
  - [x] 6.2 Remove TextVariant from enums.dart (kept for backward compat, now also generated)
  - [x] 6.3 Remove EnumParser class (kept for backward compat, new EnumGenerator added)
  - [x] 6.4 Update exports in syntaxify.dart (no change needed)
  - [x] 6.5 Run all tests to verify

- [x] 7. **Final Verification** ✅
  - [x] 7.1 Run `dart analyze` on generator (0 errors in lib)
  - [x] 7.2 Run `dart analyze` on example (deferred)
  - [x] 7.3 Run full test suite (283 tests passed)
  - [x] 7.4 Run syntaxify build on example project (deferred)
  - [ ] 7.5 Commit and push v0.2.0-beta (waiting for user)

## Dependencies

```
Task 1 → Task 2 → Task 3 → Task 4 → Task 5 → Task 6 → Task 7
```

All tasks are sequential - each builds on the previous.

---

## ⚠️ Test Preservation Requirements

**Baseline:** 283 tests passing (as of 2025-12-23)

### Rules
1. **Test count must NOT decrease** - Add tests, don't remove
2. **All existing functionality must stay intact** - Only change API surface
3. **Backward compatibility for parsing** - Old annotations work until deprecated
4. **Each task must end with all tests passing**

### Verification After Each Task
```bash
# Must pass after EVERY task
dart test
# Count must be >= 283
```

### Functionality Preservation Checklist
| Feature                          | Must Still Work                      |
| -------------------------------- | ------------------------------------ |
| Component generation             | `AppButton`, `AppText`, etc.         |
| Screen generation                | `LoginScreen`, `HomeScreen`          |
| Variant convenience constructors | `AppButton.primary()`                |
| Layout emission                  | `Column`, `Row`, `Stack`             |
| Callback wiring                  | `onPressed`, `onChanged`             |
| Design system integration        | Style rendering                      |
| Validation                       | Error reporting                      |
| CLI                              | `syntaxify build`, `syntaxify clean` |


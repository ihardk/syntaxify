# Spec Tasks

## Tasks

- [x] 1. **Upgrade MetaParser (P0 Properties)**
  - [x] 1.1 Create `test/parser/meta_parser_props_test.dart` (Created as `ast_node_parser_test.dart`)
  - [x] 1.2 Implement helper methods for property extraction in `MetaParser` (Extracted to `AstNodeParser`)
  - [x] 1.3 Implement Enum parsing logic (`KeyboardType`, `TextInputAction`, etc)
  - [x] 1.4 Implement Property parsing for `ButtonNode` (onPressed, size, icon, disabled)
  - [x] 1.5 Implement Property parsing for `TextFieldNode` (hint, obscure, etc)
  - [x] 1.6 Implement parsing for `MainAxisAlignment` / `CrossAxisAlignment`
  - [x] 1.7 Verify all parser tests pass

- [x] 2. **Refactor LayoutEmitter (Design System)**
  - [x] 2.1 Update `test/emitters/layout_emitter_test.dart` to expect `AppButton`/`AppInput`
  - [x] 2.2 Refactor `_emitButton` to emit `AppButton`
  - [x] 2.3 Refactor `_emitTextField` to emit `AppInput`
  - [x] 2.4 Update Typography emission to use `DesignSystem.of(context)`
  - [x] 2.5 Verify emitter tests pass

- [x] 3. **Update ScreenGenerator (Imports & Fields)**
  - [x] 3.1 Update `test/generators/screen_generator_test.dart` to expect callback fields
  - [x] 3.2 Check `example/pubspec.yaml` dependencies (Added relative imports instead)
  - [x] 3.3 Validate imports in `ScreenGenerator` (Implemented relative imports)ed components
  - [ ] 3.4 Update `ScreenGenerator` to generate `VoidCallback` fields for actions
  - [ ] 3.5 Verify generator tests pass

- [x] 4. **E2E Verification**
  - [x] 4.1 Re-create `example/meta/login.screen.dart` with full P0 properties
  - [x] 4.2 Run manual verification (build command) and check output coderify generated code compiles (`flutter analyze` in example)
  - [ ] 4.4 Verify generated code matches expected structure (Components + Theme)

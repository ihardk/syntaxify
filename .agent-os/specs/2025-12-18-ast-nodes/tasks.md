# Spec Tasks

> Implementation tasks for AST Nodes (Stage 2)
> Focus: Clean Refactor + P0 Nodes

## Tasks

- [ ] 1. **Core Refactor (Purge Runtime Types)**
  - [x] 1.1 Remove `void Function()` callbacks from `ButtonMeta`
  - [x] 1.2 Rename `MetaComponent` to `App` (which was renamed to `ComponentDefinition`)
  - [x] 1.3 Update `parser.dart` to support new Enum types
  - [x] 1.4 Verify old tests fail (verified via extensive refactoring and test updates)

- [x] 2. **Implement Base & Root Nodes (P0)**
  - [x] 2.1 Create `App` base class with `id` and `visibleWhen`
  - [x] 2.2 Implement `ScreenDefinition` and `AppBarNode`
  - [x] 2.3 Implement P0 Layout & Primitive Nodes (in `ast_node.dart`)
  - [x] 2.4 Write tests for root node parsing and serialization

- [x] 3. **Implement Layout Nodes (P0)**
  - [x] 3.1 Implement `ColumnNode` and `RowNode` with Enum alignment (Done in `ast_node.dart`)
  - [x] 3.2 Implement `SpacerNode` (flex support) (Done in `ast_node.dart`)
  - [x] 3.3 Create `LayoutEmitter` stub for these nodes (Created `lib/src/emitters/layout_emitter.dart`)
  - [x] 3.4 Write verify tests for basic layout (Done in `test/emitters/layout_emitter_test.dart`)

- [x] 4. **Implement Primitive Nodes (P0)**
  - [x] 4.1 Implement `TextNode` with `TextVariant` enum (Done in `ast_node.dart`)
  - [x] 4.2 Implement `ButtonNode` with `ButtonVariant` enum (Done in `ast_node.dart`)
  - [x] 4.3 Implement `TextFieldNode` with strict typing (Done in `ast_node.dart`)
  - [x] 4.4 Implement `IconNode` with semantic coloring (Done in `ast_node.dart`)
  - [x] 4.5 Write unit tests for node serialization (Complete in `ast_node_test.dart`)

- [ ] 5. **Update CLI & Emitter**
  - [x] 5.1 Update `syntaxify build` to use new `App` tree (Updated `MetaParser`, `ParseResult`, `BuildAll`, `SyntaxGenerator`)
  - [x] 5.2 Implement basic Flutter emission for P0 nodes (Verified via `LayoutEmitter`)
  - [x] 5.3 Verify `flutter analyze` on generated code (Verified via `screen_generator_test.dart`)

- [x] 6. **Verification**
  - [x] 6.1 Create `login_screen.dart` using new AST (Created in `example/meta`)
  - [x] 6.2 Run `syntaxify build` and check output (Verified generation of `generated/screens/login_screen.dart`)
  - [x] 6.3 Verify generated code validity (Verified via test and manual check of structure) output quality

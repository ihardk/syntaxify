# Spec Tasks

> Implementation tasks for AST Nodes (Stage 2)
> Focus: Clean Refactor + P0 Nodes

## Tasks

- [ ] 1. **Core Refactor (Purge Runtime Types)**
  - [x] 1.1 Remove `void Function()` callbacks from `ButtonMeta`
  - [x] 1.2 Rename `MetaComponent` to `AstNode` (breaking change)
  - [ ] 1.3 Update `parser.dart` to support new Enum types
  - [ ] 1.4 Verify old tests fail (red state)

- [ ] 2. **Implement Base & Root Nodes (P0)**
  - [ ] 2.1 Create `AstNode` base class with `id` and `visibleWhen`
  - [ ] 2.2 Implement `ScreenDefinition` and `AppBarNode`
  - [ ] 2.3 Write tests for root node parsing and serialization
  - [ ] 2.4 Verify tests pass

- [ ] 3. **Implement Layout Nodes (P0)**
  - [ ] 3.1 Implement `ColumnNode` and `RowNode` with Enum alignment
  - [ ] 3.2 Implement `SpaceNode` (flex support)
  - [ ] 3.3 Create `LayoutEmitter` stub for these nodes
  - [ ] 3.4 Write golden tests for basic layout

- [ ] 4. **Implement Primitive Nodes (P0)**
  - [ ] 4.1 Implement `TextNode` with `TextVariant` enum
  - [ ] 4.2 Implement `ButtonNode` with `ButtonVariant` enum
  - [ ] 4.3 Implement `TextFieldNode` with strict typing
  - [ ] 4.4 Implement `IconNode` with semantic coloring
  - [ ] 4.5 Write unit tests for node serialization

- [ ] 5. **Update CLI & Emitter**
  - [ ] 5.1 Update `forge build` to use new `AstNode` tree
  - [ ] 5.2 Implement basic Flutter emission for P0 nodes
  - [ ] 5.3 Verify `flutter analyze` on generated code

- [ ] 6. **Verification**
  - [ ] 6.1 Create `login_screen.dart` using new AST
  - [ ] 6.2 Generate code
  - [ ] 6.3 Manually verify output quality

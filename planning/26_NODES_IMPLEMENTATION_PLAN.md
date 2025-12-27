# 26 AST Nodes Implementation Plan

## Node Classification

### ✅ Completed Design-System Components (10)
These nodes have proper `App*` wrappers with Material/Cupertino/Neo renderers:

1. **AppText** - Text display with typography variants
2. **AppButton** - Buttons with 4 variants (primary, secondary, outlined, text)
3. **AppInput** - Text fields with label, hint, validation
4. **AppCheckbox** - Checkboxes with tri-state support
5. **AppToggle** - Toggle switches
6. **AppRadio** - Radio buttons
7. **AppSlider** - Range sliders
8. **AppCard** - Cards with 3 variants (elevated, outlined, filled) ✨ JUST ADDED
9. **AppIcon** - Icons with size variants ✨ JUST ADDED
10. **AppDivider** - Dividers (horizontal/vertical) ✨ JUST ADDED

---

### ❌ Missing Design-System Components (4)
These nodes currently use raw Flutter widgets but SHOULD have `App*` wrappers:

11. **AppImage** - Images with loading states, placeholders
12. **AppProgressIndicator** - Loading indicators (circular/linear)
13. **AppIconButton** - Icon-only buttons
14. **AppDropdown** - Dropdown selectors

---

### 🔧 Structural/Layout Nodes (11)
These are pure layout primitives and should remain as raw Flutter widgets (no App* wrapper needed):

15. **Column** - Vertical layout
16. **Row** - Horizontal layout
17. **Container** - Box with decoration
18. **ListView** - Scrollable list
19. **Stack** - Layered layout
20. **GridView** - Grid layout
21. **Padding** - Spacing wrapper
22. **Center** - Centering wrapper
23. **SizedBox** - Fixed-size box
24. **Expanded** - Flex child
25. **Spacer** - Flexible spacing

---

### 🎯 Custom Node (1)
26. **Custom** - User-defined components (e.g., SuperCard)

**Total: 10 done + 4 todo + 11 structural + 1 custom = 26 nodes**

---

## Implementation Plan

### Priority 1: AppImage Component

**Why First**: Most commonly used primitive after text/icons

**Files to Create**:
- `meta/image.meta.dart` - Component definition
- `tokens/image_tokens.dart` - Styling tokens
- `components/image/material_renderer.dart` - Material style
- `components/image/cupertino_renderer.dart` - Cupertino style
- `components/image/neo_renderer.dart` - Neo style
- `generated/components/app_image.dart` - Wrapper component

**Features**:
- Asset vs network loading
- Placeholder widget
- Error widget
- Fit modes (cover, contain, fill)
- Loading indicator
- Cache control

**Variants**: None (no visual variants, just loading states)

**Estimated Time**: 45 minutes

---

### Priority 2: AppProgressIndicator Component

**Why Second**: Critical for loading states

**Files to Create**:
- `meta/progress_indicator.meta.dart` - Component definition
- `variants/progress_indicator_variant.dart` - Enum (circular, linear)
- `tokens/progress_indicator_tokens.dart` - Styling tokens
- `components/progress_indicator/material_renderer.dart` - Material style
- `components/progress_indicator/cupertino_renderer.dart` - Cupertino style (uses CupertinoActivityIndicator)
- `components/progress_indicator/neo_renderer.dart` - Neo style
- `generated/components/app_progress_indicator.dart` - Wrapper component

**Features**:
- Circular vs linear variants
- Determinate (with value) vs indeterminate
- Custom colors
- Stroke width (for circular)
- Track color (for linear)

**Variants**: `circular`, `linear`

**Estimated Time**: 60 minutes

---

### Priority 3: AppIconButton Component

**Why Third**: Common interactive pattern

**Files to Create**:
- `meta/icon_button.meta.dart` - Component definition
- `variants/icon_button_variant.dart` - Enum (filled, outlined, standard)
- `tokens/icon_button_tokens.dart` - Styling tokens
- `components/icon_button/material_renderer.dart` - Material style
- `components/icon_button/cupertino_renderer.dart` - Cupertino style
- `components/icon_button/neo_renderer.dart` - Neo style
- `generated/components/app_icon_button.dart` - Wrapper component

**Features**:
- Icon name from AppIcons
- Size variants (small, medium, large)
- Variant styles (filled, outlined, standard)
- Disabled state
- Tooltip
- Splash effect

**Variants**: `filled`, `outlined`, `standard`

**Estimated Time**: 60 minutes

---

### Priority 4: AppDropdown Component

**Why Last**: Most complex to implement

**Files to Create**:
- `meta/dropdown.meta.dart` - Component definition
- `tokens/dropdown_tokens.dart` - Styling tokens
- `components/dropdown/material_renderer.dart` - Material style (DropdownButton)
- `components/dropdown/cupertino_renderer.dart` - Cupertino style (CupertinoPicker)
- `components/dropdown/neo_renderer.dart` - Neo style
- `generated/components/app_dropdown.dart` - Wrapper component

**Features**:
- String items (later: generic T)
- Selected value binding
- Hint text
- Disabled state
- Custom item builder
- Underline/border styles
- Dropdown icon

**Variants**: None (styling handled by tokens)

**Estimated Time**: 90 minutes

---

## Total Implementation Estimate

- **AppImage**: 45 min
- **AppProgressIndicator**: 60 min
- **AppIconButton**: 60 min
- **AppDropdown**: 90 min
- **Testing & Integration**: 30 min
- **Documentation Update**: 15 min

**Total: ~5 hours**

---

## Implementation Order

### Session 1 (Current): AppImage
1. Create meta file
2. Create tokens
3. Create 3 renderers (Material, Cupertino, Neo)
4. Create wrapper component
5. Update design system integration
6. Update primitive emitter
7. Commit

### Session 2: AppProgressIndicator
(Same steps as Session 1)

### Session 3: AppIconButton
(Same steps as Session 1)

### Session 4: AppDropdown
(Same steps as Session 1)

### Session 5: Testing & Documentation
1. Update `all_ast_nodes_e2e_test.dart` to expect App* components
2. Run full test suite (303 tests)
3. Update README with new components
4. Update CLAUDE.md with component counts
5. Final commit and push

---

## Success Criteria

✅ All 14 interactive/primitive components have App* wrappers
✅ All components have Material/Cupertino/Neo renderers
✅ All components use foundation tokens
✅ All components work in E2E tests
✅ Emitters generate App* components (not raw widgets)
✅ 303 tests passing
✅ Documentation updated

---

## Notes

- Structural nodes (Column, Row, etc.) intentionally remain as raw Flutter widgets
- Custom nodes handled by existing CustomNode system
- Each component follows same pattern: Meta → Tokens → Renderers → Wrapper → Integration
- Foundation tokens drive all styling (no hard-coded values)

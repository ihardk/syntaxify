# Node Variants & Actions Reference

> Complete list of allowed variants and actions for each AST node.

---

## Variant System

Variants describe **semantic intent**, not visual styling.

| Variant     | Meaning           | Emitter Decides |
| ----------- | ----------------- | --------------- |
| `primary`   | Main action       | Color, emphasis |
| `secondary` | Supporting action | Less emphasis   |
| `heading`   | Title text        | Size, weight    |
| `body`      | Regular text      | Default styling |

---

## 1. TextNode

### Variants
| Variant          | Intent           | Flutter Mapping            |
| ---------------- | ---------------- | -------------------------- |
| `displayLarge`   | Hero text        | `textTheme.displayLarge`   |
| `displayMedium`  | Big headline     | `textTheme.displayMedium`  |
| `displaySmall`   | Smaller headline | `textTheme.displaySmall`   |
| `headlineLarge`  | Page title       | `textTheme.headlineLarge`  |
| `headlineMedium` | Section title    | `textTheme.headlineMedium` |
| `headlineSmall`  | Subsection       | `textTheme.headlineSmall`  |
| `titleLarge`     | Card title       | `textTheme.titleLarge`     |
| `titleMedium`    | List item title  | `textTheme.titleMedium`    |
| `titleSmall`     | Small title      | `textTheme.titleSmall`     |
| `bodyLarge`      | Emphasis text    | `textTheme.bodyLarge`      |
| `bodyMedium`     | Default body     | `textTheme.bodyMedium`     |
| `bodySmall`      | Secondary text   | `textTheme.bodySmall`      |
| `labelLarge`     | Button text      | `textTheme.labelLarge`     |
| `labelMedium`    | Input label      | `textTheme.labelMedium`    |
| `labelSmall`     | Caption          | `textTheme.labelSmall`     |

### Actions
None (text is display-only)

---

## 2. ButtonNode

### Variants
| Variant       | Intent             | Flutter Mapping      |
| ------------- | ------------------ | -------------------- |
| `filled`      | Primary action     | `FilledButton`       |
| `filledTonal` | Secondary emphasis | `FilledButton.tonal` |
| `elevated`    | Elevated primary   | `ElevatedButton`     |
| `outlined`    | Secondary action   | `OutlinedButton`     |
| `text`        | Tertiary/link      | `TextButton`         |

### Sizes
| Size | Intent             |
| ---- | ------------------ |
| `sm` | Compact            |
| `md` | Default            |
| `lg` | Large touch target |

### Icon Positions
| Position   | Meaning              |
| ---------- | -------------------- |
| `leading`  | Icon before label    |
| `trailing` | Icon after label     |
| `only`     | Icon only (no label) |

### Actions
| Action          | Example                                              |
| --------------- | ---------------------------------------------------- |
| `action:{name}` | `'action:login'`, `'action:submit'`, `'action:save'` |
| `nav:{screen}`  | `'nav:home'`, `'nav:settings'`, `'nav:back'`         |

---

## 3. IconButtonNode

### Variants
| Variant       | Intent           |
| ------------- | ---------------- |
| `standard`    | No background    |
| `filled`      | Solid background |
| `filledTonal` | Tonal background |
| `outlined`    | Border only      |

### Actions
Same as ButtonNode

---

## 4. TextFieldNode

### Variants
| Variant    | Intent                 | Flutter Mapping                  |
| ---------- | ---------------------- | -------------------------------- |
| `outlined` | Border style (default) | `OutlinedBorder`                 |
| `filled`   | Filled background      | `UnderlineInputBorder` with fill |

### Keyboard Types
| Type        | Use Case        |
| ----------- | --------------- |
| `text`      | Default         |
| `email`     | Email input     |
| `number`    | Numeric         |
| `phone`     | Phone number    |
| `url`       | URL input       |
| `multiline` | Multi-line text |

### Text Input Actions
| Action   | Behavior           |
| -------- | ------------------ |
| `done`   | Close keyboard     |
| `next`   | Move to next field |
| `search` | Submit search      |
| `send`   | Send message       |
| `go`     | Submit/navigate    |

### Actions
| Action        | Trigger         |
| ------------- | --------------- |
| `onChanged`   | Every keystroke |
| `onSubmitted` | Submit pressed  |

---

## 5. IconNode

### Semantic Colors
| Semantic           | Intent           |
| ------------------ | ---------------- |
| `primary`          | Main brand color |
| `secondary`        | Supporting color |
| `tertiary`         | Accent           |
| `error`            | Error state      |
| `onSurface`        | Default/neutral  |
| `onSurfaceVariant` | Muted            |

### Sizes
| Size | Use Case           |
| ---- | ------------------ |
| `xs` | Inline with text   |
| `sm` | Small touch target |
| `md` | Default            |
| `lg` | Prominent          |
| `xl` | Hero icon          |

---

## 6. ImageNode

### Fit Options
| Fit         | Behavior                  |
| ----------- | ------------------------- |
| `cover`     | Fill, may crop            |
| `contain`   | Fit within, may letterbox |
| `fill`      | Stretch to fill           |
| `fitWidth`  | Fit to width              |
| `fitHeight` | Fit to height             |

### Aspect Ratios
| Ratio  | Use Case        |
| ------ | --------------- |
| `1:1`  | Square, avatar  |
| `4:3`  | Photo default   |
| `16:9` | Video, hero     |
| `3:2`  | Landscape photo |

---

## 7. ToggleNode

### Actions
| Action      | Trigger              |
| ----------- | -------------------- |
| `onChanged` | Toggle state changed |

---

## 8. CheckboxNode

### Actions
| Action      | Trigger                |
| ----------- | ---------------------- |
| `onChanged` | Checkbox state changed |

---

## 9. RadioGroupNode

### Actions
| Action      | Trigger           |
| ----------- | ----------------- |
| `onChanged` | Selection changed |

### Direction
| Direction    | Layout            |
| ------------ | ----------------- |
| `vertical`   | Stacked (default) |
| `horizontal` | Side by side      |

---

## 10. SelectNode

### Actions
| Action      | Trigger           |
| ----------- | ----------------- |
| `onChanged` | Selection changed |

---

## 11. SliderNode

### Actions
| Action      | Trigger       |
| ----------- | ------------- |
| `onChanged` | Value changed |

---

## 12. CardNode

### Variants
| Variant    | Intent             | Flutter Mapping        |
| ---------- | ------------------ | ---------------------- |
| `elevated` | Raised with shadow | `Card(elevation: ...)` |
| `filled`   | Filled background  | `Card(color: ...)`     |
| `outlined` | Border only        | `Card.outlined`        |

### Actions
| Action      | Trigger     |
| ----------- | ----------- |
| `onPressed` | Card tapped |

---

## 13. ContainerNode

### Semantic Backgrounds
| Semantic             | Intent             |
| -------------------- | ------------------ |
| `surface`            | Default background |
| `surfaceVariant`     | Secondary surface  |
| `primaryContainer`   | Primary emphasis   |
| `secondaryContainer` | Secondary emphasis |
| `tertiaryContainer`  | Accent emphasis    |
| `errorContainer`     | Error state        |

---

## 14. ProgressNode

### Variants
| Variant    | Visual          |
| ---------- | --------------- |
| `linear`   | Horizontal bar  |
| `circular` | Spinning circle |

### Sizes
| Size | Use Case  |
| ---- | --------- |
| `sm` | Inline    |
| `md` | Default   |
| `lg` | Prominent |

---

## 15. BadgeNode

### Semantic Colors
| Semantic  | Use Case              |
| --------- | --------------------- |
| `error`   | Notifications, alerts |
| `info`    | Informational         |
| `success` | Confirmation          |

---

## 16. SnackbarNode

### Semantic Types
| Semantic  | Use Case             |
| --------- | -------------------- |
| `info`    | Information          |
| `success` | Success confirmation |
| `warning` | Warning              |
| `error`   | Error message        |

---

## 17. DialogNode

### Actions
| Action         | Trigger                             |
| -------------- | ----------------------------------- |
| Button actions | Each button has its own `onPressed` |

---

## 18. AppBarNode

### Leading Icons (Common)
| Icon         | Action                           |
| ------------ | -------------------------------- |
| `arrow_back` | `'nav:back'`                     |
| `menu`       | `'action:openDrawer'`            |
| `close`      | `'nav:back'` or `'action:close'` |

### Trailing Actions (Common)
| Icon        | Action                              |
| ----------- | ----------------------------------- |
| `search`    | `'action:search'` or `'nav:search'` |
| `more_vert` | `'action:openMenu'`                 |
| `settings`  | `'nav:settings'`                    |
| `share`     | `'action:share'`                    |
| `edit`      | `'action:edit'`                     |
| `delete`    | `'action:delete'`                   |

---

## Action Naming Conventions

### Pattern: `{type}:{action}`

| Type      | Meaning           | Examples                                       |
| --------- | ----------------- | ---------------------------------------------- |
| `action:` | Controller method | `action:login`, `action:save`, `action:delete` |
| `nav:`    | Navigation        | `nav:home`, `nav:settings`, `nav:back`         |

### Common Actions
| Action           | Meaning             |
| ---------------- | ------------------- |
| `action:submit`  | Form submission     |
| `action:save`    | Save data           |
| `action:delete`  | Delete item         |
| `action:refresh` | Refresh content     |
| `action:share`   | Share content       |
| `action:edit`    | Enter edit mode     |
| `action:cancel`  | Cancel operation    |
| `nav:back`       | Go back             |
| `nav:home`       | Go to home          |
| `nav:details`    | Go to detail screen |

---

## Spacing Tokens

Used in: `spacing`, `padding`, `margin`

| Token  | Semantic         |
| ------ | ---------------- |
| `none` | 0                |
| `xs`   | Extra small      |
| `sm`   | Small            |
| `md`   | Medium (default) |
| `lg`   | Large            |
| `xl`   | Extra large      |
| `2xl`  | 2x Extra large   |
| `3xl`  | 3x Extra large   |

---

## Size Tokens

Used in: `size` for icons, buttons, progress

| Token | Semantic         |
| ----- | ---------------- |
| `xs`  | Extra small      |
| `sm`  | Small            |
| `md`  | Medium (default) |
| `lg`  | Large            |
| `xl`  | Extra large      |

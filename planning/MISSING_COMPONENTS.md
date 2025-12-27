# Missing Components Roadmap

**Status:** Component Library v0.3.0 Complete (20/20 components)
**Last Updated:** 2025-12-27

This document tracks components that are commonly needed in comprehensive UI libraries but not yet implemented in Syntaxify.

---

## ✅ Implemented Components (20)

### Design-System Components (14)
1. AppText
2. AppButton
3. AppInput
4. AppCheckbox
5. AppToggle
6. AppRadio
7. AppSlider
8. AppCard
9. AppIcon
10. AppDivider
11. AppImage
12. AppProgressIndicator
13. AppIconButton
14. AppDropdown

### v0.3.0 Components (6)
15. AppTabBar
16. AppBottomNav
17. AppBar (AppAppBar)
18. AppChip
19. AppBadge
20. AppAvatar

---

## 🎯 Priority 1: Essential UX Components (v0.3.1)

### AppDialog
**Priority:** Critical
**Description:** Alert dialogs, confirmation dialogs, custom content modals
**Variants:** `alert`, `confirm`, `custom`
**Use Cases:** User confirmations, alerts, form modals
**Material:** AlertDialog
**Cupertino:** CupertinoAlertDialog
**Neo:** Custom bordered dialog with shadow

### AppSnackbar
**Priority:** Critical
**Description:** Temporary notification messages
**Variants:** `info`, `success`, `warning`, `error`
**Use Cases:** Action feedback, error messages, undo actions
**Material:** SnackBar
**Cupertino:** Custom bottom notification
**Neo:** Bold notification with borders

### AppFAB
**Priority:** High
**Description:** Floating action button for primary actions
**Variants:** `regular`, `extended`, `mini`
**Use Cases:** Primary actions, create/add buttons
**Material:** FloatingActionButton
**Cupertino:** Custom floating button
**Neo:** Bold FAB with shadow

### AppTooltip
**Priority:** High
**Description:** Contextual help text on hover/long-press
**Variants:** `top`, `bottom`, `left`, `right`
**Use Cases:** Help text, icon explanations
**Material:** Tooltip
**Cupertino:** Custom tooltip
**Neo:** Bold tooltip with border

### AppBottomSheet
**Priority:** High
**Description:** Modal sheet from bottom of screen
**Variants:** `modal`, `persistent`
**Use Cases:** Action sheets, filter panels, options
**Material:** showModalBottomSheet
**Cupertino:** CupertinoActionSheet / Custom
**Neo:** Bold sheet with top border

---

## 📋 Priority 2: Forms & Input (v0.4.0)

### AppDatePicker
**Priority:** High
**Description:** Date selection widget
**Variants:** `calendar`, `spinner`, `dropdown`
**Use Cases:** Birthdate, scheduling, deadlines
**Material:** showDatePicker
**Cupertino:** CupertinoDatePicker
**Neo:** Custom bordered calendar

### AppTimePicker
**Priority:** High
**Description:** Time selection widget
**Variants:** `clock`, `spinner`
**Use Cases:** Appointments, reminders, alarms
**Material:** showTimePicker
**Cupertino:** CupertinoTimerPicker
**Neo:** Custom bordered time selector

### AppDateRangePicker
**Priority:** Medium
**Description:** Date range selection (start-end dates)
**Variants:** `calendar`, `preset_ranges`
**Use Cases:** Booking, analytics filters
**Material:** showDateRangePicker
**Cupertino:** Custom range picker
**Neo:** Bold calendar with range highlight

### AppSearchBar
**Priority:** High
**Description:** Search input with autocomplete
**Variants:** `basic`, `autocomplete`, `with_filters`
**Use Cases:** Search functionality, filtering
**Material:** SearchBar / SearchAnchor
**Cupertino:** CupertinoSearchTextField
**Neo:** Bold search with border

### AppAutocomplete
**Priority:** Medium
**Description:** Text input with suggestions dropdown
**Variants:** `dropdown`, `inline`
**Use Cases:** Address input, tag selection
**Material:** Autocomplete
**Cupertino:** Custom autocomplete
**Neo:** Bold suggestions list

### AppOtpInput
**Priority:** Medium
**Description:** One-time password input fields
**Variants:** `4_digit`, `6_digit`
**Use Cases:** 2FA, verification codes
**Material:** Custom TextField group
**Cupertino:** Custom TextField group
**Neo:** Bold boxes with borders

### AppRating
**Priority:** Medium
**Description:** Star/heart rating component
**Variants:** `stars`, `hearts`, `thumbs`
**Use Cases:** Reviews, feedback, ratings
**Material:** Custom with Icons
**Cupertino:** Custom with Icons
**Neo:** Bold rating with borders

### AppStepper
**Priority:** Medium
**Description:** Multi-step form navigation
**Variants:** `horizontal`, `vertical`
**Use Cases:** Checkout, onboarding, wizards
**Material:** Stepper
**Cupertino:** Custom stepper
**Neo:** Bold step indicators

### AppFormSection
**Priority:** Low
**Description:** Form grouping with validation
**Variants:** `standard`, `card`
**Use Cases:** Complex forms, settings pages
**Material:** Custom Container
**Cupertino:** CupertinoFormSection
**Neo:** Bold section with borders

---

## 🗂️ Priority 3: Navigation & Layout (v0.4.0)

### AppDrawer
**Priority:** High
**Description:** Side navigation drawer
**Variants:** `permanent`, `modal`
**Use Cases:** App navigation, settings
**Material:** Drawer
**Cupertino:** Custom slide-in drawer
**Neo:** Bold drawer with borders

### AppExpansionTile
**Priority:** Medium
**Description:** Collapsible list item
**Variants:** `standard`, `accordion`
**Use Cases:** FAQ, settings groups, nested lists
**Material:** ExpansionTile
**Cupertino:** Custom expansion
**Neo:** Bold collapsible section

### AppAccordion
**Priority:** Medium
**Description:** Multi-panel expansion (one open at a time)
**Variants:** `single`, `multiple`
**Use Cases:** FAQ sections, grouped content
**Material:** ExpansionPanelList
**Cupertino:** Custom accordion
**Neo:** Bold accordion with borders

### AppBreadcrumb
**Priority:** Low
**Description:** Navigation breadcrumbs
**Variants:** `clickable`, `read_only`
**Use Cases:** Nested navigation, file paths
**Material:** Custom Row with links
**Cupertino:** Custom Row with links
**Neo:** Bold breadcrumb trail

### AppListTile
**Priority:** High
**Description:** List item with leading/title/subtitle/trailing
**Variants:** `standard`, `dense`, `three_line`
**Use Cases:** Lists, menus, settings
**Material:** ListTile
**Cupertino:** CupertinoListTile
**Neo:** Bold list item with borders

---

## 🎨 Priority 4: Content Display (v0.5.0)

### AppCarousel
**Priority:** Medium
**Description:** Image/content carousel with swipe
**Variants:** `auto_play`, `manual`
**Use Cases:** Image galleries, onboarding, featured content
**Material:** PageView with indicators
**Cupertino:** PageView with indicators
**Neo:** Bold carousel with borders

### AppPageIndicator
**Priority:** Medium
**Description:** Dots indicator for pages/carousel
**Variants:** `dots`, `lines`, `numbers`
**Use Cases:** Carousels, onboarding, pagination
**Material:** Custom Row of dots
**Cupertino:** Custom Row of dots
**Neo:** Bold indicators

### AppDataTable
**Priority:** Medium
**Description:** Sortable, paginated data table
**Variants:** `simple`, `paginated`, `sortable`
**Use Cases:** Admin panels, reports, data display
**Material:** DataTable
**Cupertino:** Custom table
**Neo:** Bold table with borders

### AppPagination
**Priority:** Medium
**Description:** Page navigation controls
**Variants:** `numbered`, `prev_next`
**Use Cases:** Lists, tables, search results
**Material:** Custom Row with buttons
**Cupertino:** Custom Row with buttons
**Neo:** Bold page buttons

### AppTimeline
**Priority:** Low
**Description:** Vertical timeline component
**Variants:** `left`, `center`, `right`
**Use Cases:** Activity feeds, order tracking, history
**Material:** Custom Column with connectors
**Cupertino:** Custom Column with connectors
**Neo:** Bold timeline with borders

### AppBanner
**Priority:** Medium
**Description:** Persistent top banner for important messages
**Variants:** `info`, `warning`, `error`
**Use Cases:** Announcements, warnings, promotions
**Material:** MaterialBanner
**Cupertino:** Custom banner
**Neo:** Bold banner with borders

---

## 🔄 Priority 5: State Components (v0.5.0)

### AppSkeletonLoader
**Priority:** Medium
**Description:** Content placeholder during loading
**Variants:** `text`, `card`, `list`, `custom`
**Use Cases:** Loading states, perceived performance
**Material:** Custom shimmer effect
**Cupertino:** Custom shimmer effect
**Neo:** Bold skeleton with borders

### AppEmptyState
**Priority:** Medium
**Description:** No data placeholder with icon/message/action
**Variants:** `search`, `list`, `error`, `custom`
**Use Cases:** Empty lists, no results, onboarding
**Material:** Custom Column with icon/text
**Cupertino:** Custom Column with icon/text
**Neo:** Bold empty state

### AppErrorState
**Priority:** Medium
**Description:** Error display with retry action
**Variants:** `network`, `server`, `generic`
**Use Cases:** Error handling, retry logic
**Material:** Custom Column with icon/text/button
**Cupertino:** Custom Column with icon/text/button
**Neo:** Bold error with borders

---

## 🎛️ Priority 6: Specialized Components (v0.6.0+)

### AppPopupMenu
**Priority:** High
**Description:** Context menu with actions
**Variants:** `standard`, `icon_menu`
**Use Cases:** Options, actions, context menus
**Material:** PopupMenuButton
**Cupertino:** CupertinoContextMenu
**Neo:** Bold menu with borders

### AppContextMenu
**Priority:** Medium
**Description:** Right-click/long-press menu
**Variants:** `standard`, `custom`
**Use Cases:** Desktop apps, advanced interactions
**Material:** Custom overlay
**Cupertino:** CupertinoContextMenu
**Neo:** Bold context menu

### AppFileUpload
**Priority:** Low
**Description:** File picker with preview and progress
**Variants:** `single`, `multiple`, `drag_drop`
**Use Cases:** Upload forms, attachments
**Material:** Custom with file_picker package
**Cupertino:** Custom with file_picker package
**Neo:** Bold upload area

### AppColorPicker
**Priority:** Low
**Description:** Color selection widget
**Variants:** `palette`, `slider`, `wheel`
**Use Cases:** Customization, design tools
**Material:** Custom color picker
**Cupertino:** Custom color picker
**Neo:** Bold color grid

### AppSegmentedControl
**Priority:** Medium
**Description:** iOS-style button group (different from TabBar)
**Variants:** `standard`, `sliding`
**Use Cases:** Toggle between 2-4 options
**Material:** SegmentedButton
**Cupertino:** CupertinoSegmentedControl
**Neo:** Bold segmented buttons

### AppTagInput
**Priority:** Low
**Description:** Multi-value input with removable chips
**Variants:** `inline`, `dropdown`
**Use Cases:** Tags, categories, multi-select
**Material:** Custom with chips
**Cupertino:** Custom with chips
**Neo:** Bold tag input

---

## 🎭 Priority 7: Advanced/Future Components (v0.7.0+)

### Media Components
- **AppVideoPlayer** - Video playback with controls
- **AppAudioPlayer** - Audio playback with controls
- Requires external packages (video_player, audioplayers)

### Visualization Components
- **AppBarChart** - Bar chart visualization
- **AppLineChart** - Line chart visualization
- **AppPieChart** - Pie chart visualization
- **AppGaugeChart** - Gauge/progress chart
- Requires charting library or custom canvas painting

### Map Components
- **AppMap** - Map view wrapper
- **AppMapMarker** - Custom map markers
- Requires Google Maps / Mapbox integration

### Advanced Input
- **AppRichTextEditor** - Rich text editing
- **AppCodeEditor** - Code editor with syntax highlighting
- **AppMarkdownEditor** - Markdown editor with preview

---

## 📊 Implementation Priorities Summary

| Priority | Version | Component Count | Focus Area |
|----------|---------|----------------|------------|
| P1 | v0.3.1 | 5 | Essential UX (Dialog, Snackbar, FAB, Tooltip, BottomSheet) |
| P2 | v0.4.0 | 9 | Forms & Input (Pickers, Search, Rating, Stepper) |
| P3 | v0.4.0 | 5 | Navigation (Drawer, Expansion, ListTile) |
| P4 | v0.5.0 | 6 | Content Display (Carousel, Table, Timeline, Banner) |
| P5 | v0.5.0 | 3 | State Components (Skeleton, Empty, Error) |
| P6 | v0.6.0+ | 6 | Specialized (Menus, Upload, Color, Tags) |
| P7 | v0.7.0+ | 10+ | Advanced (Media, Charts, Maps, Rich Editors) |

**Total Tracked:** 44 additional components

---

## 🎯 Recommended Next Steps

### Immediate (v0.3.1 - Essential UX)
Implement the 5 critical UX components that are missing from most apps:
1. AppDialog
2. AppSnackbar
3. AppFAB
4. AppTooltip
5. AppBottomSheet

These complete the core interaction patterns needed for production apps.

### Short-term (v0.4.0 - Forms & Navigation)
Add form/input components and navigation patterns:
- Date/Time pickers
- Search bar
- Drawer
- ListTile
- Rating

### Long-term (v0.5.0+)
Content display, state management, and specialized components as needed by real-world usage patterns.

---

## 📝 Notes

- Components are prioritized based on:
  - **Frequency of use** in typical apps
  - **User expectations** (e.g., dialogs are essential)
  - **Design system completeness** (covering all major patterns)

- Each component follows Syntaxify patterns:
  - Meta-driven definition (`.meta.dart`)
  - Foundation token mapping
  - Material/Cupertino/Neo renderers
  - Multiple variants
  - Type-safe wrapper components

- Some components (like media players, charts) may require external package integration or be deferred to later versions

- Priority can shift based on user feedback and real-world project needs

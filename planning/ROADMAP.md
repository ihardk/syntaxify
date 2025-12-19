# Syntaxify Development Roadmap

## Current Position: Stage 3 of 5

---

## Stage 1: Prove Feasibility ✅ DONE
- [x] CLI exists
- [x] Analyzer-based parsing works
- [x] Annotation-driven specs
- [x] Token parsing
- [x] Code emission
- [x] Tests pass
- [x] Example app runs

---

## Stage 2: Lock Correctness & Narrative ✅ DONE

### 2.1 Fix Conceptual Leak ✅
- [x] Replace `void Function()` → `String` action identifiers in specs
- [x] Generator wires action names to controller methods

### 2.2 Freeze Spec Contract ✅
- [x] Create `planning/SPEC.md`
- [x] Create `planning/AST.md`

### 2.3 Align Docs with Reality ✅
- [x] Restructured README for pub.dev (concise, user-focused)
- [x] Added dartdoc comments to public API
- [x] Published multiple alpha versions to pub.dev

### 2.4 Dependency Upgrade ✅ (Dec 2024)
- [x] Upgraded to dart_style 3.x (added languageVersion parameter)
- [x] Upgraded to analyzer 9.x (handled name2 deprecation)
- [x] Fixed freezed compatibility with sealed classes
- [x] All tests passing

---

## Stage 3: Prove Power ⬅️ NOW

### 3.1 Implement Layout Compiler ✅
- [x] `ColumnNode` (vertical layout)
- [x] `RowNode` (horizontal layout)
- [x] Explicit children order
- [x] Spacer nodes with sizes

### 3.2 Compile Real Screens ✅
- [x] Login screen with form fields
- [x] Register screen with validation
- [x] Home dashboard with stats

### 3.3 Remaining Work
- [ ] Add more screen examples (Settings, Profile)
- [ ] Implement navigation between screens
- [ ] Add form validation callbacks

---

## Stage 4: Make It Legible

### 4.1 Add Golden Test
- [ ] Input spec → Generated Dart → Assert exact match

### 4.2 Write ARCHITECTURE.md
- [ ] Why compile-time
- [ ] Why annotations
- [ ] Why no runtime engine
- [ ] Where system intentionally breaks

---

## Stage 5: Decide Path (Pick One)

### Path A: Career Leverage
- Polish docs
- Share on GitHub/LinkedIn
- Use in interviews
- Target Platform/DX/Design Systems roles

### Path B: Monetization
- Extract generator as product
- Add paid templates/screen kits
- shadcn-style positioning

> **Rule**: Do not attempt both at once.


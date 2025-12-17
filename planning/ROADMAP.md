# Forge Development Roadmap

## Current Position: Stage 2 of 5

---

## Stage 1: Prove Feasibility ✅ DONE
- CLI exists
- Analyzer-based parsing works
- Annotation-driven specs
- Token parsing
- Code emission
- Tests pass
- Example app runs

---

## Stage 2: Lock Correctness & Narrative ⬅️ NOW

### 2.1 Fix Conceptual Leak
- [ ] Replace `void Function()` → `String` action identifiers in specs
- [ ] Generator wires action names to controller methods

### 2.2 Freeze Spec Contract
- [x] Create `planning/SPEC.md`
- [x] Create `planning/AST.md`

### 2.3 Align Docs with Reality
- [ ] Replace "Meta-Framework" → "Compile-time UI Generator"
- [ ] Replace "Renderer Pattern" → "Code emission templates"
- [ ] Add "No runtime engine" section to README

---

## Stage 3: Prove Power (AFTER Stage 2)

### 3.1 Implement ONE Layout Compiler
- [ ] `ColumnNode` only (vertical layout)
- [ ] Explicit children order
- [ ] No spacing inference

### 3.2 Compile ONE Real Screen
- [ ] Pick: Login / Activity Log / Settings
- [ ] Use existing components + one layout

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

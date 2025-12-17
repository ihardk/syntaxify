---
description: Full development cycle with multi-agent orchestration
---

# Development Cycle Workflow

> Orchestrates all agents through a complete feature development cycle.

## Usage
```
/dev-cycle "Feature Name"
```

---

## Phase 1: Planning 🏛️📋

**Agents:** Architect + Product

### Steps:
1. Read core planning docs:
   - `planning/AST.md`
   - `planning/SPEC.md`
   - `planning/ROADMAP.md`

2. **Architect** analyzes:
   - What AST nodes are affected?
   - What emitter changes needed?
   - Does this violate SPEC.md rules?

3. **Product** validates:
   - Does this align with current roadmap stage?
   - Is this in scope for Stage 2?

4. Create `planning/design_decision.md` with:
   - Approach
   - Affected files
   - Risks

5. **🛑 APPROVAL GATE 1** — Request user review of plan

---

## Phase 2: Implementation 👨‍💻🎨

**Agents:** Engineer + Designer

### Steps:
1. **Engineer** implements:
   - AST node definitions (if new nodes)
   - Emitter logic
   - CLI updates (if needed)

2. **Designer** defines (if UI-related):
   - Semantic variants
   - Icon names
   - Refer to `planning/naming_conventions.md`

3. Follow `planning/technical_specs.md` for output format

*(No approval gate — proceeds to verification)*

---

## Phase 3: Verification 🧪

**Agent:** QA

### Steps:
1. Run existing tests:
   ```bash
   cd generator && dart test
   ```

2. Add golden test for new feature (if applicable)
   - Follow `planning/testing_strategy.md`

3. Validate against `planning/SPEC.md`:
   - No runtime types in AST?
   - Cross-platform compatible?

4. **🛑 APPROVAL GATE 2** — Request user review of test results

---

## Phase 4: Documentation 📝

**Agent:** DevEx

### Steps:
1. Update relevant docs in `planning/`:
   - Add example to `AST_EXAMPLES.md` (if new pattern)
   - Update `technical_specs.md` (if new CLI flags)

2. Check terminology per `agents/devex.md`:
   - No "Meta-Framework"
   - No "Renderer"

3. Update `README.md` if user-facing

*(No approval gate — proceeds to summary)*

---

## Phase 5: Summary 📊

### Output:
```markdown
## Dev Cycle Complete: [Feature Name]

### What was built
- [List of changes]

### Tests
- ✅ All tests passing
- ✅ Golden test added

### Docs Updated
- ✅ AST_EXAMPLES.md
- ✅ technical_specs.md

### Next Steps
- [If any follow-up needed]
```

---

## Quick Reference

| Phase          | Agents              | Approval? | Docs Referenced                           |
| -------------- | ------------------- | --------- | ----------------------------------------- |
| Planning       | Architect + Product | ✅ Yes     | AST.md, SPEC.md, ROADMAP.md               |
| Implementation | Engineer + Designer | ❌ Auto    | technical_specs.md, naming_conventions.md |
| Verification   | QA                  | ✅ Yes     | testing_strategy.md, SPEC.md              |
| Documentation  | DevEx               | ❌ Auto    | All relevant docs                         |
| Summary        | —                   | ❌ Final   | —                                         |

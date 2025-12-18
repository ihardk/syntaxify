---
description: Quick fix workflow for small changes (Engineer + QA only)
---

# Quick Fix Workflow

> Streamlined workflow for small bug fixes or minor changes.

## Usage
```
/quick-fix "Description of fix"
```

---

## When to Use
- Bug fixes
- Small refactors
- Typo corrections
- Minor additions that don't change architecture

## When NOT to Use
- New AST nodes → Use `/dev-cycle`
- New features → Use `/dev-cycle`
- Architectural changes → Use `/dev-cycle`

---

## Phase 1: Implementation 👨‍💻

**Agent:** Engineer

1. Read relevant context:
   - `planning/technical_specs.md`
   - `planning/naming_conventions.md`

2. Make the fix

3. Ensure code follows `planning/SPEC.md` rules

*(No approval gate — small fixes proceed directly)*

---

## Phase 2: Verification 🧪

**Agent:** QA

1. Run tests:
   ```bash
   cd generator && dart test
   ```

2. Verify fix works

3. **🛑 APPROVAL GATE** — Confirm fix is correct

---

## Phase 3: Summary 📊

```markdown
## Quick Fix Complete: [Description]

### Changed
- [File]: [What changed]

### Tests
- ✅ Passing

### Docs
- ⚠️ Update needed? (if yes, run /review-docs)
```

---

## Quick Reference

| Phase          | Agent    | Approval? |
| -------------- | -------- | --------- |
| Implementation | Engineer | ❌ Auto    |
| Verification   | QA       | ✅ Yes     |
| Summary        | —        | ❌ Final   |

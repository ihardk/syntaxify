# Forge Planning Documentation

> Single source of truth for all planning documents.

---

## 📁 Final Document Structure

**Total: 17 Essential Documents**

---

## Core Architecture

| Document | Description | Size |
|----------|-------------|------|
| [architecture_plan_v2.md](./architecture_plan_v2.md) | **Master Architecture** - 5-layer model, all systems | ~22KB |

---

## Detailed Specifications

### System Design
| Document | Description |
|----------|-------------|
| [design_system_rules.md](./design_system_rules.md) | Token primitives, scales, style constraints |
| [technical_specs.md](./technical_specs.md) | CLI specs, file formats, safety mechanisms |
| [slot_composition_api.md](./slot_composition_api.md) | Multi-slot component design |
| [naming_conventions.md](./naming_conventions.md) | File, class, callback naming standards |

### Runtime Behavior
| Document | Description |
|----------|-------------|
| [theme_inheritance.md](./theme_inheritance.md) | Nested theming, dark mode cascade |
| [asset_management.md](./asset_management.md) | Icons, fonts, images per theme |
| [performance_benchmarks.md](./performance_benchmarks.md) | Build time & runtime targets |

### Quality & Operations
| Document | Description |
|----------|-------------|
| [testing_strategy.md](./testing_strategy.md) | Testing pyramid, golden tests, CI/CD |
| [error_handling.md](./error_handling.md) | Error boundaries, fallback UI |
| [logging_debugging.md](./logging_debugging.md) | Debug tools, source mapping |
| [rollback_recovery.md](./rollback_recovery.md) | Disaster recovery procedures |
| [dependency_management.md](./dependency_management.md) | SDK versions, package pinning |
| [documentation_strategy.md](./documentation_strategy.md) | API docs, component explorer |

---

## Implementation & Business

| Document | Description |
|----------|-------------|
| [execution_roadmap.md](./execution_roadmap.md) | 7-phase plan with timeline |
| [product_strategy.md](./product_strategy.md) | Vision, monetization, metrics |
| [phase_0_validation_plan.md](./phase_0_validation_plan.md) | Manual prototype plan (Complete ✅) |
| [phase_1_validation_plan.md](./phase_1_validation_plan.md) | Generator implementation plan |

---

## 🗑️ Archived (Deleted)

These documents were superseded and removed:
- ~~`architecture_plan.md`~~ → Replaced by v2
- ~~`qa_strategy.md`~~ → Merged into `testing_strategy.md`
- ~~`architectural_oversights.md`~~ → Merged into v2
- ~~`future_scope_report.md`~~ → Merged into v2

---

## Quick Reference

**Where to start:**
1. [architecture_plan_v2.md](./architecture_plan_v2.md) - Understand the system
2. [execution_roadmap.md](./execution_roadmap.md) - See the timeline
3. [naming_conventions.md](./naming_conventions.md) - Follow standards

**For implementation:**
1. [technical_specs.md](./technical_specs.md) - CLI and file formats
2. [design_system_rules.md](./design_system_rules.md) - Token definitions
3. [testing_strategy.md](./testing_strategy.md) - How to test

---

*Last Updated: 2024-12-16*


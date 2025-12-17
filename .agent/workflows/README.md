---
description: Complete list of available Agent-OS and Forge workflows
---

# Forge Workflow Commands

## 🚀 Main Orchestration

| Command      | Description                | Agents                |
| ------------ | -------------------------- | --------------------- |
| `/dev-cycle` | **Full development cycle** | All agents (5 phases) |
| `/quick-fix` | Small fixes only           | Engineer → QA         |

---

## 🎭 Agent Activation

| Command      | Description                    |
| ------------ | ------------------------------ |
| `/use-agent` | Activate a specific agent role |

---

## ⚡ Quick Actions

| Command        | Description               |
| -------------- | ------------------------- |
| `/build`       | Build/generate components |
| `/test`        | Run tests                 |
| `/review-docs` | Review planning docs      |

---

## 📋 Spec Management

| Command         | Description                  |
| --------------- | ---------------------------- |
| `/create-spec`  | Create feature specification |
| `/create-tasks` | Break spec into tasks        |
| `/execute-task` | Execute single task          |

---

## 🛠️ Setup (Rarely Used)

| Command            | Description               |
| ------------------ | ------------------------- |
| `/analyze-product` | Initial codebase analysis |
| `/plan-product`    | Create product docs       |

---

## Planning Docs Reference

All workflows reference these core docs:

| Doc                              | Purpose                  |
| -------------------------------- | ------------------------ |
| `planning/AST.md`                | UI AST specification     |
| `planning/SPEC.md`               | Core Forge rules         |
| `planning/ROADMAP.md`            | 5-stage development plan |
| `planning/technical_specs.md`    | CLI and output specs     |
| `planning/testing_strategy.md`   | Testing approach         |
| `planning/naming_conventions.md` | Naming standards         |

---

## Workflow Details

See `INSTRUCTIONS.md` for detailed command documentation.

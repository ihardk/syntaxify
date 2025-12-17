---
description: Complete list of available Agent-OS and Forge workflows
---

# All Available Workflows

## Agent-OS Core Workflows

| Command | Description | Instruction File |
|---------|-------------|------------------|
| `/analyze-product` | Analyze codebase & install Agent-OS | `analyze-product.md` |
| `/plan-product` | Create product docs (mission, roadmap) | `plan-product.md` |
| `/create-spec` | Create feature specification | `create-spec.md` |
| `/create-tasks` | Create tasks from spec | `create-tasks.md` |
| `/execute-task` | Execute single task | `execute-task.md` |
| `/execute-phase` | Execute all tasks in current phase | (Forge workflow) |
| `/post-execution` | Cleanup and documentation | `post-execution-tasks.md` |

## Forge-Specific Workflows

| Command | Description |
|---------|-------------|
| `/use-agent` | Activate a specific agent role |
| `/build` | Build/generate components |
| `/test` | Run tests and validate |
| `/start-phase` | Start a roadmap phase |
| `/review-docs` | Review architecture docs |

## Meta Instructions (Auto-Applied)

| File | When Used |
|------|-----------|
| `pre-flight.md` | Before any workflow |
| `post-flight.md` | After any workflow |

## How to Use

1. **Type the command** (e.g., `/create-spec`)
2. **Follow the step-by-step process**
3. **Review outputs** when prompted

## Total Workflows: 12

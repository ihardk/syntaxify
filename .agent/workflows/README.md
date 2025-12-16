---
description: Complete list of available Agent-OS and Forge workflows
---

# All Available Workflows

## Agent-OS Core Workflows (from instructions/core/)

| Command | Description | Instruction File |
|---------|-------------|------------------|
| `/create-spec` | Create feature specification | `create-spec.md` |
| `/create-tasks` | Create tasks from spec | `create-tasks.md` |
| `/execute-task` | Execute single task | `execute-task.md` |

## Forge-Specific Workflows

| Command | Description |
|---------|-------------|
| `/use-agent` | Activate a specific agent role |
| `/build` | Build/generate components |
| `/test` | Run tests and validate |
| `/start-phase` | Start a roadmap phase |
| `/review-docs` | Review architecture docs |

## How to Use

1. **For Antigravity/Claude Code:** Type the command (e.g., `/create-spec`)
2. The workflow will reference the Agent-OS instruction file
3. Follow the step-by-step process in the instruction

## Meta Instructions (Auto-Applied)

- `pre-flight.md` - Read before any workflow
- `post-flight.md` - Verify after any workflow

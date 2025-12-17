# Forge Workflow Commands

> Quick reference for all available slash commands and workflows.

---

## Agent-OS Core Workflows

### `/analyze-product`
**Purpose:** Analyze an existing codebase and install Agent-OS structure.
- Scans project for tech stack, architecture
- Creates initial product docs
- Sets up `.agent-os/` folder structure

### `/plan-product`
**Purpose:** Create foundational product documentation.
- Creates `mission.md` (vision, users, problems)
- Creates `roadmap.md` (phases, milestones)
- Creates `tech-stack.md`

### `/create-spec`
**Purpose:** Create a detailed feature specification.
- Prompts for feature details
- Creates spec in `.agent-os/specs/`
- Includes requirements, acceptance criteria

### `/create-tasks`
**Purpose:** Break down a spec into executable tasks.
- Reads an existing spec
- Creates `tasks.md` with checkboxes
- Orders by dependencies

### `/execute-task`
**Purpose:** Execute a single task from a spec.
- Reads `spec-lite.md` for context
- Reads `tasks.md` for task list
- Executes next unchecked task
- Updates checkbox when complete

### `/post-execution`
**Purpose:** Cleanup and documentation after task completion.
- Updates documentation
- Runs tests
- Creates summary of changes

---

## Forge-Specific Workflows

### `/build`
**Purpose:** Build/generate Forge components.
```bash
cd generator
dart run bin/forge.dart build
```
- Reads technical specs
- Runs generator
- Verifies output
- Runs tests

### `/test`
**Purpose:** Run tests for generator and generated code.
```bash
cd generator && dart test
cd generator/example && flutter test
```

### `/use-agent`
**Purpose:** Activate a specific agent role.
- Architect → AST design, compiler
- Engineer → Implementation, CLI
- Designer → Semantic tokens, variants
- QA → Golden tests, validation
- DevEx → Docs, error messages
- Product → Roadmap, priorities

### `/start-phase`
**Purpose:** Start implementing a roadmap phase.
- Reads current roadmap
- Identifies next phase
- Creates tasks for that phase

### `/execute-phase`
**Purpose:** Execute all tasks in current phase.
- Batch execution of phase tasks
- Continues until all tasks complete

### `/review-docs`
**Purpose:** Review architecture and planning docs.
- Reads all planning/*.md files
- Checks for consistency
- Identifies gaps

---

## Meta Instructions (Auto-Applied)

| File             | When                |
| ---------------- | ------------------- |
| `pre-flight.md`  | Before any workflow |
| `post-flight.md` | After any workflow  |

---

## Quick Reference

| Command               | When to Use            |
| --------------------- | ---------------------- |
| `/use-agent Engineer` | Before implementing    |
| `/build`              | After code changes     |
| `/test`               | Before committing      |
| `/execute-task`       | Working through a spec |
| `/review-docs`        | Before major changes   |

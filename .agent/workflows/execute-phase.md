---
description: Execute entire Phase 1 (Generator) in one go
---

# Execute Phase Workflow

// turbo-all

This workflow executes all tasks for the current phase automatically.

## Pre-flight

1. Read the current spec:
```
view .agent-os/specs/2025-12-16-forge-generator-cli/spec-lite.md
```

2. Read the tasks checklist:
```
view .agent-os/specs/2025-12-16-forge-generator-cli/tasks.md
```

3. Read coding standards:
```
view .agent-os/standards/coding.md
```

## Execution

4. Execute each unchecked task in order:
   - Create project structure
   - Implement CLI
   - Implement parser
   - Implement generator
   - Write tests
   - Mark each task complete after finishing

5. After each major component:
   - Run tests to verify
   - Commit if tests pass

## Post-flight

6. Update tasks.md with completed items
7. Report summary to user

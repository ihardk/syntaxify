---
description: Run tests and validate code quality
---

# Test Workflow

// turbo-all

1. Read testing strategy:
```
view planning/testing_strategy.md
```

2. Run unit tests:
```bash
cd d:\Workspace\forge\example
flutter test
```

3. Run generator tests (once implemented):
```bash
cd d:\Workspace\forge\generator
dart test
```

4. Check for lint issues:
```bash
cd d:\Workspace\forge\example
flutter analyze
```

5. Report results

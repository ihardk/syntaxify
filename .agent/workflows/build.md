---
description: Build/generate Syntax components
---

# Build Workflow

// turbo-all

1. Read the technical specs:
```
view planning/technical_specs.md
```

2. Run the syntax generator (once implemented):
```bash
cd d:\Workspace\syntax\generator
dart run bin/syntax.dart build
```

3. Verify generated output exists in `lib/generated/`

4. Run tests:
```bash
cd d:\Workspace\syntax\example
flutter test
```

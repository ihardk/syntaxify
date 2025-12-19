---
description: Build/generate Syntaxify components
---

# Build Workflow

// turbo-all

1. Read the technical specs:
```
view planning/technical_specs.md
```

2. Run the syntaxify generator (once implemented):
```bash
cd d:\Workspace\syntaxify\generator
dart run bin/syntaxify.dart build
```

3. Verify generated output exists in `lib/generated/`

4. Run tests:
```bash
cd d:\Workspace\syntaxify\example
flutter test
```

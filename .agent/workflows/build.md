---
description: Build/generate Forge components
---

# Build Workflow

// turbo-all

1. Read the technical specs:
```
view planning/technical_specs.md
```

2. Run the forge generator (once implemented):
```bash
cd d:\Workspace\forge\generator
dart run bin/forge.dart build
```

3. Verify generated output exists in `lib/generated/`

4. Run tests:
```bash
cd d:\Workspace\forge\example
flutter test
```

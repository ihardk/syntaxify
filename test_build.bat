@echo off
echo 🔨 Building for Repo Verification (lib/syntax)...
dart run generator/bin/syntax.dart build --meta=generator/meta --design-system=generator/design_system --tokens=generator/design_system --output=lib/syntax %*
echo Done.

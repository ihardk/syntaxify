@echo off
echo 🔨 Building for Repo Verification (lib/forge)...
dart run generator/bin/forge.dart build --meta=generator/meta --design-system=generator/design_system --tokens=generator/design_system --output=lib/forge %*
echo Done.

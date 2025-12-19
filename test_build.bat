@echo off
echo 🔨 Building for Repo Verification (lib/syntaxify)...
dart run generator/bin/syntaxify.dart build --meta=generator/meta --design-system=generator/design_system --tokens=generator/design_system --output=lib/syntaxify %*
echo Done.

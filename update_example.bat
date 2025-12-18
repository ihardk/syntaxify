@echo off
echo 📱 Updating Example App (generator/example/lib/syntax)...
dart run generator/bin/syntax.dart build --meta=generator/meta --design-system=generator/design_system --tokens=generator/design_system --output=generator/example/lib/syntax %*
echo Done.

@echo off
echo 📱 Updating Example App (generator/example/lib/syntaxify)...
dart run generator/bin/syntaxify.dart build --meta=generator/meta --design-system=generator/design_system --tokens=generator/design_system --output=generator/example/lib/syntaxify %*
echo Done.

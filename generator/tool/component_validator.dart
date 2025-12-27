import 'dart:io';
import 'package:path/path.dart' as path;

/// Validates component file structure based on conventions
class ComponentValidator {
  final String projectRoot;

  ComponentValidator(this.projectRoot);

  /// Scan all meta files and validate their structure
  Map<String, List<String>> validateAll() {
    final errors = <String, List<String>>{};
    final metaDir = Directory(path.join(projectRoot, 'meta'));

    if (!metaDir.existsSync()) {
      return {'project': ['meta/ directory not found']};
    }

    final metaFiles = metaDir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.meta.dart'));

    for (final metaFile in metaFiles) {
      final componentName = path.basenameWithoutExtension(
        path.basenameWithoutExtension(metaFile.path)
      );

      final componentErrors = _validateComponent(componentName);
      if (componentErrors.isNotEmpty) {
        errors[componentName] = componentErrors;
      }
    }

    return errors;
  }

  /// Validate a single component's expected files
  List<String> _validateComponent(String name) {
    final errors = <String>[];

    // Required files
    final tokenFile = File(path.join(
      projectRoot, 'design_system/tokens/${name}_tokens.dart'
    ));
    if (!tokenFile.existsSync()) {
      errors.add('Missing tokens file: design_system/tokens/${name}_tokens.dart');
    }

    // Required renderers
    for (final style in ['material', 'cupertino', 'neo']) {
      final renderer = File(path.join(
        projectRoot, 'design_system/components/$name/${style}_renderer.dart'
      ));
      if (!renderer.existsSync()) {
        errors.add('Missing $style renderer: design_system/components/$name/${style}_renderer.dart');
      }
    }

    // Check for integration in design_system.dart
    final designSystem = File(path.join(
      projectRoot, 'design_system/design_system.dart'
    ));
    final content = designSystem.readAsStringSync();

    if (!content.contains("import 'tokens/${name}_tokens.dart'")) {
      errors.add('Not imported in design_system.dart');
    }

    if (!content.contains("part 'components/$name/material_renderer.dart'")) {
      errors.add('Material renderer not added as part in design_system.dart');
    }

    return errors;
  }

  /// Print validation report
  void printReport() {
    final errors = validateAll();

    if (errors.isEmpty) {
      print('✅ All components valid!');
      return;
    }

    print('❌ Found ${errors.length} components with errors:\n');

    for (final entry in errors.entries) {
      print('Component: ${entry.key}');
      for (final error in entry.value) {
        print('  - $error');
      }
      print('');
    }
  }
}

void main() {
  final validator = ComponentValidator('/home/user/syntaxify/generator');
  validator.printReport();
}

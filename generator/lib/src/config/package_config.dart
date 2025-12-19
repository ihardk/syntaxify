/// Package configuration - SINGLE SOURCE OF TRUTH
///
/// Edit this file to change package metadata across the entire project.
/// Documentation templates and generators read from this file.

library package_config;

/// Package identity
const String packageName = 'syntaxify';
const String packageDescription =
    'AST-based Flutter UI code generator with multi-style design system. '
    'Write components once, render in Material, Cupertino, or custom designs.';

/// Version - Update this for each release
const String packageVersion = '0.1.0-alpha.1';

/// Author information
const String authorName = 'Hardik Bamania';
const String authorEmail = 'hardik.vaistra@gmail.com'; // Update with real email
const String authorGithub = 'ihardk';

/// Repository URLs
const String repositoryUrl = 'https://github.com/$authorGithub/$packageName';
const String issueTrackerUrl = '$repositoryUrl/issues';
const String homepageUrl = repositoryUrl;
const String changelogUrl = 'https://pub.dev/packages/$packageName/changelog';

/// Default paths
const String defaultOutputDir = 'lib/$packageName';
const String defaultMetaDir = 'meta';
const String defaultDesignSystemDir = '$defaultOutputDir/design_system';
const String defaultGeneratedDir = '$defaultOutputDir/generated';
const String defaultScreensDir = 'lib/screens';

/// CLI command name (matches pubspec.yaml executables)
const String cliCommand = packageName;

/// Import path for user projects
String packageImport(String projectName) =>
    'package:$projectName/$packageName/index.dart';

/// Design system import for user projects
String designSystemImport(String projectName) =>
    'package:$projectName/$packageName/design_system/design_system.dart';

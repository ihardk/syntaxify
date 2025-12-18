/// Forge Design System - Core
///
/// Base classes and types for the Forge design system.
/// Uses `part` files so sealed class can be extended.
library design_system;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'tokens/button_tokens.dart';
import 'tokens/input_tokens.dart';
import 'app_icons.dart';

// Re-export for convenience
export 'tokens/button_tokens.dart';
export 'tokens/input_tokens.dart';
export 'app_icons.dart';

// Part files - same library as sealed class
part 'app_theme.dart';
part 'design_style.dart';
part 'button_variant.dart';
part 'styles/material_style.dart';
part 'styles/cupertino_style.dart';
part 'styles/neo_style.dart';

// Renderers (Mixins)
part 'styles/material/button_renderer.dart';
part 'styles/cupertino/button_renderer.dart';
part 'styles/neo/button_renderer.dart';

part 'styles/material/input_renderer.dart';
part 'styles/cupertino/input_renderer.dart';
part 'styles/neo/input_renderer.dart';

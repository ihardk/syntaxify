/// Syntaxify Design System - Core
///
/// Base classes and types for the Syntaxify Design System.
/// Uses `part` files so sealed class can be extended.
library design_system;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:syntaxify/syntaxify.dart'; // For @Variant annotation

// Foundation tokens
import 'tokens/foundation/foundation_tokens.dart';

import 'tokens/button_tokens.dart';
import 'tokens/input_tokens.dart';
import 'tokens/text_tokens.dart';
import 'tokens/checkbox_tokens.dart';
import 'tokens/toggle_tokens.dart';
import 'tokens/slider_tokens.dart';
import 'tokens/radio_tokens.dart';
import 'app_icons.dart';

// Import generated variants
import '../generated/variants/button_variant.dart';
import '../generated/variants/text_variant.dart';

// Re-export for convenience
export 'tokens/foundation/foundation_tokens.dart';
export 'tokens/button_tokens.dart';
export 'tokens/input_tokens.dart';
export 'tokens/text_tokens.dart';
export 'tokens/checkbox_tokens.dart';
export 'tokens/toggle_tokens.dart';
export 'tokens/slider_tokens.dart';
export 'tokens/radio_tokens.dart';
export 'app_icons.dart';

// Export generated variants
export '../generated/variants/button_variant.dart';
export '../generated/variants/text_variant.dart';

// Part files - same library as sealed class
part 'app_theme.dart';
part 'design_style.dart';

// Foundation tokens (parts)
part 'tokens/foundation/material_foundation.dart';
part 'tokens/foundation/cupertino_foundation.dart';
part 'tokens/foundation/neo_foundation.dart';

// Styles
part 'styles/material_style.dart';
part 'styles/cupertino_style.dart';
part 'styles/neo_style.dart';

// Renderers (Mixins)
part 'components/button/material_renderer.dart';
part 'components/button/cupertino_renderer.dart';
part 'components/button/neo_renderer.dart';

part 'components/input/material_renderer.dart';
part 'components/input/cupertino_renderer.dart';
part 'components/input/neo_renderer.dart';

part 'components/text/material_renderer.dart';
part 'components/text/cupertino_renderer.dart';
part 'components/text/neo_renderer.dart';

// Interactive renderers
part 'components/checkbox/material_renderer.dart';
part 'components/checkbox/cupertino_renderer.dart';
part 'components/checkbox/neo_renderer.dart';

part 'components/toggle/material_renderer.dart';
part 'components/toggle/cupertino_renderer.dart';
part 'components/toggle/neo_renderer.dart';

part 'components/slider/material_renderer.dart';
part 'components/slider/cupertino_renderer.dart';
part 'components/slider/neo_renderer.dart';

part 'components/radio/material_renderer.dart';
part 'components/radio/cupertino_renderer.dart';
part 'components/radio/neo_renderer.dart';

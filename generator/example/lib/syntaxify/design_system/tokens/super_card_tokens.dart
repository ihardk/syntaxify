// SuperCardTokens definition
//
// Pure data class defining styling properties for the SuperCard component.
// Used by DesignStyle implementations to provide style-specific tokens.

import 'package:flutter/material.dart';
import 'foundation/foundation_tokens.dart';

/// Design tokens for the SuperCard component
class SuperCardTokens {
  const SuperCardTokens();

  /// Create SuperCardTokens from foundation design tokens
  factory SuperCardTokens.fromFoundation(FoundationTokens foundation) {
    return SuperCardTokens();
  }
}

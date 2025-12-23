import 'package:freezed_annotation/freezed_annotation.dart';
import '../layout_node.dart';

part 'custom_node.freezed.dart';
part 'custom_node.g.dart';

/// A generic node for custom components provided by plugins.
@freezed
sealed class CustomNode with _$CustomNode {
  const factory CustomNode({
    /// The specific type of the component (e.g., 'Carousel', 'GoogleMap')
    required String type,

    /// Key-value pairs of properties for the component
    @Default({}) Map<String, dynamic> props,

    /// Child nodes, if the component supports children
    @Default([]) List<App> children,
  }) = _CustomNode;

  factory CustomNode.fromJson(Map<String, dynamic> json) =>
      _$CustomNodeFromJson(json);
}

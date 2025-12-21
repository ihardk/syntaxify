import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums.dart';

part 'primitive_node.freezed.dart';
part 'primitive_node.g.dart';

/// Basic leaf nodes for display.
@freezed
sealed class PrimitiveNode with _$PrimitiveNode {
  const factory PrimitiveNode.text({
    required String text,
    TextVariant? variant,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) = TextNode;

  const factory PrimitiveNode.icon({
    required String name,
    IconSize? size,
    ColorSemantic? semantic,
  }) = IconNode;

  const factory PrimitiveNode.spacer({
    SpacerSize? size,
    int? flex,
  }) = SpacerNode;

  const factory PrimitiveNode.image({
    required String src,
    double? width,
    double? height,
    ImageFit? fit,
    String? placeholder,
    String? errorWidget,
  }) = ImageNode;

  const factory PrimitiveNode.divider({
    double? thickness,
    ColorSemantic? color,
    double? indent,
    double? endIndent,
  }) = DividerNode;

  const factory PrimitiveNode.circularProgressIndicator({
    double? value,
    ColorSemantic? color,
    double? strokeWidth,
  }) = CircularProgressIndicatorNode;

  factory PrimitiveNode.fromJson(Map<String, dynamic> json) =>
      _$PrimitiveNodeFromJson(json);
}

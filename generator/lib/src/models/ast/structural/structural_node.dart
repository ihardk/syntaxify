import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums.dart';
import '../layout_node.dart';

part 'structural_node.freezed.dart';
part 'structural_node.g.dart';

/// Nodes that define layout structure.
@freezed
sealed class StructuralNode with _$StructuralNode {
  const factory StructuralNode.column({
    required List<LayoutNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    String? spacing,
  }) = ColumnNode;

  const factory StructuralNode.row({
    required List<LayoutNode> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    String? spacing,
  }) = RowNode;

  const factory StructuralNode.container({
    LayoutNode? child,
    double? width,
    double? height,
    String? padding,
    String? margin,
    ColorSemantic? color,
    double? borderRadius,
    ContainerSemantic? semantic,
  }) = ContainerNode;

  const factory StructuralNode.card({
    required List<LayoutNode> children,
    CardVariant? variant,
    String? padding,
    double? elevation,
  }) = CardNode;

  const factory StructuralNode.listView({
    required List<LayoutNode> children,
    Axis? scrollDirection,
    String? spacing,
    bool? shrinkWrap,
  }) = ListViewNode;

  factory StructuralNode.fromJson(Map<String, dynamic> json) =>
      _$StructuralNodeFromJson(json);
}

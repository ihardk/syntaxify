import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums.dart';
import '../layout_node.dart';

part 'structural_node.freezed.dart';
part 'structural_node.g.dart';

/// Nodes that define layout structure.
@freezed
sealed class StructuralNode with _$StructuralNode {
  const factory StructuralNode.column({
    required List<App> children,
    MainAlignment? mainAxisAlignment,
    CrossAlignment? crossAxisAlignment,
    String? spacing,
  }) = ColumnNode;

  const factory StructuralNode.row({
    required List<App> children,
    MainAlignment? mainAxisAlignment,
    CrossAlignment? crossAxisAlignment,
    String? spacing,
  }) = RowNode;

  const factory StructuralNode.container({
    App? child,
    double? width,
    double? height,
    String? padding,
    String? margin,
    ColorSemantic? color,
    double? borderRadius,
    ContainerSemantic? semantic,
  }) = ContainerNode;

  const factory StructuralNode.card({
    required List<App> children,
    String? variant,
    String? padding,
    double? elevation,
  }) = CardNode;

  const factory StructuralNode.listView({
    required List<App> children,
    SyntaxAxis? scrollDirection,
    String? spacing,
    bool? shrinkWrap,
  }) = ListViewNode;

  const factory StructuralNode.stack({
    required List<App> children,
    StackFit? fit,
    AlignmentEnum? alignment,
  }) = StackNode;

  const factory StructuralNode.gridView({
    required List<App> children,
    required int crossAxisCount,
    String? spacing,
    String? crossAxisSpacing,
    double? childAspectRatio,
    bool? shrinkWrap,
  }) = GridViewNode;

  const factory StructuralNode.padding({
    required App child,
    required String padding,
  }) = PaddingNode;

  const factory StructuralNode.center({
    required App child,
  }) = CenterNode;

  factory StructuralNode.fromJson(Map<String, dynamic> json) =>
      _$StructuralNodeFromJson(json);
}

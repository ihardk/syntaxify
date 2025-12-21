import 'package:freezed_annotation/freezed_annotation.dart';

part 'node_metadata.freezed.dart';
part 'node_metadata.g.dart';

/// Common metadata for all layout nodes.
@freezed
sealed class NodeMetadata with _$NodeMetadata {
  const factory NodeMetadata({
    /// Unique identifier for the node.
    String? id,

    /// Condition for visibility (e.g., 'params.showButton').
    String? visibleWhen,
  }) = _NodeMetadata;

  factory NodeMetadata.fromJson(Map<String, dynamic> json) =>
      _$NodeMetadataFromJson(json);
}

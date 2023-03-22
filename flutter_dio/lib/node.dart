import 'package:freezed_annotation/freezed_annotation.dart';

part 'node.freezed.dart';
part 'node.g.dart';

@freezed
class Node with _$Node{

  const factory Node(
  {
    required int id,
    required String nodeTitle,
    required String nodeDescription,
    required String createDate,
    required String updateDate,
    required bool isDeleted,
    required int idCategory,
  }
  ) = _Node;

  factory Node.fromJson(Map<String,dynamic> json) => _$NodeFromJson(json);
}
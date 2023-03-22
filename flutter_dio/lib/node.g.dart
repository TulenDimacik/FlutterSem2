// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Node _$$_NodeFromJson(Map<String, dynamic> json) => _$_Node(
      id: json['id'] as int,
      nodeTitle: json['nodeTitle'] as String,
      nodeDescription: json['nodeDescription'] as String,
      createDate: json['createDate'] as String,
      updateDate: json['updateDate'] as String,
      isDeleted: json['isDeleted'] as bool,
      idCategory: json['idCategory'] as int,
    );

Map<String, dynamic> _$$_NodeToJson(_$_Node instance) => <String, dynamic>{
      'id': instance.id,
      'nodeTitle': instance.nodeTitle,
      'nodeDescription': instance.nodeDescription,
      'createDate': instance.createDate,
      'updateDate': instance.updateDate,
      'isDeleted': instance.isDeleted,
      'idCategory': instance.idCategory,
    };

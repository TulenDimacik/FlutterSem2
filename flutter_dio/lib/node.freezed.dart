// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Node _$NodeFromJson(Map<String, dynamic> json) {
  return _Node.fromJson(json);
}

/// @nodoc
mixin _$Node {
  int get id => throw _privateConstructorUsedError;
  String get nodeTitle => throw _privateConstructorUsedError;
  String get nodeDescription => throw _privateConstructorUsedError;
  String get createDate => throw _privateConstructorUsedError;
  String get updateDate => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  int get idCategory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodeCopyWith<Node> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeCopyWith<$Res> {
  factory $NodeCopyWith(Node value, $Res Function(Node) then) =
      _$NodeCopyWithImpl<$Res, Node>;
  @useResult
  $Res call(
      {int id,
      String nodeTitle,
      String nodeDescription,
      String createDate,
      String updateDate,
      bool isDeleted,
      int idCategory});
}

/// @nodoc
class _$NodeCopyWithImpl<$Res, $Val extends Node>
    implements $NodeCopyWith<$Res> {
  _$NodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nodeTitle = null,
    Object? nodeDescription = null,
    Object? createDate = null,
    Object? updateDate = null,
    Object? isDeleted = null,
    Object? idCategory = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nodeTitle: null == nodeTitle
          ? _value.nodeTitle
          : nodeTitle // ignore: cast_nullable_to_non_nullable
              as String,
      nodeDescription: null == nodeDescription
          ? _value.nodeDescription
          : nodeDescription // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as String,
      updateDate: null == updateDate
          ? _value.updateDate
          : updateDate // ignore: cast_nullable_to_non_nullable
              as String,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      idCategory: null == idCategory
          ? _value.idCategory
          : idCategory // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NodeCopyWith<$Res> implements $NodeCopyWith<$Res> {
  factory _$$_NodeCopyWith(_$_Node value, $Res Function(_$_Node) then) =
      __$$_NodeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String nodeTitle,
      String nodeDescription,
      String createDate,
      String updateDate,
      bool isDeleted,
      int idCategory});
}

/// @nodoc
class __$$_NodeCopyWithImpl<$Res> extends _$NodeCopyWithImpl<$Res, _$_Node>
    implements _$$_NodeCopyWith<$Res> {
  __$$_NodeCopyWithImpl(_$_Node _value, $Res Function(_$_Node) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nodeTitle = null,
    Object? nodeDescription = null,
    Object? createDate = null,
    Object? updateDate = null,
    Object? isDeleted = null,
    Object? idCategory = null,
  }) {
    return _then(_$_Node(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nodeTitle: null == nodeTitle
          ? _value.nodeTitle
          : nodeTitle // ignore: cast_nullable_to_non_nullable
              as String,
      nodeDescription: null == nodeDescription
          ? _value.nodeDescription
          : nodeDescription // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as String,
      updateDate: null == updateDate
          ? _value.updateDate
          : updateDate // ignore: cast_nullable_to_non_nullable
              as String,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      idCategory: null == idCategory
          ? _value.idCategory
          : idCategory // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Node implements _Node {
  const _$_Node(
      {required this.id,
      required this.nodeTitle,
      required this.nodeDescription,
      required this.createDate,
      required this.updateDate,
      required this.isDeleted,
      required this.idCategory});

  factory _$_Node.fromJson(Map<String, dynamic> json) => _$$_NodeFromJson(json);

  @override
  final int id;
  @override
  final String nodeTitle;
  @override
  final String nodeDescription;
  @override
  final String createDate;
  @override
  final String updateDate;
  @override
  final bool isDeleted;
  @override
  final int idCategory;

  @override
  String toString() {
    return 'Node(id: $id, nodeTitle: $nodeTitle, nodeDescription: $nodeDescription, createDate: $createDate, updateDate: $updateDate, isDeleted: $isDeleted, idCategory: $idCategory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Node &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nodeTitle, nodeTitle) ||
                other.nodeTitle == nodeTitle) &&
            (identical(other.nodeDescription, nodeDescription) ||
                other.nodeDescription == nodeDescription) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.updateDate, updateDate) ||
                other.updateDate == updateDate) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.idCategory, idCategory) ||
                other.idCategory == idCategory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, nodeTitle, nodeDescription,
      createDate, updateDate, isDeleted, idCategory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NodeCopyWith<_$_Node> get copyWith =>
      __$$_NodeCopyWithImpl<_$_Node>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NodeToJson(
      this,
    );
  }
}

abstract class _Node implements Node {
  const factory _Node(
      {required final int id,
      required final String nodeTitle,
      required final String nodeDescription,
      required final String createDate,
      required final String updateDate,
      required final bool isDeleted,
      required final int idCategory}) = _$_Node;

  factory _Node.fromJson(Map<String, dynamic> json) = _$_Node.fromJson;

  @override
  int get id;
  @override
  String get nodeTitle;
  @override
  String get nodeDescription;
  @override
  String get createDate;
  @override
  String get updateDate;
  @override
  bool get isDeleted;
  @override
  int get idCategory;
  @override
  @JsonKey(ignore: true)
  _$$_NodeCopyWith<_$_Node> get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChapterDto _$ChapterDtoFromJson(Map<String, dynamic> json) {
  return _ChapterDto.fromJson(json);
}

/// @nodoc
mixin _$ChapterDto {
  String get id => throw _privateConstructorUsedError;
  String get projectId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ChapterDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChapterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChapterDtoCopyWith<ChapterDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterDtoCopyWith<$Res> {
  factory $ChapterDtoCopyWith(
          ChapterDto value, $Res Function(ChapterDto) then) =
      _$ChapterDtoCopyWithImpl<$Res, ChapterDto>;
  @useResult
  $Res call(
      {String id,
      String projectId,
      String title,
      String content,
      int orderIndex,
      String updatedAt});
}

/// @nodoc
class _$ChapterDtoCopyWithImpl<$Res, $Val extends ChapterDto>
    implements $ChapterDtoCopyWith<$Res> {
  _$ChapterDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChapterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? title = null,
    Object? content = null,
    Object? orderIndex = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      orderIndex: null == orderIndex
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChapterDtoImplCopyWith<$Res>
    implements $ChapterDtoCopyWith<$Res> {
  factory _$$ChapterDtoImplCopyWith(
          _$ChapterDtoImpl value, $Res Function(_$ChapterDtoImpl) then) =
      __$$ChapterDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String projectId,
      String title,
      String content,
      int orderIndex,
      String updatedAt});
}

/// @nodoc
class __$$ChapterDtoImplCopyWithImpl<$Res>
    extends _$ChapterDtoCopyWithImpl<$Res, _$ChapterDtoImpl>
    implements _$$ChapterDtoImplCopyWith<$Res> {
  __$$ChapterDtoImplCopyWithImpl(
      _$ChapterDtoImpl _value, $Res Function(_$ChapterDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChapterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? title = null,
    Object? content = null,
    Object? orderIndex = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ChapterDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      orderIndex: null == orderIndex
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$ChapterDtoImpl extends _ChapterDto {
  const _$ChapterDtoImpl(
      {required this.id,
      required this.projectId,
      required this.title,
      required this.content,
      this.orderIndex = 0,
      this.updatedAt = ''})
      : super._();

  factory _$ChapterDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String projectId;
  @override
  final String title;
  @override
  final String content;
  @override
  @JsonKey()
  final int orderIndex;
  @override
  @JsonKey()
  final String updatedAt;

  @override
  String toString() {
    return 'ChapterDto(id: $id, projectId: $projectId, title: $title, content: $content, orderIndex: $orderIndex, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, projectId, title, content, orderIndex, updatedAt);

  /// Create a copy of ChapterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterDtoImplCopyWith<_$ChapterDtoImpl> get copyWith =>
      __$$ChapterDtoImplCopyWithImpl<_$ChapterDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterDtoImplToJson(
      this,
    );
  }
}

abstract class _ChapterDto extends ChapterDto {
  const factory _ChapterDto(
      {required final String id,
      required final String projectId,
      required final String title,
      required final String content,
      final int orderIndex,
      final String updatedAt}) = _$ChapterDtoImpl;
  const _ChapterDto._() : super._();

  factory _ChapterDto.fromJson(Map<String, dynamic> json) =
      _$ChapterDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get projectId;
  @override
  String get title;
  @override
  String get content;
  @override
  int get orderIndex;
  @override
  String get updatedAt;

  /// Create a copy of ChapterDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChapterDtoImplCopyWith<_$ChapterDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

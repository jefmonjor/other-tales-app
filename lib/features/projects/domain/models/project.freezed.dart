// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get synopsis => throw _privateConstructorUsedError;
  String? get coverUrl => throw _privateConstructorUsedError;
  String? get genre => throw _privateConstructorUsedError;
  int get currentWordCount => throw _privateConstructorUsedError;
  int get targetWordCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  DateTime get lastModified => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  ProjectStatus get status => throw _privateConstructorUsedError;

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? synopsis,
      String? coverUrl,
      String? genre,
      int currentWordCount,
      int targetWordCount,
      @JsonKey(name: 'updatedAt') DateTime lastModified,
      DateTime? createdAt,
      ProjectStatus status});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? synopsis = freezed,
    Object? coverUrl = freezed,
    Object? genre = freezed,
    Object? currentWordCount = null,
    Object? targetWordCount = null,
    Object? lastModified = null,
    Object? createdAt = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      synopsis: freezed == synopsis
          ? _value.synopsis
          : synopsis // ignore: cast_nullable_to_non_nullable
              as String?,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String?,
      currentWordCount: null == currentWordCount
          ? _value.currentWordCount
          : currentWordCount // ignore: cast_nullable_to_non_nullable
              as int,
      targetWordCount: null == targetWordCount
          ? _value.targetWordCount
          : targetWordCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastModified: null == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectImplCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$ProjectImplCopyWith(
          _$ProjectImpl value, $Res Function(_$ProjectImpl) then) =
      __$$ProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? synopsis,
      String? coverUrl,
      String? genre,
      int currentWordCount,
      int targetWordCount,
      @JsonKey(name: 'updatedAt') DateTime lastModified,
      DateTime? createdAt,
      ProjectStatus status});
}

/// @nodoc
class __$$ProjectImplCopyWithImpl<$Res>
    extends _$ProjectCopyWithImpl<$Res, _$ProjectImpl>
    implements _$$ProjectImplCopyWith<$Res> {
  __$$ProjectImplCopyWithImpl(
      _$ProjectImpl _value, $Res Function(_$ProjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? synopsis = freezed,
    Object? coverUrl = freezed,
    Object? genre = freezed,
    Object? currentWordCount = null,
    Object? targetWordCount = null,
    Object? lastModified = null,
    Object? createdAt = freezed,
    Object? status = null,
  }) {
    return _then(_$ProjectImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      synopsis: freezed == synopsis
          ? _value.synopsis
          : synopsis // ignore: cast_nullable_to_non_nullable
              as String?,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String?,
      currentWordCount: null == currentWordCount
          ? _value.currentWordCount
          : currentWordCount // ignore: cast_nullable_to_non_nullable
              as int,
      targetWordCount: null == targetWordCount
          ? _value.targetWordCount
          : targetWordCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastModified: null == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectImpl extends _Project {
  const _$ProjectImpl(
      {required this.id,
      required this.title,
      this.synopsis,
      this.coverUrl,
      this.genre,
      this.currentWordCount = 0,
      this.targetWordCount = 50000,
      @JsonKey(name: 'updatedAt') required this.lastModified,
      this.createdAt,
      this.status = ProjectStatus.draft})
      : super._();

  factory _$ProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? synopsis;
  @override
  final String? coverUrl;
  @override
  final String? genre;
  @override
  @JsonKey()
  final int currentWordCount;
  @override
  @JsonKey()
  final int targetWordCount;
  @override
  @JsonKey(name: 'updatedAt')
  final DateTime lastModified;
  @override
  final DateTime? createdAt;
  @override
  @JsonKey()
  final ProjectStatus status;

  @override
  String toString() {
    return 'Project(id: $id, title: $title, synopsis: $synopsis, coverUrl: $coverUrl, genre: $genre, currentWordCount: $currentWordCount, targetWordCount: $targetWordCount, lastModified: $lastModified, createdAt: $createdAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.synopsis, synopsis) ||
                other.synopsis == synopsis) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.currentWordCount, currentWordCount) ||
                other.currentWordCount == currentWordCount) &&
            (identical(other.targetWordCount, targetWordCount) ||
                other.targetWordCount == targetWordCount) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      synopsis,
      coverUrl,
      genre,
      currentWordCount,
      targetWordCount,
      lastModified,
      createdAt,
      status);

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      __$$ProjectImplCopyWithImpl<_$ProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectImplToJson(
      this,
    );
  }
}

abstract class _Project extends Project {
  const factory _Project(
      {required final String id,
      required final String title,
      final String? synopsis,
      final String? coverUrl,
      final String? genre,
      final int currentWordCount,
      final int targetWordCount,
      @JsonKey(name: 'updatedAt') required final DateTime lastModified,
      final DateTime? createdAt,
      final ProjectStatus status}) = _$ProjectImpl;
  const _Project._() : super._();

  factory _Project.fromJson(Map<String, dynamic> json) = _$ProjectImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get synopsis;
  @override
  String? get coverUrl;
  @override
  String? get genre;
  @override
  int get currentWordCount;
  @override
  int get targetWordCount;
  @override
  @JsonKey(name: 'updatedAt')
  DateTime get lastModified;
  @override
  DateTime? get createdAt;
  @override
  ProjectStatus get status;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      synopsis: json['synopsis'] as String?,
      coverUrl: json['coverUrl'] as String?,
      genre: json['genre'] as String?,
      currentWordCount: (json['currentWordCount'] as num?)?.toInt() ?? 0,
      targetWordCount: (json['targetWordCount'] as num?)?.toInt() ?? 50000,
      lastModified: DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      status: $enumDecodeNullable(_$ProjectStatusEnumMap, json['status']) ??
          ProjectStatus.draft,
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'synopsis': instance.synopsis,
      'coverUrl': instance.coverUrl,
      'genre': instance.genre,
      'currentWordCount': instance.currentWordCount,
      'targetWordCount': instance.targetWordCount,
      'updatedAt': instance.lastModified.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'status': _$ProjectStatusEnumMap[instance.status]!,
    };

const _$ProjectStatusEnumMap = {
  ProjectStatus.draft: 'DRAFT',
  ProjectStatus.published: 'PUBLISHED',
};

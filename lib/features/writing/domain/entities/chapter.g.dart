// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChapterImpl _$$ChapterImplFromJson(Map<String, dynamic> json) =>
    _$ChapterImpl(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      sortOrder: (json['sortOrder'] as num).toInt(),
      wordCount: (json['wordCount'] as num?)?.toInt() ?? 0,
      lastModified: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ChapterImplToJson(_$ChapterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'title': instance.title,
      'content': instance.content,
      'sortOrder': instance.sortOrder,
      'wordCount': instance.wordCount,
      'updatedAt': instance.lastModified.toIso8601String(),
    };

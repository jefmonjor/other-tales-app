// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChapterDtoImpl _$$ChapterDtoImplFromJson(Map<String, dynamic> json) =>
    _$ChapterDtoImpl(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      orderIndex: (json['order_index'] as num?)?.toInt() ?? 0,
      updatedAt: json['updated_at'] as String? ?? '',
    );

Map<String, dynamic> _$$ChapterDtoImplToJson(_$ChapterDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'title': instance.title,
      'content': instance.content,
      'order_index': instance.orderIndex,
      'updated_at': instance.updatedAt,
    };

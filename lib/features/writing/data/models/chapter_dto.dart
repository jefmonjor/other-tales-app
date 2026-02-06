import '../../domain/entities/chapter.dart';

/// DTO for Chapter data from the Backend API.
/// Backend sends camelCase JSON (Spring Boot default).
class ChapterDto {
  final String id;
  final String projectId;
  final String title;
  final String content;
  final int sortOrder;
  final int wordCount;
  final String createdAt;
  final String updatedAt;

  const ChapterDto({
    required this.id,
    required this.projectId,
    required this.title,
    required this.content,
    this.sortOrder = 0,
    this.wordCount = 0,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory ChapterDto.fromJson(Map<String, dynamic> json) {
    return ChapterDto(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      content: json['content'] as String? ?? '',
      sortOrder: json['sortOrder'] as int? ?? 0,
      wordCount: json['wordCount'] as int? ?? 0,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'title': title,
      'content': content,
      'sortOrder': sortOrder,
      'wordCount': wordCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Chapter toDomain() {
    return Chapter(
      id: id,
      projectId: projectId,
      title: title,
      content: content,
      sortOrder: sortOrder,
      wordCount: wordCount,
      lastModified: DateTime.tryParse(updatedAt) ?? DateTime.now(),
    );
  }
}

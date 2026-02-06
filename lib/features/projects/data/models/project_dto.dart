import '../../domain/models/project.dart';

/// DTO for Project data from the Backend API.
/// Backend sends camelCase JSON (Spring Boot default).
/// Response fields: id, title, synopsis?, genre?, currentWordCount,
/// targetWordCount, coverUrl?, status, createdAt, updatedAt.
class ProjectDto {
  final String id;
  final String title;
  final String? synopsis;
  final String? coverUrl;
  final String? genre;
  final int currentWordCount;
  final int targetWordCount;
  final String? createdAt;
  final String updatedAt;
  final String status;

  const ProjectDto({
    required this.id,
    required this.title,
    this.synopsis,
    this.coverUrl,
    this.genre,
    this.currentWordCount = 0,
    this.targetWordCount = 50000,
    this.createdAt,
    required this.updatedAt,
    this.status = 'DRAFT',
  });

  factory ProjectDto.fromJson(Map<String, dynamic> json) {
    return ProjectDto(
      id: json['id'] as String,
      title: json['title'] as String,
      synopsis: json['synopsis'] as String?,
      coverUrl: json['coverUrl'] as String?,
      genre: json['genre'] as String?,
      currentWordCount: json['currentWordCount'] as int? ?? 0,
      targetWordCount: json['targetWordCount'] as int? ?? 50000,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String? ?? DateTime.now().toIso8601String(),
      status: json['status'] as String? ?? 'DRAFT',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      if (synopsis != null) 'synopsis': synopsis,
      if (coverUrl != null) 'coverUrl': coverUrl,
      if (genre != null) 'genre': genre,
      'targetWordCount': targetWordCount,
    };
  }

  /// Convert DTO to domain model
  Project toDomain() {
    return Project(
      id: id,
      title: title,
      synopsis: synopsis,
      coverUrl: coverUrl,
      genre: genre,
      currentWordCount: currentWordCount,
      targetWordCount: targetWordCount,
      lastModified: DateTime.tryParse(updatedAt) ?? DateTime.now(),
      status: _parseStatus(status),
    );
  }

  static ProjectStatus _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'PUBLISHED':
        return ProjectStatus.published;
      case 'ARCHIVED':
        return ProjectStatus.archived;
      default:
        return ProjectStatus.draft;
    }
  }
}

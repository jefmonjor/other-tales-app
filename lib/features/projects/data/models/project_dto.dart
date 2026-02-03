import '../../domain/models/project.dart';

/// DTO for Project data from the Backend API.
/// Maps JSON to domain Project model.
class ProjectDto {
  final String id;
  final String title;
  final String? synopsis;
  final String? coverUrl;
  final String? genre;
  final int currentWordCount;
  final int targetWordCount;
  final DateTime lastModified;
  final String status;

  const ProjectDto({
    required this.id,
    required this.title,
    this.synopsis,
    this.coverUrl,
    this.genre,
    this.currentWordCount = 0,
    this.targetWordCount = 50000,
    required this.lastModified,
    this.status = 'draft',
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
      lastModified: DateTime.parse(json['lastModified'] as String),
      status: json['status'] as String? ?? 'draft',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'synopsis': synopsis,
      'coverUrl': coverUrl,
      'genre': genre,
      'currentWordCount': currentWordCount,
      'targetWordCount': targetWordCount,
      'lastModified': lastModified.toIso8601String(),
      'status': status,
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
      lastModified: lastModified,
      status: _parseStatus(status),
    );
  }

  static ProjectStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'published':
        return ProjectStatus.published;
      case 'archived':
        return ProjectStatus.archived;
      default:
        return ProjectStatus.draft;
    }
  }
}

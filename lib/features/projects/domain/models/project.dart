class Project {
  final String id;
  final String title;
  final String? synopsis;
  final String? coverUrl;
  final String? genre;
  final int currentWordCount;
  final int targetWordCount;
  final DateTime lastModified;
  final ProjectStatus status;

  const Project({
    required this.id,
    required this.title,
    this.synopsis,
    this.coverUrl,
    this.genre,
    this.currentWordCount = 0,
    this.targetWordCount = 50000,
    required this.lastModified,
    this.status = ProjectStatus.draft,
  });
}

enum ProjectStatus {
  draft,
  published,
  archived
}

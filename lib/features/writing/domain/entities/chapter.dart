class Chapter {
  final String id;
  final String projectId;
  final String title;
  final String content;
  final int sortOrder;
  final int wordCount;
  final DateTime lastModified;

  const Chapter({
    required this.id,
    required this.projectId,
    required this.title,
    required this.content,
    required this.sortOrder,
    this.wordCount = 0,
    required this.lastModified,
  });
}

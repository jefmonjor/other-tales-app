class Chapter {
  final String id;
  final String projectId;
  final String title;
  final String content;
  final int orderIndex;
  final DateTime lastModified;

  const Chapter({
    required this.id,
    required this.projectId,
    required this.title,
    required this.content,
    required this.orderIndex,
    required this.lastModified,
  });
}

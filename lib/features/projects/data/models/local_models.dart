import 'package:isar/isar.dart';

part 'local_models.g.dart';

@collection
class LocalProject {
  Id get isarId => fastHash(id); // Helper for String UUIDs

  @Index(unique: true, replace: true)
  late String id; // UUID from Backend

  late String title;
  String? synopsis;
  String? coverUrl;
  
  late DateTime updatedAt;

  @Enumerated(EnumType.ordinal)
  late SyncStatus syncStatus;
}

@collection
class LocalChapter {
  Id get isarId => fastHash(id);

  @Index(unique: true, replace: true)
  late String id;

  @Index()
  late String projectId;

  late String content;
  late DateTime updatedAt;
  
  @Enumerated(EnumType.ordinal)
  late SyncStatus syncStatus;
}

enum SyncStatus {
  synced,
  dirty, // Needs push to backend
  deleted, 
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

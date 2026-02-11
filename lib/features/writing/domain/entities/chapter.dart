import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter.freezed.dart';
part 'chapter.g.dart';

@freezed
class Chapter with _$Chapter {
  const Chapter._();

  const factory Chapter({
    required String id,
    required String projectId,
    required String title,
    required String content,
    required int sortOrder,
    @Default(0) int wordCount,
    @JsonKey(name: 'updatedAt') required DateTime lastModified,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);
}

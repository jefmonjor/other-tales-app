import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/chapter.dart';

part 'chapter_dto.freezed.dart';
part 'chapter_dto.g.dart';

@freezed
class ChapterDto with _$ChapterDto {
  const ChapterDto._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ChapterDto({
    required String id,
    required String projectId,
    required String title,
    required String content,
    @Default(0) int orderIndex,
    @Default('') String updatedAt,
  }) = _ChapterDto;

  factory ChapterDto.fromJson(Map<String, dynamic> json) => _$ChapterDtoFromJson(json);

  Chapter toDomain() {
    return Chapter(
      id: id,
      projectId: projectId,
      title: title,
      content: content,
      orderIndex: orderIndex,
      lastModified: DateTime.tryParse(updatedAt) ?? DateTime.now(),
    );
  }
}

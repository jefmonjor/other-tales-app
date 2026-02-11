import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const Project._();

  const factory Project({
    required String id,
    required String title,
    String? synopsis,
    String? coverUrl,
    String? genre,
    @Default(0) int currentWordCount,
    @Default(50000) int targetWordCount,
    @JsonKey(name: 'updatedAt') required DateTime lastModified,
    DateTime? createdAt,
    @Default(ProjectStatus.draft) ProjectStatus status,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}

enum ProjectStatus {
  @JsonValue('DRAFT')
  draft,
  @JsonValue('PUBLISHED')
  published,
}

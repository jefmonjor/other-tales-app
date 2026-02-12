import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
class Story with _$Story {
  const factory Story({
    required String id,
    required String projectId,
    required String title,
    String? synopsis,
    String? theme,
    String? secondaryPlots, // Matches backend camelCase
    String? others,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}

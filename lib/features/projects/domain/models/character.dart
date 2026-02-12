import 'package:freezed_annotation/freezed_annotation.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String id,
    required String projectId,
    required String name,
    String? role,
    String? description,
    String? physicalDescription, // Matches backend camelCase
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
}

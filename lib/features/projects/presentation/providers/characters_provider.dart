import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../../../core/network/dio_provider.dart';
import '../../data/repositories/character_repository.dart';
import '../../domain/models/character.dart';

part 'characters_provider.g.dart';

@riverpod
CharacterRepository characterRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CharacterRepository(dio);
}

@riverpod
class Characters extends _$Characters {
  @override
  @override
  FutureOr<List<Character>> build(String projectId) async {
    final repository = ref.watch(characterRepositoryProvider);
    // TODO: Implement proper pagination support in the provider/UI.
    final response = await repository.getCharacters(projectId, page: 0, size: 20);
    return response.content;
  }

  Future<void> create(Map<String, dynamic> data, File? imageFile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(characterRepositoryProvider);
      await repository.createCharacter(projectId, data, imageFile);
      return ref.refresh(charactersProvider(projectId).future);
    });
  }

  Future<void> updateCharacter(String characterId, Map<String, dynamic> data, File? imageFile) async {
    // Optimistic update could be implemented here, but for now we'll refresh
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(characterRepositoryProvider);
      await repository.updateCharacter(projectId, characterId, data, imageFile);
      return ref.refresh(charactersProvider(projectId).future);
    });
  }

  Future<void> delete(String characterId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(characterRepositoryProvider);
      await repository.deleteCharacter(projectId, characterId);
      return ref.refresh(charactersProvider(projectId).future);
    });
  }
}

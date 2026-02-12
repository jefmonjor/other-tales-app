import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../../../core/network/dio_provider.dart';
import '../../data/repositories/story_repository.dart';
import '../../domain/models/story.dart';

part 'stories_provider.g.dart';

@riverpod
StoryRepository storyRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return StoryRepository(dio);
}

@riverpod
class Stories extends _$Stories {
  @override
  @override
  FutureOr<List<Story>> build(String projectId) async {
    final repository = ref.watch(storyRepositoryProvider);
    // TODO: Implement proper pagination support in the provider/UI.
    final response = await repository.getStories(projectId, page: 0, size: 20);
    return response.content;
  }

  Future<void> create(Map<String, dynamic> data, File? imageFile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(storyRepositoryProvider);
      await repository.createStory(projectId, data, imageFile);
      return ref.refresh(storiesProvider(projectId).future);
    });
  }

  Future<void> updateStory(String storyId, Map<String, dynamic> data, File? imageFile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(storyRepositoryProvider);
      await repository.updateStory(projectId, storyId, data, imageFile);
      return ref.refresh(storiesProvider(projectId).future);
    });
  }

  Future<void> delete(String storyId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(storyRepositoryProvider);
      await repository.deleteStory(projectId, storyId);
      return ref.refresh(storiesProvider(projectId).future);
    });
  }
}

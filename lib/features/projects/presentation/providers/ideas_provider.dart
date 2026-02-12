import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/repositories/idea_repository.dart';
import '../../domain/models/idea.dart';

part 'ideas_provider.g.dart';

@riverpod
IdeaRepository ideaRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return IdeaRepository(dio);
}

@riverpod
class Ideas extends _$Ideas {
  @override
  FutureOr<List<Idea>> build(String projectId) async {
    final repository = ref.watch(ideaRepositoryProvider);
    // TODO: Implement proper pagination
    final response = await repository.getIdeas(projectId, page: 0, size: 20);
    return response.content;
  }

  Future<void> create(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(ideaRepositoryProvider);
      await repository.createIdea(projectId, data);
      return ref.refresh(ideasProvider(projectId).future);
    });
  }

  Future<void> updateIdea(String ideaId, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(ideaRepositoryProvider);
      await repository.updateIdea(projectId, ideaId, data);
      return ref.refresh(ideasProvider(projectId).future);
    });
  }

  Future<void> delete(String ideaId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(ideaRepositoryProvider);
      await repository.deleteIdea(projectId, ideaId);
      return ref.refresh(ideasProvider(projectId).future);
    });
  }
}

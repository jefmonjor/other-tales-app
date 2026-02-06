import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/chapter.dart';
import '../../data/repositories/chapter_repository_impl.dart';

part 'chapter_controller.g.dart';

@riverpod
Future<List<Chapter>> chapters(ChaptersRef ref, String projectId) async {
  final repository = ref.watch(chapterRepositoryProvider);
  final result = await repository.getChapters(projectId);
  
  return result.fold(
    (failure) => throw failure, 
    (chapters) => chapters,
  );
}

@riverpod
class ChapterController extends _$ChapterController {
  @override
  AsyncValue<Chapter?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> saveChapter({
    required String projectId,
    String? chapterId,
    required String title,
    required String content,
  }) async {
    state = const AsyncValue.loading();

    final repository = ref.read(chapterRepositoryProvider);
    final result = await repository.saveChapter(
      projectId: projectId,
      chapterId: chapterId,
      title: title,
      content: content,
    );

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (savedChapter) {
        state = AsyncValue.data(savedChapter);
        // Refresh the list of chapters for this project
        ref.invalidate(chaptersProvider(projectId));
      },
    );
  }
}

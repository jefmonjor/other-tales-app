import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/projects_repository_impl.dart';
import '../../domain/models/project.dart';
import '../../domain/repositories/projects_repository.dart';

part 'projects_providers.g.dart';

/// Re-export the repository provider from the data layer.
/// This allows the presentation layer to depend on the abstract interface.
@riverpod
Future<List<Project>> projectsList(ProjectsListRef ref) async {
  final repository = ref.watch(projectsRepositoryProvider);
  final result = await repository.getProjects();
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (projects) => projects,
  );
}

/// Provider for creating a new project.
/// Returns the created project on success.
@riverpod
class CreateProject extends _$CreateProject {
  @override
  FutureOr<Project?> build() => null;
  
  Future<void> create({
    required String title,
    String? synopsis,
    String? genre,
    int? targetWordCount,
  }) async {
    state = const AsyncLoading();
    
    final repository = ref.read(projectsRepositoryProvider);
    final result = await repository.createProject(
      title: title,
      synopsis: synopsis,
      genre: genre,
      targetWordCount: targetWordCount,
    );
    
    state = result.fold(
      (failure) => AsyncError(Exception(failure.message), StackTrace.current),
      (project) {
        // Invalidate the projects list to refresh
        ref.invalidate(projectsListProvider);
        return AsyncData(project);
      },
    );
  }
}

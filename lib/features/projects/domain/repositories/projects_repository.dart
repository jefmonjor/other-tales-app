import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../models/project.dart';

/// Abstract repository interface for Projects.
/// Following Clean Architecture, this lives in the domain layer.
abstract class ProjectsRepository {
  /// Get all projects for the current user (paginated).
  Future<Either<Failure, List<Project>>> getProjects({
    int page = 0,
    int size = 20,
    String? sortBy,
  });

  /// Get a single project by ID.
  Future<Either<Failure, Project>> getProject(String id);

  /// Create a new project.
  Future<Either<Failure, Project>> createProject({
    required String title,
    String? synopsis,
    String? genre,
    int? targetWordCount,
  });

  /// Update an existing project by ID.
  Future<Either<Failure, Project>> updateProject(
    String id, {
    String? title,
    String? synopsis,
    String? genre,
    int? targetWordCount,
  });

  /// Delete a project by ID.
  Future<Either<Failure, void>> deleteProject(String id);
}

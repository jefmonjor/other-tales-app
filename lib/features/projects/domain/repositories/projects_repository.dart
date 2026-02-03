import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../models/project.dart';

/// Abstract repository interface for Projects.
/// Following Clean Architecture, this lives in the domain layer.
abstract class ProjectsRepository {
  /// Get all projects for the current user.
  Future<Either<Failure, List<Project>>> getProjects();
  
  /// Create a new project.
  Future<Either<Failure, Project>> createProject({
    required String title,
    String? synopsis,
    String? genre,
    int? targetWordCount,
  });
  
  /// Delete a project by ID.
  Future<Either<Failure, void>> deleteProject(String id);
}

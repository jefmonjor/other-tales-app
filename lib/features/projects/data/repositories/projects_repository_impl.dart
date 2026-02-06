import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/dio_provider.dart';
import '../../domain/models/project.dart';
import '../../domain/repositories/projects_repository.dart';
import '../models/project_dto.dart';

part 'projects_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ProjectsRepository projectsRepository(ProjectsRepositoryRef ref) {
  return ProjectsRepositoryImpl(ref.watch(dioProvider));
}

class ProjectsRepositoryImpl implements ProjectsRepository {
  final Dio _dio;

  ProjectsRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    try {
      // Contract: GET /api/v1/projects — paginated response
      final response = await _dio.get('/projects');

      // Backend returns paginated: { content: [...], page, size, totalElements, totalPages }
      final data = response.data;
      final List<dynamic> content = data is Map<String, dynamic>
          ? (data['content'] as List<dynamic>? ?? [])
          : (data as List<dynamic>);

      final projects = content
          .map((json) => ProjectDto.fromJson(json).toDomain())
          .toList();

      return Right(projects);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Project>> createProject({
    required String title,
    String? synopsis,
    String? genre,
    int? targetWordCount,
  }) async {
    try {
      // Contract: POST /api/v1/projects
      // Backend extracts userId from JWT — no need to send it
      final requestData = <String, dynamic>{
        'title': title,
      };
      if (synopsis != null) requestData['synopsis'] = synopsis;
      if (genre != null) requestData['genre'] = genre;
      if (targetWordCount != null) requestData['targetWordCount'] = targetWordCount;

      final response = await _dio.post(
        '/projects',
        data: requestData,
      );

      return Right(ProjectDto.fromJson(response.data).toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String id) async {
    try {
      // Contract: DELETE /api/v1/projects/{id} — soft delete, returns 204
      await _dio.delete('/projects/$id');
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic>) {
        // RFC 7807 Parsing
        final String message = data['detail'] ?? data['title'] ?? 'Server Error: ${e.response!.statusCode}';
        final String? code = data['code'];
        final List<dynamic>? errors = data['errors'];

        return ServerFailure(
          message,
          statusCode: e.response!.statusCode,
          errorType: code,
          fieldErrors: errors,
        );
      }
      return ServerFailure('Server Error: ${e.response!.statusCode}', statusCode: e.response!.statusCode);
    }
    return const NetworkFailure();
  }
}

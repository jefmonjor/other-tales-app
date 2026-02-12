import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/dio_provider.dart';
import '../../domain/models/project.dart';
import '../../domain/repositories/projects_repository.dart';
import '../models/project_dto.dart';

part 'projects_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ProjectsRepository projectsRepository(Ref ref) {
  return ProjectsRepositoryImpl(ref.watch(dioProvider));
}

class ProjectsRepositoryImpl implements ProjectsRepository {
  final Dio _dio;

  ProjectsRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, List<Project>>> getProjects({
    int page = 0,
    int size = 20,
    String? sortBy,
  }) async {
    try {
      // Contract: GET /api/v1/projects?page=0&size=20&sortBy=updatedAt
      final queryParams = <String, dynamic>{
        'page': page,
        'size': size,
      };
      if (sortBy != null) queryParams['sortBy'] = sortBy;

      final response = await _dio.get(
        '/projects',
        queryParameters: queryParams,
      );

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
  Future<Either<Failure, Project>> getProject(String id) async {
    try {
      // Contract: GET /api/v1/projects/{projectId}
      final response = await _dio.get('/projects/$id');
      return Right(ProjectDto.fromJson(response.data).toDomain());
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
  Future<Either<Failure, Project>> updateProject(
    String id, {
    String? title,
    String? synopsis,
    String? genre,
    int? targetWordCount,
  }) async {
    try {
      // Contract: PUT /api/v1/projects/{projectId}
      // All fields optional
      final requestData = <String, dynamic>{};
      if (title != null) requestData['title'] = title;
      if (synopsis != null) requestData['synopsis'] = synopsis;
      if (genre != null) requestData['genre'] = genre;
      if (targetWordCount != null) requestData['targetWordCount'] = targetWordCount;

      final response = await _dio.put(
        '/projects/$id',
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
        // RFC 7807 Parsing (C4 fix):
        // - data['title'] is the human-readable message
        // - data['code'] is the error type identifier
        final String message = data['title'] ?? 'Server Error: ${e.response!.statusCode}';
        final String? errorType = data['code'] as String?;
        final List<dynamic>? errors = data['errors'] as List<dynamic>?;

        return ServerFailure(
          message,
          statusCode: e.response!.statusCode,
          errorType: errorType,
          fieldErrors: errors,
        );
      }
      return ServerFailure('Server Error: ${e.response!.statusCode}', statusCode: e.response!.statusCode);
    }
    return const NetworkFailure();
  }
}

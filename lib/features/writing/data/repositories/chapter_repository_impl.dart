import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/dio_provider.dart';
import '../../domain/entities/chapter.dart';
import '../../domain/repositories/chapter_repository.dart';
import '../models/chapter_dto.dart';

part 'chapter_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ChapterRepository chapterRepository(Ref ref) {
  return ChapterRepositoryImpl(ref.watch(dioProvider));
}

class ChapterRepositoryImpl implements ChapterRepository {
  final Dio _dio;

  ChapterRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, List<Chapter>>> getChapters(String projectId) async {
    try {
      final response = await _dio.get(
        '/projects/$projectId/chapters',
      );

      // Handle both List (direct array) and Map (paginated) responses
      final data = response.data;
      final List<dynamic> content = data is Map<String, dynamic>
          ? (data['content'] as List<dynamic>? ?? [])
          : (data as List<dynamic>);

      final chapters = content
          .map((json) => ChapterDto.fromJson(json).toDomain())
          .toList();

      return Right(chapters);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Chapter>> getChapter(String chapterId) async {
    try {
      // Contract: GET /api/v1/chapters/{chapterId}
      final response = await _dio.get('/chapters/$chapterId');

      final chapterDto = ChapterDto.fromJson(response.data);
      return Right(chapterDto.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Chapter>> saveChapter({
    required String projectId,
    String? chapterId,
    required String title,
    required String content,
    int? sortOrder,
  }) async {
    try {
      final data = <String, dynamic>{
        'title': title,
        'content': content,
      };

      Response response;
      if (chapterId != null) {
        // Update -- contract: PUT /api/v1/chapters/{chapterId}
        response = await _dio.put(
          '/chapters/$chapterId',
          data: data,
        );
      } else {
        // Create -- contract: POST /api/v1/projects/{projectId}/chapters
        if (sortOrder != null) {
          data['sortOrder'] = sortOrder;
        }
        response = await _dio.post(
          '/projects/$projectId/chapters',
          data: data,
        );
      }

      final chapterDto = ChapterDto.fromJson(response.data);
      return Right(chapterDto.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChapter(String chapterId) async {
    try {
      // Contract: DELETE /api/v1/chapters/{chapterId} -> 204 No Content
      await _dio.delete('/chapters/$chapterId');
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Chapter>>> reorderChapters(
    String projectId,
    List<String> orderedChapterIds,
  ) async {
    try {
      // Contract: PATCH /api/v1/projects/{projectId}/chapters/reorder
      final response = await _dio.patch(
        '/projects/$projectId/chapters/reorder',
        data: {'orderedChapterIds': orderedChapterIds},
      );

      final List<dynamic> data = response.data;
      final chapters = data
          .map((json) => ChapterDto.fromJson(json).toDomain())
          .toList();

      return Right(chapters);
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
        // Use 'title' for human-readable message, 'detail' as fallback
        final String message =
            data['title'] ?? data['detail'] ?? 'Server Error: ${e.response!.statusCode}';
        // Use 'code' for errorType
        final String? code = data['code'];
        final List<dynamic>? errors = data['errors'];

        return ServerFailure(
          message,
          statusCode: e.response!.statusCode,
          errorType: code,
          fieldErrors: errors,
        );
      }
      return ServerFailure(
        'Server Error: ${e.response!.statusCode}',
        statusCode: e.response!.statusCode,
      );
    }
    return const NetworkFailure();
  }
}

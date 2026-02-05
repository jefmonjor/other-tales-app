import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/dio_provider.dart';
import '../../domain/entities/chapter.dart';
import '../../domain/repositories/chapter_repository.dart';
import '../models/chapter_dto.dart';

part 'chapter_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ChapterRepository chapterRepository(ChapterRepositoryRef ref) {
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

  @override
  Future<Either<Failure, Chapter>> saveChapter({
    required String projectId,
    String? chapterId,
    required String title,
    required String content,
  }) async {
    try {
      final data = {
        'title': title,
        'content': content,
      };

      Response response;
      if (chapterId != null) {
        // Update
        response = await _dio.put(
          '/projects/$projectId/chapters/$chapterId',
          data: data,
        );
      } else {
        // Create
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

  Failure _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic>) {
        // RFC 7807 Parsing
        // Priority: detail -> title -> "Server Error"
        final String message = data['detail'] ?? data['title'] ?? 'Server Error: ${e.response!.statusCode}';
        final String? code = data['code'];
        
        return ServerFailure(
          message, 
          statusCode: e.response!.statusCode,
          errorType: code, // Mapping 'code' to 'errorType'
        );
      }
      return ServerFailure('Server Error: ${e.response!.statusCode}', statusCode: e.response!.statusCode);
    }
    return const NetworkFailure();
  }
}

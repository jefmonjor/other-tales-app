import 'package:dio/dio.dart';
import '../../../../core/models/paginated_response.dart';
import '../../domain/models/idea.dart';

class IdeaRepository {
  final Dio _dio;

  IdeaRepository(this._dio);

  Future<PaginatedResponse<Idea>> getIdeas(String projectId, {int page = 0, int size = 10}) async {
    final response = await _dio.get(
      '/api/v1/projects/$projectId/ideas',
      queryParameters: {'page': page, 'size': size},
    );
    return PaginatedResponse<Idea>.fromJson(
      response.data,
      (json) => Idea.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<Idea> getIdea(String projectId, String ideaId) async {
    final response = await _dio.get('/api/v1/projects/$projectId/ideas/$ideaId');
    return Idea.fromJson(response.data);
  }

  Future<Idea> createIdea(String projectId, Map<String, dynamic> data) async {
    final response = await _dio.post('/api/v1/projects/$projectId/ideas', data: data);
    return Idea.fromJson(response.data);
  }

  Future<Idea> updateIdea(String projectId, String ideaId, Map<String, dynamic> data) async {
    final response = await _dio.put('/api/v1/projects/$projectId/ideas/$ideaId', data: data);
    return Idea.fromJson(response.data);
  }

  Future<void> deleteIdea(String projectId, String ideaId) async {
    await _dio.delete('/api/v1/projects/$projectId/ideas/$ideaId');
  }
}

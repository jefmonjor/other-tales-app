import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../core/models/paginated_response.dart';
import '../../domain/models/story.dart';

class StoryRepository {
  final Dio _dio;

  StoryRepository(this._dio);

  Future<PaginatedResponse<Story>> getStories(String projectId, {int page = 0, int size = 10}) async {
    final response = await _dio.get(
      '/api/v1/projects/$projectId/stories',
      queryParameters: {'page': page, 'size': size},
    );
    return PaginatedResponse<Story>.fromJson(
      response.data,
      (json) => Story.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<Story> getStory(String projectId, String storyId) async {
    final response = await _dio.get('/api/v1/projects/$projectId/stories/$storyId');
    return Story.fromJson(response.data);
  }

  Future<Story> createStory(String projectId, Map<String, dynamic> data, File? imageFile) async {
    final formData = FormData.fromMap({
      'data': MultipartFile.fromString(
        jsonEncode(data),
        contentType: MediaType('application', 'json'),
      ),
      if (imageFile != null)
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    final response = await _dio.post(
      '/api/v1/projects/$projectId/stories',
      data: formData,
    );
    return Story.fromJson(response.data);
  }

  Future<Story> updateStory(String projectId, String storyId, Map<String, dynamic> data, File? imageFile) async {
    final formData = FormData.fromMap({
      'data': MultipartFile.fromString(
        jsonEncode(data),
        contentType: MediaType('application', 'json'),
      ),
      if (imageFile != null)
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    final response = await _dio.put(
      '/api/v1/projects/$projectId/stories/$storyId',
      data: formData,
    );
    return Story.fromJson(response.data);
  }

  Future<void> deleteStory(String projectId, String storyId) async {
    await _dio.delete('/api/v1/projects/$projectId/stories/$storyId');
  }
}

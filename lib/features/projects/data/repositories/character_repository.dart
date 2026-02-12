import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../core/models/paginated_response.dart';
import '../../domain/models/character.dart';

class CharacterRepository {
  final Dio _dio;

  CharacterRepository(this._dio);

  Future<PaginatedResponse<Character>> getCharacters(String projectId, {int page = 0, int size = 10}) async {
    final response = await _dio.get(
      '/api/v1/projects/$projectId/characters',
      queryParameters: {'page': page, 'size': size},
    );
    return PaginatedResponse<Character>.fromJson(
      response.data,
      (json) => Character.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<Character> getCharacter(String projectId, String characterId) async {
    final response = await _dio.get('/api/v1/projects/$projectId/characters/$characterId');
    return Character.fromJson(response.data);
  }

  Future<Character> createCharacter(String projectId, Map<String, dynamic> data, File? imageFile) async {
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
      '/api/v1/projects/$projectId/characters',
      data: formData,
    );
    return Character.fromJson(response.data);
  }

  Future<Character> updateCharacter(String projectId, String characterId, Map<String, dynamic> data, File? imageFile) async {
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
      '/api/v1/projects/$projectId/characters/$characterId',
      data: formData,
    );
    return Character.fromJson(response.data);
  }

  Future<void> deleteCharacter(String projectId, String characterId) async {
    await _dio.delete('/api/v1/projects/$projectId/characters/$characterId');
  }
}

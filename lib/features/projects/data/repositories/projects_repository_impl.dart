import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failure.dart';
import '../../domain/models/project.dart';
import '../../domain/repositories/projects_repository.dart';
import '../models/project_dto.dart';

part 'projects_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ProjectsRepository projectsRepository(ProjectsRepositoryRef ref) {
  return ProjectsRepositoryImpl();
}

class ProjectsRepositoryImpl implements ProjectsRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  ProjectsRepositoryImpl();

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    try {
      final response = await _supabase
          .from('projects')
          .select()
          .order('created_at'); // Assumes 'created_at' exists
      
      final projects = response.map((json) {
        // Map Supabase snake_case to DTO/Domain camelCase if needed
        // Or assume Supabase returns what DTO expects (if DTO was updated)
        // Since I haven't updated DTO, I'll map manually here to be safe and robust
        
        // This is a "best effort" mapping assuming standard Supabase columns vs DTO fields
        final mappedJson = {
          'id': json['id'],
          'title': json['title'],
          'synopsis': json['synopsis'],
          'coverUrl': json['cover_url'] ?? json['coverUrl'], 
          'genre': json['genre'],
          'currentWordCount': json['current_word_count'] ?? json['currentWordCount'] ?? 0,
          'targetWordCount': json['target_word_count'] ?? json['targetWordCount'] ?? 50000,
          'lastModified': json['updated_at'] ?? json['created_at'] ?? DateTime.now().toIso8601String(),
          'status': json['status'] ?? 'draft',
        };

        return ProjectDto.fromJson(mappedJson).toDomain();
      }).toList();
      
      return Right(projects);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
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
      // Build the map to insert
      final projectMap = {
        'title': title,
        'synopsis': synopsis,
        'genre': genre,
        // Supabase usually uses snake_case for columns
        'target_word_count': targetWordCount ?? 50000,
        // 'user_id': _supabase.auth.currentUser!.id, // Supabase triggers usually handle this or we send it
        'user_id': _supabase.auth.currentUser?.id, 
        'status': 'draft',
      };

      // Remove nulls if wanted, but Supabase handles nulls
      projectMap.removeWhere((key, value) => value == null);

      final response = await _supabase
          .from('projects')
          .insert(projectMap)
          .select() // Select to get back the created record (including generated ID)
          .single();
      
      // Map response to domain
       final mappedJson = {
          'id': response['id'],
          'title': response['title'],
          'synopsis': response['synopsis'],
          'coverUrl': response['cover_url'],
          'genre': response['genre'],
          'currentWordCount': response['current_word_count'] ?? 0,
          'targetWordCount': response['target_word_count'] ?? 50000,
          'lastModified': response['updated_at'] ?? response['created_at'],
          'status': response['status'] ?? 'draft',
        };

      return Right(ProjectDto.fromJson(mappedJson).toDomain());
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String id) async {
    try {
      await _supabase.from('projects').delete().eq('id', id);
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

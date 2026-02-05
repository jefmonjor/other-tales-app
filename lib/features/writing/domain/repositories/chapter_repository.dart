import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/chapter.dart';

abstract class ChapterRepository {
  Future<Either<Failure, List<Chapter>>> getChapters(String projectId);
  
  Future<Either<Failure, Chapter>> saveChapter({
    required String projectId,
    String? chapterId,
    required String title,
    required String content,
  });
}

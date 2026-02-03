import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/projects/data/models/local_models.dart';

part 'local_db.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> localDb(LocalDbRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [LocalProjectSchema, LocalChapterSchema],
    directory: dir.path,
  );
}

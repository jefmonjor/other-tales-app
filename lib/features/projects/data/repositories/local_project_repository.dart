import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/local_db.dart';
import '../models/local_models.dart';

part 'local_project_repository.g.dart';

@riverpod
LocalProjectRepository localProjectRepository(LocalProjectRepositoryRef ref) {
  final isarAsync = ref.watch(localDbProvider);
  // We throw (or handle async differently) if DB isn't ready, but for Riverpod generic use asyncMain
  // Here simpler pattern: The repository itself returns Futures and awaits the provider
  return LocalProjectRepository(ref);
}

class LocalProjectRepository {
  final LocalProjectRepositoryRef _ref;

  LocalProjectRepository(this._ref);

  Future<Isar> get _isar => _ref.read(localDbProvider.future);

  Future<void> saveProject(LocalProject project) async {
    final isar = await _isar;
    await isar.writeTxn(() async {
      await isar.localProjects.put(project);
    });
  }

  Future<List<LocalProject>> getAllProjects() async {
    final isar = await _isar;
    return await isar.localProjects.where().findAll();
  }

  Future<void> deleteProject(String id) async {
    final isar = await _isar;
    await isar.writeTxn(() async {
      // Use internal Isar ID generated from fastHash
      await isar.localProjects.delete(fastHash(id));
    });
  }
}

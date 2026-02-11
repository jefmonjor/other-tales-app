import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/models/profile_model.dart';

part 'profile_provider.g.dart';

@riverpod
Future<ProfileModel> currentProfile(CurrentProfileRef ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  final result = await repository.getProfile();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (profile) => profile,
  );
}

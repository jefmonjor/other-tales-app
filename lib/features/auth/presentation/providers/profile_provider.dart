import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/models/profile_model.dart';

part 'profile_provider.g.dart';

@riverpod
Future<ProfileModel> currentProfile(Ref ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  final result = await repository.getProfile();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (profile) => profile,
  );
}

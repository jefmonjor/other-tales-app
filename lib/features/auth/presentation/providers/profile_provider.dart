import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/models/profile_model.dart';

part 'profile_provider.g.dart';

@riverpod
Future<ProfileModel> currentProfile(CurrentProfileRef ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get('/profiles/me');
  return ProfileModel.fromJson(response.data);
}

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/profile_model.dart';

part 'profile_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepositoryImpl(ref.watch(dioProvider));
}

class ProfileRepositoryImpl implements ProfileRepository {
  final Dio _dio;
  ProfileRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final response = await _dio.get('/profiles/me');
      return Right(ProfileModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> updateProfile({String? fullName, String? avatarUrl}) async {
    try {
      final data = <String, dynamic>{};
      if (fullName != null) data['fullName'] = fullName;
      if (avatarUrl != null) data['avatarUrl'] = avatarUrl;
      final response = await _dio.put('/profiles/me', data: data);
      return Right(ProfileModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateConsent({required String consentType, required bool granted}) async {
    try {
      await _dio.post('/user/consent', data: {
        'consentType': consentType,
        'granted': granted,
      });
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic>) {
        final String message = data['title'] ?? data['detail'] ?? 'Server Error: ${e.response!.statusCode}';
        final String? code = data['code'];
        final List<dynamic>? errors = data['errors'];
        return ServerFailure(message, statusCode: e.response!.statusCode, errorType: code, fieldErrors: errors);
      }
      return ServerFailure('Server Error: ${e.response!.statusCode}', statusCode: e.response!.statusCode);
    }
    return const NetworkFailure();
  }
}

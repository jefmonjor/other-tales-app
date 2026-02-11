import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> getProfile();
  Future<Either<Failure, ProfileModel>> updateProfile({String? fullName, String? avatarUrl});
  Future<Either<Failure, void>> updateConsent({required String consentType, required bool granted});
}

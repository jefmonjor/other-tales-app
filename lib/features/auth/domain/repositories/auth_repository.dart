import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, void>> register(
    String name, 
    String email, 
    String password, {
    required bool marketingAccepted,
    required bool termsAccepted,
    required bool privacyAccepted,
  });
}

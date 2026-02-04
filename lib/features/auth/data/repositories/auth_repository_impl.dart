import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_repository_impl.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl();
}

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  AuthRepositoryImpl();

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email, 
        password: password,
      );
      return const Right(null);
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> register(
    String name, 
    String email, 
    String password, {
    required bool marketingAccepted,
    required bool termsAccepted,
    required bool privacyAccepted,
  }) async {
    try {
      await _supabase.auth.signUp(
        email: email, 
        password: password,
        data: {
          'full_name': name,
          'marketing_accepted': marketingAccepted,
          'terms_accepted': termsAccepted,
          'privacy_accepted': privacyAccepted,
          'accepted_at': DateTime.now().toIso8601String(),
        },
      );
      // Supabase automatically signs in after signup if email confirmation is disabled or if using defaults.
      
      return const Right(null);
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithGoogle() async {
    try {
      await _supabase.auth.signInWithOAuth(OAuthProvider.google);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithApple() async {
    try {
      await _supabase.auth.signInWithOAuth(OAuthProvider.apple);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

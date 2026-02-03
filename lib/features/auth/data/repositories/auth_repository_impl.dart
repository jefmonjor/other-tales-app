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
  Future<Either<Failure, void>> register(String name, String email, String password) async {
    try {
      await _supabase.auth.signUp(
        email: email, 
        password: password,
        data: {'full_name': name},
      );
      // Supabase automatically signs in after signup if email confirmation is disabled or if using defaults.
      // If email confirmation is enabled, user can't login yet. 
      // But typically for development/demo, it signs up successfully.
      
      return const Right(null);
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  @override
  FutureOr<void> build() {
    // idle state
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required bool marketingAccepted,
    required bool termsAccepted,
    required bool privacyAccepted,
  }) async {
    state = const AsyncLoading();
    
    final repository = ref.read(authRepositoryProvider);
    // 1. Register
    final registerResult = await repository.register(
      name, 
      email, 
      password,
      marketingAccepted: marketingAccepted,
      termsAccepted: termsAccepted,
      privacyAccepted: privacyAccepted,
    );
    
    // 2. Handle Result
    await registerResult.fold(
      (failure) async { 
         state = AsyncError(Exception(failure.message), StackTrace.current); 
      },
      (_) async {
         // 3. Auto Login on Success
         final loginResult = await repository.login(email, password);
         state = loginResult.fold(
            (failure) => AsyncError(Exception("Registration successful, however login failed: ${failure.message}"), StackTrace.current),
            (_) => const AsyncData(null),
         );
      },
    );
  }

  Future<void> signUpWithGoogle() async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signInWithGoogle();
    state = result.fold(
      (failure) => AsyncError(Exception(failure.message), StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> signUpWithApple() async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signInWithApple();
    state = result.fold(
      (failure) => AsyncError(Exception(failure.message), StackTrace.current),
      (_) => const AsyncData(null),
    );
  }
}

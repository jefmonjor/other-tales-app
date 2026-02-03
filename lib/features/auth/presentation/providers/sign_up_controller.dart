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

  Future<void> register(String name, String email, String password) async {
    state = const AsyncLoading();
    
    final repository = ref.read(authRepositoryProvider);
    // 1. Register
    final registerResult = await repository.register(name, email, password);
    
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
}

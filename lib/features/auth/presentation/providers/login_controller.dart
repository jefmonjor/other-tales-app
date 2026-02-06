import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.login(email, password);

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signInWithGoogle();
    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> loginWithApple() async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signInWithApple();
    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }
}

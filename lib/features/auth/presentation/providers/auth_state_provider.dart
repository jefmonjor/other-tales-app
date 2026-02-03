import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/storage/token_storage.dart';

part 'auth_state_provider.g.dart';

enum AuthStatus {
  loading,
  authenticated,
  unauthenticated,
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Stream<AuthStatus> build() async* {
    yield AuthStatus.loading;
    final tokenStorage = ref.watch(tokenStorageProvider);
    final token = await tokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      yield AuthStatus.authenticated;
    } else {
      yield AuthStatus.unauthenticated;
    }
  }

  Future<void> logout() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    await tokenStorage.clearTokens();
    // Force refresh or state update
    // Since this is a stream, we might need a way to invalidate or emitting new value 
    // Usually with StreamNotifier we might re-run build or manage a controller
    // For simplicity with Riverpod Generator StreamNotifier:
    ref.invalidateSelf(); 
  }
  
  Future<void> checkAuth() async {
      ref.invalidateSelf();
  }
}

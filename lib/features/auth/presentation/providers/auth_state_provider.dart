import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state_provider.g.dart';

enum AuthStatus {
  loading,
  authenticated,
  unauthenticated,
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Stream<AuthStatus> build() {
    return Supabase.instance.client.auth.onAuthStateChange.map((data) {
      final session = data.session;
      if (session != null) {
        return AuthStatus.authenticated;
      }
      return AuthStatus.unauthenticated;
    });
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }
}

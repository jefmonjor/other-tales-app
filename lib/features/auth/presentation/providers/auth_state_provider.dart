import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  Stream<AuthStatus> build() {
    // Listen to Supabase Auth Changes directly
    return Supabase.instance.client.auth.onAuthStateChange.map((data) {
      final session = data.session;
      if (session != null) {
        return AuthStatus.authenticated;
      }
      return AuthStatus.unauthenticated;
    });
  }

  // Optional: manual check method if needed, usually stream handles it
  Future<void> checkAuth() async {
    // Stream updates automatically
  }
  
  Future<void> logout() async {
      await Supabase.instance.client.auth.signOut();
  }
}

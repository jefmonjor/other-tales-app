import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_state.g.dart';

@riverpod
class SignInForm extends _$SignInForm {
  @override
  SignInState build() {
    return const SignInState();
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  Future<void> submit() async {
    // TODO: Implement backend integration
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 2)); // Mock delay
    state = state.copyWith(isLoading: false);
  }
}

class SignInState {
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isLoading;

  const SignInState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isLoading = false,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isLoading,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/profile_repository_impl.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  @override
  FutureOr<void> build() {}

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
    final result = await repository.register(
      name,
      email,
      password,
      marketingAccepted: marketingAccepted,
      termsAccepted: termsAccepted,
      privacyAccepted: privacyAccepted,
    );

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) {
        // Record consent in backend after successful registration
        _recordConsent(
          termsAccepted: termsAccepted,
          privacyAccepted: privacyAccepted,
          marketingAccepted: marketingAccepted,
        );
        return const AsyncData(null);
      },
    );
  }

  Future<void> _recordConsent({
    required bool termsAccepted,
    required bool privacyAccepted,
    required bool marketingAccepted,
  }) async {
    final profileRepo = ref.read(profileRepositoryProvider);
    if (termsAccepted) {
      await profileRepo.updateConsent(consentType: 'TERMS_OF_SERVICE', granted: true);
    }
    if (privacyAccepted) {
      await profileRepo.updateConsent(consentType: 'PRIVACY_POLICY', granted: true);
    }
    if (marketingAccepted) {
      await profileRepo.updateConsent(consentType: 'MARKETING_COMMUNICATIONS', granted: true);
    }
  }

  Future<void> signUpWithGoogle() async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signInWithGoogle();
    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> signUpWithApple() async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signInWithApple();
    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }
}

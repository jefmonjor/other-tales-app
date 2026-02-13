import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/constants/legal_constants.dart';
import '../../../../core/presentation/universal_modal.dart';
import '../../../../core/error/auth_error_mapper.dart';
import '../../../../core/components/inputs/custom_text_field.dart';
import '../../../../core/components/buttons/primary_button.dart';
import '../providers/sign_up_controller.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/social_button.dart';
import '../../../../core/presentation/widgets/web_split_layout.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptMarketing = false;
  bool _acceptTerms = false;
  bool _acceptPrivacy = false;

  late final TapGestureRecognizer _termsRecognizer;
  late final TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()
      ..onTap = () => _showTerms(context);
    _privacyRecognizer = TapGestureRecognizer()
      ..onTap = () => _showPrivacy(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (ref.read(signUpControllerProvider).isLoading) return;

    final l10n = AppLocalizations.of(context)!;

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.mustAcceptTerms),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.passwordsDoNotMatch),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      await ref.read(signUpControllerProvider.notifier).register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        marketingAccepted: _acceptMarketing,
        termsAccepted: _acceptTerms,
        privacyAccepted: _acceptPrivacy,
      );
    }
  }

  void _showTerms(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    UniversalModal.showPlatformModal(
      context,
      title: l10n.termsTitle,
      content: const Text(LegalConstants.termsAndConditions),
    );
  }

  void _showPrivacy(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    UniversalModal.showPlatformModal(
      context,
      title: l10n.privacyTitle,
      content: const Text(LegalConstants.privacyPolicy),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen(signUpControllerProvider, (previous, next) {
      if (next is AsyncError) {
        final translatedError = AuthErrorMapper.getFriendlyMessage(
          next.error,
          Localizations.localeOf(context).languageCode,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(translatedError),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    final signUpState = ref.watch(signUpControllerProvider);
    final bool isButtonEnabled = _acceptTerms && !signUpState.isLoading;

    final formContent = SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.l,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Social Login
            SocialButton(
              label: l10n.registerWithGoogle,
              svgPath: 'assets/icons/google_logo.svg',
              backgroundColor: AppColors.background,
              textColor: AppColors.textSecondary,
              isLoading: signUpState.isLoading,
              onPressed: () => ref.read(signUpControllerProvider.notifier).signUpWithGoogle(),
            ),
            const SizedBox(height: AppSpacing.s + AppSpacing.xs),
            SocialButton(
              label: l10n.registerWithApple,
              icon: Icons.apple,
              backgroundColor: AppColors.textPrimary,
              textColor: AppColors.background,
              isLoading: signUpState.isLoading,
              onPressed: () => ref.read(signUpControllerProvider.notifier).signUpWithApple(),
            ),

            const SizedBox(height: AppSpacing.l),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                  child: Text(
                    l10n.orSplitter,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: AppSpacing.l),

            // Name
            CustomTextField(
              label: l10n.nameLabel,
              controller: _nameController,
              validator: (v) {
                if (v == null || v.isEmpty) return l10n.requiredField;
                final nameRegex = RegExp(r'^[a-zA-Z0-9\u00C0-\u00FF ]+$');
                if (!nameRegex.hasMatch(v)) return l10n.nameRequirements;
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.m),

            // Email
            CustomTextField(
              label: l10n.emailLabel,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => (v != null && EmailValidator.validate(v)) ? null : l10n.invalidEmail,
            ),
            const SizedBox(height: AppSpacing.m),

            // Password
            CustomTextField(
              label: l10n.passwordLabel,
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return l10n.requiredField;
                final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$');
                if (!passwordRegex.hasMatch(v)) return l10n.passwordRequirements;
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.m),

            // Confirm Password
            CustomTextField(
              label: l10n.confirmPasswordLabel,
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
              ),
              validator: (v) => (v == null || v.isEmpty) ? l10n.requiredField : null,
            ),
            const SizedBox(height: AppSpacing.l),

            // Legal Checkbox with Links
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppSpacing.l,
                  height: AppSpacing.l,
                  child: Checkbox(
                    value: _acceptTerms,
                    onChanged: (v) => setState(() {
                      _acceptTerms = v ?? false;
                      _acceptPrivacy = v ?? false;
                    }),
                    activeColor: AppColors.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.xs),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.s + AppSpacing.xs),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppTypography.input.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        TextSpan(text: l10n.termsAcceptPrefix),
                        TextSpan(
                          text: l10n.termsTitle,
                          style: AppTypography.input.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                          recognizer: _termsRecognizer,
                        ),
                        TextSpan(text: l10n.termsAcceptAnd),
                        TextSpan(
                          text: l10n.privacyTitle,
                          style: AppTypography.input.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                          recognizer: _privacyRecognizer,
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s + AppSpacing.xs),

            // Marketing Checkbox
            _buildSimpleCheckbox(
              value: _acceptMarketing,
              onChanged: (v) => setState(() => _acceptMarketing = v ?? false),
              text: l10n.marketingAccept,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Action Button
            PrimaryButton(
              label: l10n.createAccount,
              isLoading: signUpState.isLoading,
              onPressed: isButtonEnabled ? _submit : null,
            ),

            const SizedBox(height: AppSpacing.l),
          ],
        ),
      ),
    );

    // Layout
    return WebSplitLayout(
      leftPanel: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.brand,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_stories, size: 120, color: AppColors.background),
              const SizedBox(height: AppSpacing.l - AppSpacing.xs),
              Text(
                l10n.appName,
                style: GoogleFonts.cinzel(
                  color: AppColors.background,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.s + AppSpacing.xs),
              Text(
                l10n.joinAdventure,
                style: AppTypography.h2.copyWith(
                  color: AppColors.background.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
      rightPanel: Scaffold(
        appBar: GradientAppBar(
          title: l10n.register,
          onBack: () => context.pop(),
        ),
        backgroundColor: AppColors.background,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: formContent,
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: AppSpacing.l,
          height: AppSpacing.l,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.textPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.xs),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: AppSpacing.s + AppSpacing.xs),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Text(
              text,
              style: AppTypography.input.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

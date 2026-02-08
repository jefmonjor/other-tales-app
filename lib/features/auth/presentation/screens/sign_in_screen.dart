import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/error/auth_error_mapper.dart';
import '../../../../core/components/inputs/custom_text_field.dart';
import '../../../../core/components/buttons/primary_button.dart';
import '../providers/login_controller.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/social_button.dart';
import '../../../../core/presentation/widgets/web_split_layout.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (ref.read(loginControllerProvider).isLoading) return;

    if (_formKey.currentState!.validate()) {
      await ref.read(loginControllerProvider.notifier).login(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginControllerProvider, (previous, next) {
      if (next is AsyncError) {
        _passwordController.clear();

        final translatedError = AuthErrorMapper.getFriendlyMessage(
          next.error!,
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

    final l10n = AppLocalizations.of(context)!;
    final loginState = ref.watch(loginControllerProvider);

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
              label: l10n.googleLogin,
              svgPath: 'assets/icons/google_logo.svg',
              backgroundColor: AppColors.background,
              textColor: AppColors.textSecondary,
              isLoading: loginState.isLoading,
              onPressed: () => ref.read(loginControllerProvider.notifier).loginWithGoogle(),
            ),
            const SizedBox(height: AppSpacing.s + AppSpacing.xs),
            SocialButton(
              label: l10n.appleLogin,
              icon: Icons.apple,
              backgroundColor: AppColors.textPrimary,
              textColor: AppColors.background,
              isLoading: loginState.isLoading,
              onPressed: () => ref.read(loginControllerProvider.notifier).loginWithApple(),
            ),

            const SizedBox(height: AppSpacing.l),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                  child: Text(
                    l10n.signInEmail,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: AppSpacing.l),

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
              validator: (v) => (v == null || v.isEmpty) ? l10n.requiredField : null,
            ),
            const SizedBox(height: AppSpacing.m),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.push('/forgot-password'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  l10n.forgotPassword,
                  style: AppTypography.input.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Login Button
            PrimaryButton(
              label: l10n.login,
              isLoading: loginState.isLoading,
              onPressed: _submit,
            ),

            const SizedBox(height: AppSpacing.l),

            // Register Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${l10n.noAccount} ',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push('/register'),
                  child: Text(
                    l10n.register,
                    style: AppTypography.body.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
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
                l10n.heroSubtitle,
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
          title: l10n.signIn,
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
}

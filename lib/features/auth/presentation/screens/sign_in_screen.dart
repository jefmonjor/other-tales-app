import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/presentation/responsive_scaffold.dart';
import '../../../../core/error/auth_error_mapper.dart';
import '../providers/login_controller.dart';
import '../widgets/auth_input.dart';
import '../widgets/brand_button.dart';
import '../widgets/gradient_app_bar.dart';

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
    if (_formKey.currentState!.validate()) {
      ref.read(loginControllerProvider.notifier).login(
        _emailController.text, 
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginControllerProvider, (previous, next) {
      if (next is AsyncError) {
        // Use AuthErrorMapper
        final originalError = next.error.toString().replaceAll('Exception: ', '');
        final translatedError = AuthErrorMapper.map(
          originalError: originalError, 
          locale: Localizations.localeOf(context),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(translatedError),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating, // Floating is better in ResponsiveScaffold
          ),
        );
      } else if (next is AsyncData && !next.isLoading) {
        context.go('/projects');
      }
    });

    final l10n = AppLocalizations.of(context)!;
    final loginState = ref.watch(loginControllerProvider);

    return ResponsiveScaffold(
      appBar: GradientAppBar(
        title: l10n.signIn,
        onBack: () => context.pop(),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Match SignUp
            children: [
              // Email
              AuthInput(
                label: l10n.emailLabel,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => (v != null && EmailValidator.validate(v)) ? null : l10n.invalidEmail,
              ),
              const SizedBox(height: 16),

              // Password
              AuthInput(
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
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),

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
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B4A78),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Login Button
              BrandButton(
                label: l10n.login,
                isLoading: loginState.isLoading,
                onPressed: _submit,
              ),

              const SizedBox(height: 24),

              // Register Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${l10n.noAccount} ",
                    style: GoogleFonts.nunitoSans(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/register'),
                    child: Text(
                      l10n.register,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xFF0B4A78),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

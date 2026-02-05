import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/presentation/responsive_scaffold.dart';
import '../../../../core/error/auth_error_mapper.dart';
import '../providers/login_controller.dart';
import '../widgets/auth_input.dart';
import '../widgets/brand_button.dart';
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
    // Anti-Spam Check
    if (ref.read(loginControllerProvider).isLoading) return;

    if (_formKey.currentState!.validate()) {
      await ref.read(loginControllerProvider.notifier).login(
        _emailController.text, 
        _passwordController.text,
      );

      // --- MANUAL NAVIGATION SAFETY NET ---
      print('Login request completed. Checking session for manual navigation...');
      
      // Wait a bit to ensure session is persisted and listeners fire (if any)
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (mounted) {
        // Verify Supabase session directly
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
           print('Session confirmed. Forcing manual navigation to /projects');
           context.go('/projects'); 
        } else {
           print('No session found after login success. This is unexpected.');
        }
      }
      // ------------------------------------
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginControllerProvider, (previous, next) {
      if (next is AsyncError) {
        // Clear Password on Error
        _passwordController.clear();

        // Use AuthErrorMapper
        // Use AuthErrorMapper
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
      } else if (next is AsyncData && !next.isLoading) {
        context.go('/projects');
      }
    });

    final l10n = AppLocalizations.of(context)!;
    final loginState = ref.watch(loginControllerProvider);

    // Form Content
    final formContent = SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              // Social Login
              SocialButton(
                label: l10n.googleLogin, 
                svgPath: 'assets/icons/google_logo.svg',
                backgroundColor: Colors.white,
                textColor: const Color(0xFF757575),
                isLoading: loginState.isLoading,
                onPressed: () => ref.read(loginControllerProvider.notifier).loginWithGoogle(),
              ),
              const SizedBox(height: 12),
              SocialButton(
                label: l10n.appleLogin, 
                icon: Icons.apple,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                isLoading: loginState.isLoading,
                onPressed: () => ref.read(loginControllerProvider.notifier).loginWithApple(),
              ),
              
              SizedBox(height: AppSpacing.l),
              Row(
                children: [
                   const Expanded(child: Divider()),
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.m),
                    child: Text(l10n.signInEmail, style: const TextStyle(color: Colors.grey)), 
                   ),
                   const Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: AppSpacing.l),

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
                validator: (v) => (v == null || v.isEmpty) ? l10n.requiredField : null,
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
    );

    // Layout Logic
    return WebSplitLayout(
      leftPanel: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)], 
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_stories, size: 120, color: Colors.white),
              const SizedBox(height: 20),
              Text("Other Tales", 
                   style: GoogleFonts.cinzel(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(l10n.heroSubtitle,
                   style: GoogleFonts.nunitoSans(color: Colors.white70, fontSize: 20)),
            ],
          ),
        ),
      ), 
      rightPanel: Scaffold(
        appBar: GradientAppBar(
          title: l10n.signIn,
          onBack: () => context.pop(),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450), // Consistent width
            child: formContent,
          ),
        ),
      ),
    );
  }
}

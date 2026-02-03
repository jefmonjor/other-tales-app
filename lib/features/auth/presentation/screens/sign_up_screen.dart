import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/sign_up_controller.dart';
import '../widgets/auth_input.dart';
import '../widgets/brand_button.dart';
import '../widgets/gradient_app_bar.dart';

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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.mustAcceptTerms),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Las contraseñas no coinciden"), // TODO: Localize or use key if exists
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      await ref.read(signUpControllerProvider.notifier).register(
        _nameController.text, 
        _emailController.text, 
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen for side effects
    ref.listen(signUpControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppColors.error,
          ),
        );
      } else if (next is AsyncData && !next.isLoading) {
         // Assuming auto-login is handled or navigating to projects
         // Wait, register logic in repo might have auto-login?
         // In AuthRepositoryImpl we implemented: `await _supabase.auth.signUp(...)`
         // If signUp succeeds (email confirm off), it signs in.
         context.go('/projects'); 
      }
    });

    final l10n = AppLocalizations.of(context)!;
    final signUpState = ref.watch(signUpControllerProvider);
    final bool isButtonEnabled = _acceptTerms && !signUpState.isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          GradientAppBar(
            title: l10n.register, 
            onBack: () => context.pop(),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    AuthInput(
                      label: l10n.nameLabel,
                      controller: _nameController,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        final nameRegex = RegExp(r'^[a-zA-Z0-9 ]+$');
                        if (!nameRegex.hasMatch(v)) return l10n.nameRequirements;
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

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
                      validator: (v) {
                         if (v == null || v.isEmpty) return 'Required';
                         final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$');
                         if (!passwordRegex.hasMatch(v)) return l10n.passwordRequirements;
                         return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Repeat Password
                    AuthInput(
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
                      validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 24),

                    // Checkboxes
                    _buildCheckbox(
                      value: _acceptMarketing,
                      onChanged: (v) => setState(() => _acceptMarketing = v ?? false),
                      text: l10n.marketingAccept,
                    ),
                    const SizedBox(height: 12),
                    _buildCheckbox(
                      value: _acceptTerms,
                      onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                      text: l10n.termsAccept,
                      isRequired: true,
                    ),
                    const SizedBox(height: 32),

                    // Action Button
                    BrandButton(
                      label: l10n.createAccount,
                      isLoading: signUpState.isLoading,
                      onPressed: isButtonEnabled ? _submit : null,
                    ),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String text,
    bool isRequired = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF232323),
            checkColor: Colors.white,
            side: const BorderSide(color: Color(0xFF232323), width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Text(
              text,
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF060606),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

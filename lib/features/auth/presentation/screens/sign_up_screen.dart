import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/constants/legal_constants.dart';
import '../../../../core/presentation/responsive_scaffold.dart';
import '../../../../core/presentation/universal_modal.dart';
import '../../../../core/error/auth_error_mapper.dart';
import '../providers/sign_up_controller.dart';
import '../widgets/auth_input.dart';
import '../widgets/brand_button.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/social_button.dart';

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
  bool _acceptPrivacy = false; // Separate privacy check logic if needed, but UI usually groups them.

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
          content: Text("Debes aceptar los términos y privacidad"), // Localize
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Las contraseñas no coinciden"), // Localize
            backgroundColor: AppColors.error,
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
        privacyAccepted: _acceptTerms, // Grouped in UI
      );
    }
  }

  void _showTerms(BuildContext context) {
    UniversalModal.showPlatformModal(
      context, 
      title: "Términos y Condiciones", 
      content: const Text(LegalConstants.termsAndConditions),
    );
  }

  void _showPrivacy(BuildContext context) {
    UniversalModal.showPlatformModal(
      context, 
      title: "Política de Privacidad", 
      content: const Text(LegalConstants.privacyPolicy),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Listen for side effects
    ref.listen(signUpControllerProvider, (previous, next) {
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
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (next is AsyncData && !next.isLoading) {
         context.go('/projects'); 
      }
    });

    final signUpState = ref.watch(signUpControllerProvider);
    final bool isButtonEnabled = _acceptTerms && !signUpState.isLoading;

    return ResponsiveScaffold(
      appBar: GradientAppBar(
        title: l10n.register, 
        onBack: () => context.pop(),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch for button
            children: [
              // Social Login
              SocialButton(
                label: "Regístrate con Google", // Localize later
                svgPath: 'assets/icons/google_logo.svg',
                backgroundColor: Colors.white,
                textColor: const Color(0xFF757575),
                onPressed: () => ref.read(signUpControllerProvider.notifier).signUpWithGoogle(),
              ),
              const SizedBox(height: 12),
              SocialButton(
                label: "Regístrate con Apple", // Localize later
                icon: Icons.apple,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                onPressed: () => ref.read(signUpControllerProvider.notifier).signUpWithApple(),
              ),
              
              const SizedBox(height: 24),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("o", style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
              
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

              // Legal Checkbox with Links
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _acceptTerms,
                      onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                      activeColor: const Color(0xFF232323),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          color: const Color(0xFF060606),
                        ),
                        children: [
                          const TextSpan(text: "He leído y acepto los "), // Localize if needed
                          TextSpan(
                            text: "Términos y Condiciones",
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, 
                              color: Theme.of(context).primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () => _showTerms(context),
                          ),
                          const TextSpan(text: " y la "),
                          TextSpan(
                            text: "Política de Privacidad",
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, 
                              color: Theme.of(context).primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () => _showPrivacy(context),
                          ),
                          const TextSpan(text: "."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Marketing Checkbox
              _buildSimpleCheckbox(
                value: _acceptMarketing,
                onChanged: (v) => setState(() => _acceptMarketing = v ?? false),
                text: l10n.marketingAccept, // "Acepto recibir novedades"
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
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF232323),
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
                fontSize: 14,
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_input.dart';
import '../widgets/brand_button.dart';
import '../widgets/gradient_app_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // TODO: Implement Supabase password reset logic
      await Future.delayed(const Duration(seconds: 1)); // Mock
      
      setState(() => _isLoading = false);
      
      if (mounted) {
        context.go('/password-sent');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          GradientAppBar(
            title: l10n.forgotPasswordTitle,
            onBack: () => context.pop(),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.forgotPasswordSubtitle,
                      style: const TextStyle(
                        fontFamily: 'Nunito Sans',
                        fontSize: 16,
                        color: Color(0xFF949494),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email
                    AuthInput(
                      label: l10n.emailLabel,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => (v == null || !v.contains('@')) ? 'Invalid email' : null,
                    ),

                    const SizedBox(height: 32),

                    BrandButton(
                      label: l10n.recoverButton,
                      isLoading: _isLoading,
                      onPressed: _submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

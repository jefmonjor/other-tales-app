import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/presentation/widgets/web_split_layout.dart';
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

    // Form Content
    final formContent = SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.forgotPasswordSubtitle,
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                color: const Color(0xFF949494),
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
              Text("Recupera tu acceso",
                   style: GoogleFonts.nunitoSans(color: Colors.white70, fontSize: 20)),
            ],
          ),
        ),
      ),
      rightPanel: Scaffold(
        appBar: GradientAppBar(
          title: l10n.forgotPasswordTitle,
          onBack: () => context.pop(),
        ),
        backgroundColor: Colors.white,
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

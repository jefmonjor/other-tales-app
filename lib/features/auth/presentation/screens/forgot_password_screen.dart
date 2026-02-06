import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/components/buttons/primary_button.dart';
import '../../../../core/components/inputs/custom_text_field.dart';
import '../../../../core/error/auth_error_mapper.dart';
import '../../../../core/presentation/widgets/web_split_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../widgets/gradient_app_bar.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
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

      final result = await ref
          .read(authRepositoryProvider)
          .resetPassword(_emailController.text.trim());

      if (!mounted) return;

      setState(() => _isLoading = false);

      result.fold(
        (failure) {
          final locale = Localizations.localeOf(context).languageCode;
          final message =
              AuthErrorMapper.getFriendlyMessage(failure, locale);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
            ),
          );
        },
        (_) {
          context.go('/password-sent');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Form Content
    final formContent = SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.l,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.forgotPasswordSubtitle,
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.l),

            // Email
            CustomTextField(
              label: l10n.emailLabel,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) =>
                  (v == null || !v.contains('@')) ? l10n.invalidEmail : null,
            ),

            const SizedBox(height: AppSpacing.xl),

            PrimaryButton(
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
          gradient: AppGradients.brand,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_stories, size: 120, color: Colors.white),
              const SizedBox(height: AppSpacing.m + AppSpacing.xs),
              Text(
                l10n.appName,
                style: GoogleFonts.cinzel(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.s + AppSpacing.xs),
              Text(
                l10n.recoverAccess,
                style: AppTypography.h2.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
      rightPanel: Scaffold(
        appBar: GradientAppBar(
          title: l10n.forgotPasswordTitle,
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

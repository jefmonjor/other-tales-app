import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/components/buttons/primary_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/gradient_app_bar.dart';

class PasswordSentScreen extends StatelessWidget {
  const PasswordSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Gradient Header
          const GradientAppBar(
            title: "",
            showBackButton: false,
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSpacing.xl * 2),

                  // Success Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.email_outlined,
                      size: 40,
                      color: AppColors.success,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  Text(
                    l10n.emailSentTitle,
                    style: AppTypography.h1,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppSpacing.m),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                    child: Text(
                      l10n.emailSentMessage,
                      style: AppTypography.body
                          .copyWith(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl * 2),

                  PrimaryButton(
                    label: l10n.backToLogin,
                    onPressed: () => context.go('/login'),
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

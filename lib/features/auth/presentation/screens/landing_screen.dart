import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/components/buttons/primary_button.dart';
import '../widgets/social_button.dart';
import '../../../../core/presentation/widgets/web_split_layout.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.auto_stories_rounded, size: 80, color: AppColors.primary),
          const SizedBox(height: AppSpacing.l),
          Text(
            l10n.appName,
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            l10n.heroSubtitle,
            textAlign: TextAlign.center,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 48),

          SocialButton(
            label: l10n.appleLogin,
            icon: Icons.apple,
            backgroundColor: AppColors.textPrimary,
            textColor: AppColors.background,
            onPressed: () => context.push('/login'),
          ),
          const SizedBox(height: AppSpacing.s + AppSpacing.xs),
          SocialButton(
            label: l10n.googleLogin,
            svgPath: 'assets/icons/google_logo.svg',
            backgroundColor: AppColors.background,
            textColor: AppColors.textSecondary,
            onPressed: () => context.go('/login'),
          ),

          const SizedBox(height: AppSpacing.l),
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                child: Text(
                  l10n.orSplitter.toUpperCase(),
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: AppSpacing.l),

          PrimaryButton(
            label: l10n.signInEmail,
            onPressed: () => context.push('/login'),
          ),

          const SizedBox(height: AppSpacing.xl),

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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final heroPanel = Container(
      decoration: const BoxDecoration(
        gradient: AppGradients.brand,
      ),
      child: Center(
        child: Text(
          l10n.welcomeHero,
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            color: AppColors.background,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return WebSplitLayout(
      leftFlex: 5,
      rightFlex: 5,
      leftPanel: heroPanel,
      rightPanel: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}

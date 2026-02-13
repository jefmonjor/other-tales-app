import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:other_tales_app/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../auth/presentation/providers/auth_state_provider.dart';
import '../../../auth/presentation/providers/profile_provider.dart';

class ProjectSearchHeader extends ConsumerWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const ProjectSearchHeader({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + AppSpacing.m,
        bottom: AppSpacing.l,
      ),
      decoration: const BoxDecoration(
        gradient: AppGradients.brand,
      ),
      child: Column(
        children: [
          // App Bar Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.myProjectsTitle,
                  style: AppTypography.h1.copyWith(color: Colors.white),
                ),
                _ProjectProfileMenu(ref: ref, l10n: l10n),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.l),

          // Search Pill
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceInput,
                borderRadius: BorderRadius.circular(42), // Pill shape
              ),
              child: TextField(
                controller: searchController,
                style: AppTypography.input,
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: l10n.searchProjects,
                  hintStyle: AppTypography.input.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectProfileMenu extends StatelessWidget {
  final WidgetRef ref;
  final AppLocalizations l10n;

  const _ProjectProfileMenu({required this.ref, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 48),
      onSelected: (value) {
        if (value == 'logout') {
          _showLogoutConfirmation(context);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              const Icon(Icons.logout, size: 20),
              const SizedBox(width: AppSpacing.s),
              Text(l10n.logout),
            ],
          ),
        ),
      ],
      child: _ProfileAvatar(ref: ref),
    );
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(authStateProvider.notifier).logout();
    }
  }
}

class _ProfileAvatar extends ConsumerWidget {
  final WidgetRef ref;

  const _ProfileAvatar({required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentProfileProvider);
    return profileAsync.when(
      data: (profile) {
        if (profile.avatarUrl != null && profile.avatarUrl!.startsWith('http')) {
          return CircleAvatar(
            backgroundColor: Colors.white24,
            backgroundImage: NetworkImage(profile.avatarUrl!),
            onBackgroundImageError: (_, __) {},
            child: null,
          );
        }
        return CircleAvatar(
          backgroundColor: Colors.white24,
          child: Text(
            profile.initials,
            style: AppTypography.button.copyWith(color: Colors.white),
          ),
        );
      },
      loading: () => const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(Icons.person, color: Colors.white),
      ),
      error: (_, __) => const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(Icons.person, color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../l10n/generated/app_localizations.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../auth/presentation/widgets/gradient_app_bar.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/project_bottom_nav.dart';

// Since we might not have the project title if coming from a deep link,
// we could fetch it. For now, we'll rely on the passed title or a placeholder.
// In a real scenario, we'd watch a provider: ref.watch(projectDetailsProvider(projectId))

class ProjectDashboardScreen extends ConsumerWidget {
  final String projectId;
  final String? projectTitle;

  const ProjectDashboardScreen({
    super.key,
    required this.projectId,
    this.projectTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: GradientAppBar(
        title: projectTitle ?? l10n.projectDefaultTitle, // TODO: Fetch title if null
        showBackButton: true,
        onBack: () => context.go('/projects'), // Go back to project list
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 columns
                mainAxisSpacing: AppSpacing.m,
                crossAxisSpacing: AppSpacing.m,
                childAspectRatio: 1.0, // Square cards
                children: [
                   DashboardCard(
                    label: l10n.dashboardCharacters,
                    icon: Icons.person,
                    onTap: () => context.go('/projects/$projectId/characters'),
                  ),
                  DashboardCard(
                    label: l10n.dashboardStory,
                    icon: Icons.book,
                    onTap: () => context.go('/projects/$projectId/stories'),
                  ),
                  DashboardCard(
                    label: l10n.dashboardIdeas,
                    icon: Icons.lightbulb,
                    onTap: () => context.go('/projects/$projectId/ideas'),
                  ),
                  DashboardCard(
                    label: l10n.dashboardImages,
                    icon: Icons.image,
                    onTap: () => context.go('/projects/$projectId/images'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProjectBottomNav(
        currentIndex: 0, // 'Projects' tab active
        onTap: (index) {
           if (index == 0) {
             context.go('/projects');
           }
           // TODO: Implement other tabs navigation (Goals, Settings)
        },
      ),
    );
  }
}

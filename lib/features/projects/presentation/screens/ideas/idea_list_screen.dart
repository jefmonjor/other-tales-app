import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../auth/presentation/widgets/gradient_app_bar.dart';
import '../../providers/ideas_provider.dart';

class IdeaListScreen extends ConsumerWidget {
  final String projectId;

  const IdeaListScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasAsync = ref.watch(ideasProvider(projectId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: GradientAppBar(
        title: l10n.dashboardIdeas,
        showBackButton: true,
      ),
      body: ideasAsync.when(
        data: (ideas) {
          if (ideas.isEmpty) {
            return Center(child: Text(l10n.noIdeas));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.m),
            itemCount: ideas.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.s),
            itemBuilder: (context, index) {
              final idea = ideas[index];
              return GestureDetector(
                onTap: () => context.push('/projects/$projectId/ideas/${idea.id}'),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9), // Very light gray
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6), // Squiracle
                        ),
                        child: const Icon(Icons.lightbulb_outline, size: 18, color: AppColors.primary),
                      ),
                      const SizedBox(width: AppSpacing.m),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              idea.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            if (idea.content != null && idea.content!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  idea.content!,
                                  style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/projects/$projectId/ideas/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

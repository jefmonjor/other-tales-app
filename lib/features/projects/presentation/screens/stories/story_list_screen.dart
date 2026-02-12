import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_gradients.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../auth/presentation/widgets/gradient_app_bar.dart';
import '../../providers/stories_provider.dart';

class StoryListScreen extends ConsumerWidget {
  final String projectId;

  const StoryListScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storiesAsync = ref.watch(storiesProvider(projectId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: GradientAppBar(
        title: l10n.dashboardStory,
        showBackButton: true,
      ),
      body: storiesAsync.when(
        data: (stories) {
           if (stories.isEmpty) {
            return Center(child: Text(l10n.noStories));
          }
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.m),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // Horizontal Cards in a vertical list, or keep grid? Prototyping as list of cards for better text fit.
                    childAspectRatio: 2.5, // Wide card
                    crossAxisSpacing: AppSpacing.m,
                    mainAxisSpacing: AppSpacing.m,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final story = stories[index];
                      return GestureDetector(
                        onTap: () => context.push('/projects/$projectId/stories/${story.id}'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Image section
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(5)),
                                  image: story.imageUrl != null
                                      ? DecorationImage(
                                          image: NetworkImage(story.imageUrl!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  gradient: story.imageUrl == null ? AppGradients.brand : null,
                                ),
                                child: story.imageUrl == null
                                    ? const Center(child: Icon(Icons.book, color: Colors.white))
                                    : null,
                              ),
                              // Content section
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(AppSpacing.m),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        story.title,
                                        style: AppTypography.h3.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        story.synopsis ?? l10n.noSynopsis,
                                        style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (story.theme != null && story.theme!.isNotEmpty) ...[
                                        const SizedBox(height: AppSpacing.s),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                                          ),
                                          child: Text(
                                            story.theme!,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: stories.length,
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/projects/$projectId/stories/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

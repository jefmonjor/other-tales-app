import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_gradients.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../auth/presentation/widgets/gradient_app_bar.dart';
import '../../providers/characters_provider.dart';

class CharacterListScreen extends ConsumerWidget {
  final String projectId;

  const CharacterListScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersAsync = ref.watch(charactersProvider(projectId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: GradientAppBar(
        title: l10n.dashboardCharacters,
        showBackButton: true,
      ),
      body: charactersAsync.when(
        data: (characters) {
          if (characters.isEmpty) {
            return Center(child: Text(l10n.noCharacters));
          }
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.m),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75, // 3:4 aspect ratio
                    crossAxisSpacing: AppSpacing.m,
                    mainAxisSpacing: AppSpacing.m,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final character = characters[index];
                      return GestureDetector(
                        onTap: () => context.push('/projects/$projectId/characters/${character.id}'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF0B4A78).withValues(alpha: 0.3), // Subtle brand border
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(7)), // Match parent - 1 for border
                                    image: character.imageUrl != null
                                        ? DecorationImage(
                                            image: NetworkImage(character.imageUrl!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                    gradient: character.imageUrl == null ? AppGradients.brand : null,
                                  ),
                                  child: character.imageUrl == null
                                      ? Center(
                                          child: Text(
                                            character.name.characters.take(2).toString().toUpperCase(),
                                            style: AppTypography.h3.copyWith(color: Colors.white),
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(AppSpacing.s),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        character.name,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColors.textPrimary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (character.role != null && character.role!.isNotEmpty)
                                        Text(
                                          character.role!,
                                          style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: characters.length,
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
        onPressed: () => context.push('/projects/$projectId/characters/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

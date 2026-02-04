import 'package:flutter/material.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/components/navigation/gradient_bottom_nav.dart';
import '../widgets/project_card.dart';
import '../widgets/create_project_modal.dart';
import '../widgets/project_list_skeleton.dart';
import '../providers/projects_providers.dart';

class ProjectsScreen extends ConsumerStatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ConsumerState<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends ConsumerState<ProjectsScreen> {
  int _currentIndex = 2; // Home Default

  @override
  Widget build(BuildContext context) {
    final projectsAsync = ref.watch(projectsListProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Custom Gradient Header with Search
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + AppSpacing.m,
              bottom: AppSpacing.l
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
                      const CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.person, color: Colors.white),
                      )
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
                      style: AppTypography.input,
                      decoration: InputDecoration(
                        hintText: l10n.searchProjects,
                        hintStyle: AppTypography.input.copyWith(color: AppColors.textSecondary),
                        prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Content Grid
          Expanded(
            child: projectsAsync.when(
              loading: () => const ProjectListSkeleton(),
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.l),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: AppSpacing.m),
                      Text(
                        err.toString(),
                        style: AppTypography.body.copyWith(color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              data: (projects) {
                // Empty state
                if (projects.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book_outlined,
                            size: 64,
                            color: AppColors.textSecondary.withOpacity(0.5),
                          ),
                          const SizedBox(height: AppSpacing.m),
                          Text(
                            l10n.noProjectsYet,
                            style: AppTypography.body.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.l),
                          ElevatedButton.icon(
                            onPressed: () {
                              CreateProjectModal.show(context);
                            },
                            icon: const Icon(Icons.add),
                            label: Text(l10n.createProject),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                
                // Projects grid
                return GridView.builder(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220, // Adaptive card width
                    childAspectRatio: 0.65, // Adjust for book cover ratio
                    crossAxisSpacing: AppSpacing.m,
                    mainAxisSpacing: AppSpacing.m,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return ProjectCard(
                      title: project.title,
                      synopsis: project.synopsis,
                      coverUrl: project.coverUrl,
                      genre: project.genre,
                      currentWordCount: project.currentWordCount,
                      onTap: () {
                        context.push('/editor'); // Navigate to editor on tap for now
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: GradientBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: projectsAsync.valueOrNull?.isNotEmpty == true 
          ? FloatingActionButton(
              onPressed: () => CreateProjectModal.show(context),
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}

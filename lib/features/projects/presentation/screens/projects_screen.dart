import 'package:flutter/material.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/components/navigation/gradient_bottom_nav.dart';
import '../../../auth/presentation/providers/auth_state_provider.dart';
import '../../../auth/presentation/providers/profile_provider.dart';
import '../../domain/models/project.dart';
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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildProfileAvatar() {
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

  Widget _buildProfileMenu(AppLocalizations l10n) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 48),
      onSelected: (value) {
        if (value == 'logout') {
          _showLogoutConfirmation(l10n);
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
      child: _buildProfileAvatar(),
    );
  }

  Future<void> _showLogoutConfirmation(AppLocalizations l10n) async {
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

  void _showProjectActions(Project project) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(l10n.editProject),
              onTap: () {
                Navigator.of(context).pop();
                _showEditProjectDialog(project);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.error),
              title: Text(
                l10n.deleteProject,
                style: const TextStyle(color: AppColors.error),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _showDeleteConfirmation(project);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProjectDialog(Project project) {
    final l10n = AppLocalizations.of(context)!;
    final titleController = TextEditingController(text: project.title);
    final synopsisController =
        TextEditingController(text: project.synopsis ?? '');
    final genreController = TextEditingController(text: project.genre ?? '');
    final wordCountController =
        TextEditingController(text: project.targetWordCount.toString());

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.editProject),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: l10n.titleLabel),
              ),
              const SizedBox(height: AppSpacing.m),
              TextField(
                controller: synopsisController,
                decoration: InputDecoration(labelText: l10n.synopsisLabel),
                maxLines: 3,
              ),
              const SizedBox(height: AppSpacing.m),
              TextField(
                controller: genreController,
                decoration: InputDecoration(labelText: l10n.genreLabel),
              ),
              const SizedBox(height: AppSpacing.m),
              TextField(
                controller: wordCountController,
                decoration:
                    InputDecoration(labelText: l10n.targetWordCountLabel),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () async {
              final title = titleController.text.trim();
              if (title.isEmpty) return;

              final wordCount =
                  int.tryParse(wordCountController.text.trim());

              await ref.read(updateProjectProvider.notifier).editProject(
                    id: project.id,
                    title: title,
                    synopsis: synopsisController.text.trim().isNotEmpty
                        ? synopsisController.text.trim()
                        : null,
                    genre: genreController.text.trim().isNotEmpty
                        ? genreController.text.trim()
                        : null,
                    targetWordCount: wordCount,
                  );

              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.projectUpdatedSuccess)),
                );
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(Project project) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteProject),
        content: Text(l10n.deleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(deleteProjectProvider.notifier).delete(project.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.projectDeletedSuccess)),
        );
      }
    }
  }

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
                      _buildProfileMenu(l10n),
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
                      controller: _searchController,
                      style: AppTypography.input,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.trim().toLowerCase();
                        });
                      },
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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
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
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: AppSpacing.m),
                      Text(
                        err.toString(),
                        style: AppTypography.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              data: (projects) {
                // Filter projects by search query
                final filteredProjects = _searchQuery.isEmpty
                    ? projects
                    : projects
                        .where((p) => p.title
                            .toLowerCase()
                            .contains(_searchQuery))
                        .toList();

                // Empty state (no projects at all)
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
                            color: AppColors.textSecondary
                                .withValues(alpha: 0.5),
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

                // No results for search query
                if (filteredProjects.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: AppColors.textSecondary
                                .withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: AppSpacing.m),
                          Text(
                            l10n.searchProjects,
                            style: AppTypography.body.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Projects grid
                return GridView.builder(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220, // Adaptive card width
                    childAspectRatio: 0.65, // Adjust for book cover ratio
                    crossAxisSpacing: AppSpacing.m,
                    mainAxisSpacing: AppSpacing.m,
                  ),
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    final project = filteredProjects[index];
                    return ProjectCard(
                      title: project.title,
                      synopsis: project.synopsis,
                      coverUrl: project.coverUrl,
                      genre: project.genre,
                      currentWordCount: project.currentWordCount,
                      onTap: () {
                        context.push('/editor/${project.id}');
                      },
                      onLongPress: () {
                        _showProjectActions(project);
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
      floatingActionButton:
          projectsAsync.valueOrNull?.isNotEmpty == true
              ? FloatingActionButton(
                  onPressed: () => CreateProjectModal.show(context),
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : null,
    );
  }
}

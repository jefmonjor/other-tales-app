import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';

import '../../../../core/components/navigation/gradient_bottom_nav.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/projects_providers.dart';
import '../widgets/create_project_modal.dart';
import '../widgets/project_empty_state.dart';
import '../widgets/project_grid_item.dart';
import '../widgets/project_list_skeleton.dart';
import '../widgets/project_search_header.dart';

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

  @override
  Widget build(BuildContext context) {
    final projectsAsync = ref.watch(projectsListProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // 1. Header (Search & Profile)
          ProjectSearchHeader(
            searchController: _searchController,
            onSearchChanged: (value) {
              setState(() {
                _searchQuery = value.trim().toLowerCase();
              });
            },
          ),

          // 2. Main Content
          Expanded(
            child: projectsAsync.when(
              loading: () => const ProjectListSkeleton(),
              error: (err, stack) => Center(
                child: ProjectEmptyState(
                  message: err.toString(),
                  icon: Icons.error_outline,
                ),
              ),
              data: (projects) {
                // Filter logic
                final filteredProjects = _searchQuery.isEmpty
                    ? projects
                    : projects
                        .where((p) =>
                            p.title.toLowerCase().contains(_searchQuery))
                        .toList();

                // Case A: No projects at all
                if (projects.isEmpty) {
                  return ProjectEmptyState(
                    message: l10n.noProjectsYet,
                    icon: Icons.book_outlined,
                    actionLabel: l10n.createProject,
                    onAction: () => CreateProjectModal.show(context),
                  );
                }

                // Case B: Search yielded no results
                if (filteredProjects.isEmpty) {
                  return ProjectEmptyState(
                    message: l10n.searchProjects, // "No se encontraron..."
                    icon: Icons.search_off,
                  );
                }

                // Case C: Grid
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    return ProjectGridItem(project: filteredProjects[index]);
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


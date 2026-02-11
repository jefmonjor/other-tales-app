import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/models/project.dart';
import '../providers/projects_providers.dart';
import 'project_card.dart';

class ProjectGridItem extends ConsumerWidget {
  final Project project;

  const ProjectGridItem({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        _showProjectActions(context, ref, project);
      },
    );
  }

  void _showProjectActions(BuildContext context, WidgetRef ref, Project project) {
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
                _showEditProjectDialog(context, ref, project);
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
                _showDeleteConfirmation(context, ref, project);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProjectDialog(
      BuildContext context, WidgetRef ref, Project project) {
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
          Consumer(
            builder: (context, ref, _) {
              return TextButton(
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
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.projectUpdatedSuccess)),
                    );
                  }
                },
                child: Text(l10n.save),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, Project project) async {
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
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.projectDeletedSuccess)),
        );
      }
    }
  }
}

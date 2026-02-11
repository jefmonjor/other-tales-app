import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/components/inputs/custom_text_field.dart';
import '../../../../core/components/buttons/primary_button.dart';
import '../providers/projects_providers.dart';

class CreateProjectModal extends ConsumerStatefulWidget {
  const CreateProjectModal({super.key});

  static void show(BuildContext context) {
    // Adaptive dialog/bottom sheet
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 600;

    if (isDesktop) {
      showDialog(
        context: context,
        builder: (context) => const Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: 500,
            child: CreateProjectModal(),
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const CreateProjectModal(),
        ),
      );
    }
  }

  @override
  ConsumerState<CreateProjectModal> createState() => _CreateProjectModalState();
}

class _CreateProjectModalState extends ConsumerState<CreateProjectModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _wordCountController = TextEditingController(text: '50000');
  final _genreController = TextEditingController();
  String? _selectedGenre;



  @override
  void dispose() {
    _titleController.dispose();
    _synopsisController.dispose();
    _wordCountController.dispose();
    _genreController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final l10n = AppLocalizations.of(context)!;
      final navigator = Navigator.of(context); // Capture navigator before async
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      try {
        await ref.read(createProjectProvider.notifier).create(
          title: _titleController.text,
          synopsis: _synopsisController.text.isNotEmpty ? _synopsisController.text : null,
          genre: _selectedGenre,
          targetWordCount: int.tryParse(_wordCountController.text),
        );

        final state = ref.read(createProjectProvider);

        if (state.hasError) {
          throw state.error!;
        }

        // Success
        navigator.pop();
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(l10n.projectCreatedSuccess),
            backgroundColor: AppColors.success,
          ),
        );
      } catch (e) {
        // Error handling
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isLoading = ref.watch(createProjectProvider).isLoading;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.newProjectTitle,
                    style: AppTypography.h3,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.m),

              // Title Field — backend limit: 255 chars
              CustomTextField(
                label: l10n.titleLabel,
                hint: l10n.enterTitle,
                controller: _titleController,
                maxLength: 255,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.enterTitle;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.m),

              // Genre Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.genreLabel,
                    style: AppTypography.input.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedGenre,
                    decoration: InputDecoration(
                      hintText: l10n.enterGenre,
                      hintStyle: AppTypography.input.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      filled: true,
                      fillColor: AppColors.surfaceInput,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.m,
                        vertical: AppSpacing.m + 2,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: [
                      MapEntry('Fantasy', l10n.genreFantasy),
                      MapEntry('Science Fiction', l10n.genreSciFi),
                      MapEntry('Romance', l10n.genreRomance),
                      MapEntry('Mystery', l10n.genreMystery),
                      MapEntry('Thriller', l10n.genreThriller),
                      MapEntry('Horror', l10n.genreHorror),
                      MapEntry('Historical', l10n.genreHistorical),
                      MapEntry('Literary Fiction', l10n.genreLiteraryFiction),
                      MapEntry('Adventure', l10n.genreAdventure),
                      MapEntry('Drama', l10n.genreDrama),
                      MapEntry('Poetry', l10n.genrePoetry),
                      MapEntry('Non-Fiction', l10n.genreNonFiction),
                    ].map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value, style: AppTypography.input),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGenre = value;
                      });
                    },
                    // Genre is optional per backend contract
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.m),

              // Synopsis Field — backend limit: 2000 chars
              CustomTextField(
                label: l10n.synopsisLabel,
                hint: l10n.enterSynopsis,
                controller: _synopsisController,
                maxLength: 2000,
              ),
              const SizedBox(height: AppSpacing.m),

              // Word Count Field — backend requires min 1
              CustomTextField(
                label: l10n.targetWordCountLabel,
                controller: _wordCountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return l10n.invalidNumber;
                  }
                  final parsed = int.parse(value);
                  if (parsed < 1) {
                    return l10n.errorProjectInvalidWordCount;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.xl),

              // Actions
              PrimaryButton(
                label: l10n.createButton,
                isLoading: isLoading,
                onPressed: _submit,
              ),
              const SizedBox(height: AppSpacing.s),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  l10n.cancelButton,
                  style: AppTypography.button.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

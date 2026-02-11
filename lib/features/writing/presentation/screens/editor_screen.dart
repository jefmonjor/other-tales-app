import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../controllers/chapter_controller.dart';
import '../../domain/entities/chapter.dart';
import '../../../../core/error/failure.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/error/error_message_helper.dart';

class EditorScreen extends ConsumerStatefulWidget {
  final String projectId;

  const EditorScreen({
    super.key,
    required this.projectId,
  });

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _contentController;
  late TextEditingController _titleController;
  late FocusNode _focusNode;
  String? _currentChapterId;
  String? _titleError;
  int _selectedChapterIndex = 0;
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
    _titleController = TextEditingController();
    _focusNode = FocusNode();

    _contentController.addListener(_markDirty);
    _titleController.addListener(_markDirty);

    // Initial Load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
      _focusNode.requestFocus();
    });
  }

  void _markDirty() {
    if (!_hasUnsavedChanges) {
      _hasUnsavedChanges = true;
    }
  }

  Future<void> _loadInitialData() async {
    final defaultTitle = AppLocalizations.of(context)!.defaultChapterTitle;
    try {
      final chapters = await ref.read(chaptersProvider(widget.projectId).future);
      if (chapters.isNotEmpty) {
        _loadChapterIntoEditor(chapters.first, 0);
      } else {
        _titleController.text = defaultTitle;
      }
    } catch (e) {
      debugPrint("Error loading chapters: $e");
    }
  }

  void _loadChapterIntoEditor(Chapter chapter, int index) {
    setState(() {
      _currentChapterId = chapter.id;
      _selectedChapterIndex = index;
      _contentController.removeListener(_markDirty);
      _titleController.removeListener(_markDirty);
      _contentController.text = chapter.content;
      _titleController.text = chapter.title;
      _hasUnsavedChanges = false;
      _titleError = null;
      _contentController.addListener(_markDirty);
      _titleController.addListener(_markDirty);
    });
  }

  @override
  void dispose() {
    _contentController.removeListener(_markDirty);
    _titleController.removeListener(_markDirty);
    _contentController.dispose();
    _titleController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();
    setState(() => _titleError = null); // Clear previous errors

    await ref.read(chapterControllerProvider.notifier).saveChapter(
      projectId: widget.projectId,
      chapterId: _currentChapterId,
      title: _titleController.text,
      content: _contentController.text,
    );

    final state = ref.read(chapterControllerProvider);

    if (state.hasError) {
      if (mounted) {
        final error = state.error;
        String errorMessage = error.toString();

        if (error is Failure) {
          if (error is ServerFailure) {
            // 1. Check for Field Errors (RFC 7807)
            if (error.fieldErrors != null && error.fieldErrors!.isNotEmpty) {
              // Manually map known fields
              for (final err in error.fieldErrors!) {
                if (err is Map) {
                  final field = err['field'];
                  final code = err['code'];

                  if (field == 'title') {
                    setState(() => _titleError = ErrorMessageHelper.getFieldErrorMessage(code, context));
                  }
                }
              }
              errorMessage = AppLocalizations.of(context)!.errorValidationFailed;
            }
            // 2. Check for General Error Code
            else if (error.errorType != null) {
              errorMessage = ErrorMessageHelper.getErrorMessage(error.errorType, context);
            } else {
              errorMessage = error.message;
            }
          } else {
            errorMessage = error.message;
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } else if (!state.isLoading) {
      // Success -- capture the returned chapter ID for subsequent saves
      final savedChapter = state.value;
      if (savedChapter != null && _currentChapterId == null) {
        _currentChapterId = savedChapter.id;
      }
      _hasUnsavedChanges = false;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.saveSuccess),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }

  Future<void> _switchToChapter(Chapter chapter, int index) async {
    if (index == _selectedChapterIndex && _currentChapterId == chapter.id) {
      // Already on this chapter, just close the drawer
      Navigator.of(context).pop();
      return;
    }

    // Save current chapter first if there are unsaved changes
    if (_hasUnsavedChanges && _currentChapterId != null) {
      await ref.read(chapterControllerProvider.notifier).saveChapter(
        projectId: widget.projectId,
        chapterId: _currentChapterId,
        title: _titleController.text,
        content: _contentController.text,
      );
    }

    _loadChapterIntoEditor(chapter, index);

    if (mounted) {
      Navigator.of(context).pop(); // Close the drawer
      _focusNode.requestFocus();
    }
  }

  Future<void> _addChapter(List<Chapter> currentChapters) async {
    final l10n = AppLocalizations.of(context)!;
    final newSortOrder = currentChapters.length;

    await ref.read(chapterControllerProvider.notifier).saveChapter(
      projectId: widget.projectId,
      title: l10n.defaultChapterTitle,
      content: '',
    );

    final state = ref.read(chapterControllerProvider);

    if (state.hasError) {
      if (mounted) {
        final error = state.error;
        String errorMessage = error is Failure ? error.message : error.toString();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } else if (!state.isLoading && state.value != null) {
      // Load the newly created chapter into the editor
      final newChapter = state.value!;
      _loadChapterIntoEditor(newChapter, newSortOrder);

      if (mounted) {
        Navigator.of(context).pop(); // Close the drawer
        _focusNode.requestFocus();
      }
    }
  }

  Future<void> _confirmDeleteChapter(Chapter chapter, int index, List<Chapter> allChapters) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteChapter),
        content: Text(l10n.deleteChapterConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              l10n.confirm,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ref.read(chapterControllerProvider.notifier).deleteChapter(
      chapter.id,
      widget.projectId,
    );

    final state = ref.read(chapterControllerProvider);

    if (state.hasError) {
      if (mounted) {
        final error = state.error;
        String errorMessage = error is Failure ? error.message : error.toString();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.chapterDeletedSuccess),
            backgroundColor: AppColors.success,
          ),
        );
      }

      // Determine which chapter to show after deletion
      final remainingChapters = allChapters.where((c) => c.id != chapter.id).toList();

      if (remainingChapters.isEmpty) {
        // No chapters left -- reset editor to blank state
        setState(() {
          _currentChapterId = null;
          _selectedChapterIndex = 0;
          _contentController.removeListener(_markDirty);
          _titleController.removeListener(_markDirty);
          _contentController.text = '';
          _titleController.text = AppLocalizations.of(context)!.defaultChapterTitle;
          _hasUnsavedChanges = false;
          _contentController.addListener(_markDirty);
          _titleController.addListener(_markDirty);
        });
      } else if (index == _selectedChapterIndex) {
        // We deleted the currently selected chapter -- select the nearest one
        final newIndex = index >= remainingChapters.length
            ? remainingChapters.length - 1
            : index;
        _loadChapterIntoEditor(remainingChapters[newIndex], newIndex);
      } else if (index < _selectedChapterIndex) {
        // Deleted a chapter before the current one -- adjust index
        setState(() {
          _selectedChapterIndex = _selectedChapterIndex - 1;
        });
      }
    }
  }

  Widget _buildChapterDrawer() {
    final l10n = AppLocalizations.of(context)!;
    final chaptersAsync = ref.watch(chaptersProvider(widget.projectId));

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.chapters,
                    style: AppTypography.h2,
                  ),
                  chaptersAsync.when(
                    data: (chapters) => IconButton(
                      icon: const Icon(Icons.add, color: AppColors.primary),
                      tooltip: l10n.addChapter,
                      onPressed: () => _addChapter(chapters),
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Chapter list
            Expanded(
              child: chaptersAsync.when(
                data: (chapters) {
                  if (chapters.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.l),
                        child: Text(
                          l10n.noChaptersYet,
                          style: AppTypography.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: chapters.length,
                    itemBuilder: (context, index) {
                      final chapter = chapters[index];
                      final isSelected = index == _selectedChapterIndex
                          && chapter.id == _currentChapterId;

                      return ListTile(
                        selected: isSelected,
                        selectedTileColor: AppColors.primary.withValues(alpha: 0.08),
                        title: Text(
                          chapter.title,
                          style: AppTypography.body.copyWith(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${chapter.wordCount} ${l10n.wordsLabel}',
                          style: AppTypography.caption,
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          tooltip: l10n.deleteChapter,
                          onPressed: () => _confirmDeleteChapter(
                            chapter,
                            index,
                            chapters,
                          ),
                        ),
                        onTap: () => _switchToChapter(chapter, index),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.l),
                    child: Text(
                      error is Failure ? error.message : error.toString(),
                      style: AppTypography.body.copyWith(
                        color: AppColors.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final saveState = ref.watch(chapterControllerProvider);
    final isLoading = saveState.isLoading;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.editorBackground, // Cream/Paper
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: SizedBox(
          width: 200,
          child: TextField(
            controller: _titleController,
            textAlign: TextAlign.center,
            maxLength: 255,
            style: AppTypography.h3.copyWith(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppLocalizations.of(context)!.chapterTitleHint,
              errorText: _titleError,
              isDense: true,
              counterText: '',
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(255),
            ],
            onChanged: (_) {
              if (_titleError != null) setState(() => _titleError = null);
            },
          ),
        ),
        actions: [
          // Done Button
          if (isLoading)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.m),
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _handleSave,
              child: Text(
                AppLocalizations.of(context)!.done,
                style: AppTypography.button.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          // Chapters drawer toggle
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            tooltip: AppLocalizations.of(context)!.chapters,
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
          const SizedBox(width: AppSpacing.s),
        ],
      ),
      endDrawer: _buildChapterDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                child: TextField(
                  controller: _contentController,
                  focusNode: _focusNode,
                  autofocus: true,
                  maxLines: null, // Grows vertically
                  style: AppTypography.editorBody,
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.editorPlaceholder,
                    hintStyle: AppTypography.editorBody.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
                    border: InputBorder.none,
                    // Extra padding at bottom to avoid keyboard overlap visually if needed
                    contentPadding: const EdgeInsets.only(bottom: AppSpacing.xl),
                  ),
                  scrollPadding: const EdgeInsets.only(bottom: 100), // Avoid keyboard
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../controllers/chapter_controller.dart';
import '../../domain/entities/chapter.dart';
import '../../../../core/error/failure.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/error/error_message_helper.dart';
// import '../../../../core/components/feedback/app_snackbar.dart'; 

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
  late TextEditingController _contentController;
  late TextEditingController _titleController;
  late FocusNode _focusNode;
  String? _currentChapterId;
  String? _titleError;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
    _titleController = TextEditingController();
    _focusNode = FocusNode();
    
    // Initial Load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
      _focusNode.requestFocus();
    });
  }

  Future<void> _loadInitialData() async {
    // We assume we want to edit the FIRST chapter if it exists, or create a new one.
    // In a real app we might pass chapterId as well, but instructions say:
    // "busca si el proyecto ya tiene capítulos... si tiene carga el primero"
    
    // We cannot easily await the provider value here without listening or reading future.
    try {
      final chapters = await ref.read(chaptersProvider(widget.projectId).future);
      if (chapters.isNotEmpty) {
        final chapter = chapters.first;
        _currentChapterId = chapter.id;
        _contentController.text = chapter.content;
        _titleController.text = chapter.title;
      } else {
         _titleController.text = AppLocalizations.of(context)!.defaultChapterTitle;
      }
    } catch (e) {
      // Handle load error silently or show snackbar
      print("Error loading chapters: $e");
    }
  }

  @override
  void dispose() {
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
    
    // Listen for state changes handled in build(), or check state here ??
    // Riverpod usually recommends checking state or listening.
    // Since saveChapter updates state, let's look at the result.
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
      // Success
        if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.saveSuccess),
            backgroundColor: AppColors.success, // Assuming AppColors.success exists or green
          ),
        );
        // Do NOT pop, maybe just stay to continue editing?
        // Instructions: "Mostrar SnackBar ... y cerrar teclado." (Done unFocus)
        // Didn't explicitly say "Close screen". usually "Done" implies close.
        // "Al pulsar... Si éxito... cerrar teclado". Doesn't say close screen.
        // But "Done" usually means finish.
        // Let's assume just close keyboard based on text.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final saveState = ref.watch(chapterControllerProvider);
    final isLoading = saveState.isLoading;

    return Scaffold(
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
            style: AppTypography.h3.copyWith(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppLocalizations.of(context)!.chapterTitleHint,
              errorText: _titleError, 
              isDense: true,
            ),
            onChanged: (_) {
              if (_titleError != null) setState(() => _titleError = null);
            },
          ),
        ),
        actions: [
          // Done Button
          if (isLoading)
            const Padding(
              padding: EdgeInsets.only(right: AppSpacing.m),
              child: Center(
                child: SizedBox(
                  width: 20, 
                  height: 20, 
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
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
          const SizedBox(width: AppSpacing.s),
        ],
      ),
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
                  // expands: true, // Cannot use expands: true in SingleChildScrollView
                  style: AppTypography.editorBody, 
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.editorPlaceholder,
                    hintStyle: AppTypography.editorBody.copyWith(
                      color: AppColors.textSecondary.withOpacity(0.4)
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

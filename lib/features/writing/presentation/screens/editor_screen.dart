import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';

class EditorScreen extends StatefulWidget {
  final String? initialContent;
  final String? chapterTitle;

  const EditorScreen({
    super.key,
    this.initialContent,
    this.chapterTitle,
  });

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late TextEditingController _contentController;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.initialContent);
    _titleController = TextEditingController(text: widget.chapterTitle ?? 'Untitled Chapter');
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hide status bar for immersive writing if desired, but usually just coloring it is enough.
    // Let's stick to standard system overlay for now but with matching color.
    return Scaffold(
      backgroundColor: AppColors.editorBackground, // Cream/Paper
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary), // "X" or Back
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: SizedBox(
          width: 200,
          child: TextField(
            controller: _titleController,
            textAlign: TextAlign.center,
            style: AppTypography.h3.copyWith(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Chapter Title',
              isDense: true,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Save action
              Navigator.of(context).pop();
            },
            child: Text(
              'Done',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0), // Generous padding
          child: TextField(
            controller: _contentController,
            maxLines: null,
            expands: true,
            style: AppTypography.editorBody, // Merriweather Serif 18px
            cursorColor: AppColors.primary,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: 'Start writing your story...',
              hintStyle: AppTypography.editorBody.copyWith(
                color: AppColors.textSecondary.withOpacity(0.4)
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: AppSpacing.xl),
            ),
          ),
        ),
      ),
    );
  }
}

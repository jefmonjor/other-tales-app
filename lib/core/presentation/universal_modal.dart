import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class UniversalModal {
  /// Shows a platform-adaptive modal:
  /// - Desktop (width > 600): centered Dialog
  /// - Mobile: bottom sheet at 85% height
  static Future<void> showPlatformModal(
    BuildContext context, {
    required String title,
    required Widget content,
  }) async {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    if (isDesktop) {
      // Web: Dialog
      await showDialog(
        context: context,
        builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          constraints: const BoxConstraints(maxWidth: 700),
          child:
              _ModalContent(title: title, content: content, isDialog: true),
        ),
      );
    } else {
      // Mobile: Bottom Sheet (85% height)
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: _ModalContent(
              title: title, content: content, isDialog: false),
        ),
      );
    }
  }
}

class _ModalContent extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isDialog;

  const _ModalContent({
    required this.title,
    required this.content,
    required this.isDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // For dialog
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.l,
            vertical: AppSpacing.m,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.h2,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
                splashRadius: AppSpacing.l,
              )
            ],
          ),
        ),
        const Divider(height: 1),

        // Body with scroll
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: content,
          ),
        ),

        if (isDialog) ...[
          const SizedBox(height: AppSpacing.m), // Bottom padding for dialog
        ],
      ],
    );
  }
}

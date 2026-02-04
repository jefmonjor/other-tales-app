import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UniversalModal {
  static void show(BuildContext context, {required String title, required Widget content}) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        // Use LayoutBuilder to decide between Dialog (Web) or logic that simulates BottomSheet-like behavior if prefered,
        // but flutter 'showDialog' is standard. 
        // User requested:
        // Web: Dialog centered.
        // Mobile: BottomSheet or FullScreen.
        
        // Since we are in showDialog, we are in a route.
        // To strictly follow "Mobile: BottomSheet", we should conditionally call showModalBottomSheet inside the caller?
        // No, the caller calls UniversalModal.show(). We must handle the UI logic here.
        // We can't conditionally call showDialog vs showModalBottomSheet effectively from inside a builder easily without Context jumps.
        // BUT, we can make this method async and logic branch BEFORE showing.
        
        return const SizedBox.shrink(); // Placeholder, logic moved to 'show'
      },
    );
  }
  
  static Future<void> showPlatformModal(BuildContext context, {required String title, required Widget content}) async {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    if (isDesktop) {
      // Web: Dialog
      await showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          constraints: const BoxConstraints(maxWidth: 700),
          child: _ModalContent(title: title, content: content, isDialog: true),
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
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: _ModalContent(title: title, content: content, isDialog: false),
        ),
      );
    }
  }
}

class _ModalContent extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isDialog;

  const _ModalContent({required this.title, required this.content, required this.isDialog});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // For dialog
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
                splashRadius: 24,
              )
            ],
          ),
        ),
        const Divider(height: 1),
        
        // Body with scroll
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: content,
          ),
        ),
        
        if (isDialog) ...[
          const SizedBox(height: 16), // Bottom padding for dialog
        ],
      ],
    );
  }
}

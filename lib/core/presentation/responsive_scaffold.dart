import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;

  const ResponsiveScaffold({
    super.key,
    this.body,
    this.appBar,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if we should use the Card layout (Desktop Web)
    final isDesktop = kIsWeb && MediaQuery.of(context).size.width > 600;

    if (!isDesktop) {
      // Mobile / Tablet logic (Full screen)
      return Scaffold(
        appBar: appBar,
        body: body,
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
      );
    }

    // Desktop Web logic (Center Card)
    return Scaffold(
      backgroundColor: Colors.grey[100], // Neutral background for desktop
      extendBodyBehindAppBar: extendBodyBehindAppBar, // Usually false for card wrapper, but respecting prop
      body: Stack(
        children: [
            // Background decoration (optional: gradient or image)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            
            // Centered Card
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 550, maxHeight: 900),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  margin: const EdgeInsets.all(24),
                  clipBehavior: Clip.antiAlias,
                  child: Scaffold(
                    appBar: appBar,
                    backgroundColor: backgroundColor ?? Colors.white,
                    body: body,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

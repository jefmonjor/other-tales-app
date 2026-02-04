import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    // Desktop Web logic (Split Screen > 900px, otherwise Card or Mobile)
    // The user requested: Mobile/Tablet (< 900) -> Standard (but I should keep the Card logic for 600-900 maybe? Or just switch 900 as the new breakpoint?)
    // User said: "Mobile/Tablet (< 900px): Comportamiento actual". 
    // My current code has: "if (!isDesktop)" where isDesktop is > 600.
    // I should update isDesktop to >= 900 for the Split View, OR handle 600-900 as Tablet (Card).
    // User prompts: "1. Mobile/Tablet (< 900px): Comportamiento actual".
    // "2. Escritorio (> 900px): Row...".
    
    final isDesktopSplit = MediaQuery.of(context).size.width >= 900;
    
    if (isDesktopSplit) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            // LEFT: Branding / Art
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)], // Example dark branding
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  // image: DecorationImage(image: AssetImage('assets/images/auth_bg.png'), fit: BoxFit.cover),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       const Icon(Icons.auto_stories, size: 80, color: Colors.white), // Logo placeholder
                       const SizedBox(height: 24),
                       Text(
                         "Other Tales",
                         style: GoogleFonts.cinzel( // Using a fancy font if available or fallback
                           color: Colors.white,
                           fontSize: 40,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       const SizedBox(height: 16),
                       Text(
                         "Tu historia comienza aquí",
                         style: GoogleFonts.nunitoSans(
                           color: Colors.white70,
                           fontSize: 18,
                         ),
                       ),
                    ],
                  ),
                ),
              ),
            ),
            
            // RIGHT: Form (Content)
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                   // Reuse 450px constraint for the form part
                   child: ConstrainedBox(
                     constraints: const BoxConstraints(maxWidth: 450),
                     child: Scaffold(
                       // We can pass the AppBar here if we want it on the right side, 
                       // or omit it. `GradientAppBar` is quite specific.
                       // User example omitted it. But form might need "Back".
                       // If we omit it, users can't go back easily if no browser back.
                       // Let's render it as a simple row or omit.
                       // If I respect `appBar` prop:
                       appBar: appBar != null ? PreferredSize(
                         preferredSize: appBar!.preferredSize,
                         child: AppBar(
                           elevation: 0,
                           backgroundColor: Colors.transparent,
                           leading: const BackButton(color: Colors.black), // Simple back button
                           // title: (appBar as GradientAppBar).title? // Hard to access properties safely.
                         )
                       ) : null,
                       backgroundColor: Colors.white,
                       body: body,
                     ),
                   ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Tablet / Small Desktop (600 - 900) -> Card Layout
    final isTablet = MediaQuery.of(context).size.width > 600;
    
    if (isTablet) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        body: Stack(
          children: [
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
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450, maxHeight: 900),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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

    // Mobile (< 600)
    return Scaffold(
      appBar: appBar,
      body: body,
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );
  }
}

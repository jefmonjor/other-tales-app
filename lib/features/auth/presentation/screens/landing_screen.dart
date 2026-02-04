import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/brand_button.dart';
import '../widgets/social_button.dart';
import '../../../../core/presentation/widgets/web_split_layout.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Content Panel (Right Side)
    // Using ConstrainedBox to limit max width as requested, but WebSplitLayout handles the main split.
    // The user's code for Mobile used: SafeArea > Center > SingleChildScrollView > ConstrainedBox(maxWidth: 450)
    // The user's code for Desktop used: Center > ConstrainedBox(maxWidth, 400) > Padding
    
    // We'll build the content widget first.
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo & Title
          const Icon(Icons.auto_stories_rounded, size: 80, color: Color(0xFF1A3A4A)), 
          const SizedBox(height: 24),
          const Text(
            "OTHER TALES",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cinzel',
              fontSize: 32, 
              fontWeight: FontWeight.bold, 
              color: Color(0xFF1A3A4A)
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tu historia comienza aquí",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 48),
          
          // Action Buttons
          BrandButton(
            label: AppLocalizations.of(context)!.signInEmail,
            onPressed: () => context.push('/login'),
          ),
          const SizedBox(height: 16),
          SocialButton(
             label: "Continuar con Google",
             svgPath: 'assets/icons/google_logo.svg',
             backgroundColor: Colors.white,
             textColor: const Color(0xFF757575),
             onPressed: () => context.go('/login'),
          ),
          const SizedBox(height: 12),
          SocialButton(
             label: "Continuar con Apple",
             icon: Icons.apple,
             backgroundColor: Colors.black,
             textColor: Colors.white,
             onPressed: () => context.push('/login'),
          ),
          
          const SizedBox(height: 32),
          
           // Footer: Register
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 "${AppLocalizations.of(context)!.noAccount} ",
                 style: GoogleFonts.nunitoSans(
                   color: AppColors.textSecondary,
                   fontSize: 16,
                 ),
               ),
               GestureDetector(
                 onTap: () => context.push('/register'),
                 child: Text(
                   AppLocalizations.of(context)!.register,
                   style: GoogleFonts.nunitoSans(
                     color: const Color(0xFF0B4A78),
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
             ],
          ),
        ],
      ),
    );

    // 2. Hero Panel (Left Side) - Only for Desktop
    final heroPanel = Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A3A4A),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F2027), 
            Color(0xFF203A43), 
            Color(0xFF2C5364)
          ],
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.3), // Overlay
        child: const Center(
           child: Text(
             "Bienvenido a\nOther Tales", 
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),
           ),
        ),
      ),
    );

    // 3. Return Layout
    // We use WebSplitLayout but we need to ensure the Content is wrapped correctly for Mobile vs Desktop inside the panels.
    // WebSplitLayout handles the structural split. 
    // Right panel content needs to be centered and constrained.
    
    return WebSplitLayout(
      leftFlex: 5, // 50%
      rightFlex: 5, // 50%
      leftPanel: heroPanel,
      rightPanel: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView( 
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}



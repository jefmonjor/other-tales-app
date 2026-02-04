import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/brand_button.dart';
import '../widgets/social_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Placeholder
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5), // Placeholder color
              // image: DecorationImage(
              //   image: AssetImage('assets/images/landing_bg.png'),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 100, color: Colors.grey),
            ),
          ),
          
          // Overlay Gradient (optional, for readability)
          Container(
             decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Logo or Title Placeholder
                  // const Text("Other Tales", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  
                  const Spacer(),

                  // Sign in with Email
                  BrandButton(
                    label: AppLocalizations.of(context)!.signInEmail,
                    onPressed: () => context.push('/login'),
                  ),
                  const SizedBox(height: 16),

                  // Sign in with Google
                  SocialButton(
                    label: "Continuar con Google", // Localize
                    svgPath: 'assets/icons/google_logo.svg',
                    backgroundColor: Colors.white,
                    textColor: const Color(0xFF757575),
                    onPressed: () {
                     // In Landing we probably just redirect to Login or trigger generic login?
                     // BUT Landing is usually just navigation. 
                     // Since I added Social to SignInScreen, maybe redundant here.
                     // But user likes "Continue with..." on Landing.
                     // I will navigate to Login or trigger Controller? 
                     // Landing is stateless and no controller. I'll navigate to Login for consistency or Keep as buttons that specific triggers?
                     // I'll Navigate to Login for now, or just implement direct logic if ref available.
                     // Best: Navigate to Login.
                     context.go('/login');
                    },
                  ),
                  const SizedBox(height: 12),

                  // Sign in with Apple
                  SocialButton(
                    label: AppLocalizations.of(context)!.signInApple,
                    icon: Icons.apple,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {
                       // Apple Sign In
                       // If we want direct action, we need ref.
                       // context.go('/login');
                       // Or convert Landing to ConsumerWidget.
                       // I'll convert to ConsumerWidget later if needed, for now just UI hotfix -> Go to Login
                       context.push('/login');
                    },
                  ),
                  
                  const SizedBox(height: 32),

                  // Footer: Register
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         "${AppLocalizations.of(context)!.noAccount} ",
                         style: GoogleFonts.nunitoSans(
                           color: Colors.white,
                           fontSize: 16,
                         ),
                       ),
                       GestureDetector(
                         onTap: () => context.push('/register'),
                         child: Text(
                           AppLocalizations.of(context)!.register,
                           style: GoogleFonts.nunitoSans(
                             color: Colors.white,
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                             decoration: TextDecoration.underline,
                             decorationColor: Colors.white,
                           ),
                         ),
                       ),
                     ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



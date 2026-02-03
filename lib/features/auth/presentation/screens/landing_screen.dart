import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/brand_button.dart';

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

                  // Sign in with Apple
                  _SocialButton(
                    label: AppLocalizations.of(context)!.signInApple,
                    icon: Icons.apple,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {
                      // TODO: Implement Apple Sign In
                    },
                  ),
                  const SizedBox(height: 16),

                  // Sign in with Facebook
                  _SocialButton(
                    label: AppLocalizations.of(context)!.signInFacebook,
                    icon: Icons.facebook,
                    backgroundColor: const Color(0xFF1877F2),
                    textColor: Colors.white,
                    onPressed: () {
                      // TODO: Implement Facebook Sign In
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

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 5),
            blurRadius: 15,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(icon, color: textColor, size: 24),
                const SizedBox(width: 16), // Center alignment might be preferred but Row is standard
                Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24 + 16), // Balance the icon width
              ],
            ),
          ),
        ),
      ),
    );
  }
}

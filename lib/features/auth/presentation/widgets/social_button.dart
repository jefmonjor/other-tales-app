import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final String? svgPath;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final Color? iconColor;
  final bool isLoading;

  const SocialButton({
    super.key,
    required this.label,
    this.svgPath,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    this.iconColor,
    this.isLoading = false,
  }) : assert(svgPath != null || icon != null, 'Must provide either svgPath or icon');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16), // Matching AuthInput radius more closely or keeping 20
        border: Border.all(color: Colors.grey.shade300, width: 1), // Border for white buttons
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isLoading ? null : onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Opacity(
              opacity: isLoading ? 0.5 : 1.0,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centered content
              children: [
                if (svgPath != null)
                  SvgPicture.asset(
                    svgPath!,
                    width: 24,
                    height: 24,
                  )
                else
                  Icon(icon, color: iconColor ?? textColor, size: 24),
                  
                const SizedBox(width: 12),
                
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  }
}

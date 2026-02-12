import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  // Headings & Buttons (Nunito Sans)
  
  static TextStyle get h1 => GoogleFonts.nunitoSans(
        fontSize: 24,
        fontWeight: FontWeight.bold, // 700
        color: AppColors.textPrimary,
      );

  static TextStyle get h2 => GoogleFonts.nunitoSans(
        fontSize: 20,
        fontWeight: FontWeight.w600, // 600
        color: AppColors.textPrimary,
      );

  static TextStyle get h3 => GoogleFonts.nunitoSans(
        fontSize: 18,
        fontWeight: FontWeight.w600, // 600
        color: AppColors.textPrimary,
      );

  static TextStyle get button => GoogleFonts.nunitoSans(
        fontSize: 16, // Typical button size, not specified but standard
        fontWeight: FontWeight.bold, // 700 or 800
        color: Colors.white,
      );

  // Body & Inputs (Inter)

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
      );

   static TextStyle get input => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
      );

   static TextStyle get editorBody => GoogleFonts.merriweather(
        fontSize: 18,
        height: 1.6, // Good line height for reading
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textSecondary,
      );

  static TextStyle get bodyRegular => body;
  static TextStyle get bodySmall => caption;
}

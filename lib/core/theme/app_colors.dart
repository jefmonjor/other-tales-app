import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFF0B4A78); // Primary Solid
  static const Color primaryDark = Color(0xFF00375E); // Manually derived darker shade for press states if needed, or stick to logic.
  // Note: The prompt specified primarySolid as #0B4A78. I'll use that as primary.

  // Background Surfaces
  static const Color background = Color(0xFFFFFFFF); // Background White
  static const Color surfaceInput = Color(0xFFE9E7E8); // Surface Input
  static const Color editorBackground = Color(0xFFFEFDF5); // Cream/Paper for writing

  // Typography Colors
  static const Color textPrimary = Color(0xFF060606); // Text Primary
  static const Color textSecondary = Color(0xFF949494); // Text Secondary

  // Functional Colors
  static const Color error = Color(0xFFB4094C); // Error
  static const Color success = Color(0xFF2E7D32); // Success (Green)
  static const Color surface = Color(0xFFFFFFFF); // Surface (White)
}

class AppGradients {
  static const Gradient brand = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0B4A78), // 0%
      Color(0xFF0B785E), // 100%
    ],
  );
}

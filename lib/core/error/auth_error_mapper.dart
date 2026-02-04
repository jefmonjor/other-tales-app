import 'package:flutter/material.dart';

class AuthErrorMapper {
  static String map({required String originalError, required Locale locale}) {
    final isSpanish = locale.languageCode == 'es';

    if (isSpanish) {
      final error = originalError.toLowerCase();
      
      if (error.contains('user already registered') || 
          error.contains('email already registered') ||
          error.contains('already has been taken')) {
        return "Este correo ya está registrado.";
      }
      
      if (error.contains('invalid login credentials') || 
          error.contains('invalid_grant')) {
        return "Credenciales incorrectas. Verifica tu correo y contraseña.";
      }

      if (error.contains('authapierror') || error.contains('socketexception') || error.contains('network')) {
        return "Error de conexión. Inténtalo más tarde.";
      }

      if (error.contains('password') && error.contains('short')) {
         return "La contraseña es muy corta.";
      }
      
      // Generic fallback for Spanish
      // return "Ocurrió un error inesperado ($originalError)";
      // Better to return translated generic, or keep original if specific info is needed?
      // User asked for "human and polite".
      return "Ocurrió un error: $originalError"; 
    }

    return originalError;
  }
}

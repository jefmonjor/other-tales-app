class AuthErrorMapper {
  static String getFriendlyMessage(Object error, String localeCode) {
    final String rawMessage = error.toString().toLowerCase();
    final bool isEs = localeCode == 'es';

    // 1. Credenciales Inválidas
    if (rawMessage.contains('invalid login credentials') || rawMessage.contains('invalid_grant')) {
      return isEs ? 'Correo o contraseña incorrectos.' : 'Invalid email or password.';
    }

    // 2. Usuario ya existe
    if (rawMessage.contains('user already registered') || rawMessage.contains('already exists')) {
      return isEs ? 'Este correo ya está registrado.' : 'This email is already registered.';
    }

    // 3. Contraseña débil
    if (rawMessage.contains('password should be at least')) {
      return isEs ? 'La contraseña es muy corta (mínimo 6 caracteres).' : 'Password is too short (min 6 chars).';
    }

    // 4. Rate Limit (Seguridad)
    if (rawMessage.contains('too many requests') || rawMessage.contains('rate limit')) {
      return isEs ? 'Demasiados intentos. Espera unos segundos.' : 'Too many attempts. Please wait.';
    }

    // 5. Fallo de Red
    if (rawMessage.contains('socketexception') || rawMessage.contains('network') || rawMessage.contains('authapierror')) {
      return isEs ? 'Error de conexión. Revisa tu internet.' : 'Network error. Check your connection.';
    }

    // Default
    return isEs ? 'Ocurrió un error inesperado.' : 'An unexpected error occurred.';
  }
}

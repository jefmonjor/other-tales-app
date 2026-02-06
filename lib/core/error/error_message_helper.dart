import 'package:flutter/material.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';

class ErrorMessageHelper {
  static String getErrorMessage(String? code, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    if (code == null) return l10n.genericError;

    switch (code) {
      case 'AUTH_INVALID_TOKEN': return l10n.errorAuthInvalidToken;
      case 'AUTH_TOKEN_EXPIRED': return l10n.errorAuthTokenExpired;
      case 'AUTH_UNAUTHORIZED': return l10n.errorAuthUnauthorized;
      case 'PROFILE_NOT_FOUND': return l10n.errorProfileNotFound;
      case 'PROFILE_EMAIL_EXISTS': return l10n.errorProfileEmailExists;
      case 'PROFILE_INVALID_EMAIL': return l10n.errorProfileInvalidEmail;
      case 'PROFILE_INVALID_NAME': return l10n.errorProfileInvalidName;
      case 'PROJECT_NOT_FOUND': return l10n.errorProjectNotFound;
      case 'PROJECT_INVALID_TITLE': return l10n.errorProjectInvalidTitle;
      case 'PROJECT_INVALID_GENRE': return l10n.errorProjectInvalidGenre;
      case 'PROJECT_INVALID_WORD_COUNT': return l10n.errorProjectInvalidWordCount;
      case 'PROJECT_ACCESS_DENIED': return l10n.errorProjectAccessDenied;
      case 'CHAPTER_NOT_FOUND': return l10n.errorChapterNotFound;
      case 'CHAPTER_ACCESS_DENIED': return l10n.errorChapterAccessDenied;
      case 'VALIDATION_FAILED': return l10n.errorValidationFailed;
      case 'VALIDATION_FIELD_REQUIRED': return l10n.errorValidationFieldRequired;
      case 'VALIDATION_FIELD_INVALID': return l10n.errorValidationFieldInvalid;
      case 'DATA_CONFLICT': return l10n.errorDataConflict;
      case 'INTERNAL_ERROR': return l10n.errorInternalError;
      default:
        return l10n.genericError;
    }
  }

  /// Helper to get localized message for a specific field error code
  static String getFieldErrorMessage(String code, BuildContext context) {
      return getErrorMessage(code, context); // Reuse same logic mostly
  }
}

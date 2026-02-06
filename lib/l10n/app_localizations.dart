import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  String get createProject;
  String get untitledChapter;
  String get chapterTitle;
  String get startWriting;
  String get done;
  String get saveSuccess;
  String get validationRequired;
  String get validationError;
  String get serverError;
  String get networkError;
  String get loginTitle;
  String get emailLabel;
  String get passwordLabel;
  String get loginButton;
  String get googleLogin;
  String get appleLogin;
  String get projectsTitle;
  String get newProject;
  String lastEdited(String date);
  String get orSplitter;
  String get requiredField;
  String get forgotPassword;
  String get signIn;
  String get noAccount;
  String get register;
  String get invalidEmail;
  String get heroSubtitle;
  String get searchProjects;
  String get noProjectsYet;
  String get defaultChapterTitle;
  String get chapterTitleHint;
  String get editorPlaceholder;
  String get genericError;
  String get errorAuthInvalidToken;
  String get errorAuthTokenExpired;
  String get errorAuthUnauthorized;
  String get errorProfileNotFound;
  String get errorProfileEmailExists;
  String get errorProfileInvalidEmail;
  String get errorProfileInvalidName;
  String get errorProjectNotFound;
  String get errorProjectInvalidTitle;
  String get errorProjectInvalidGenre;
  String get errorProjectInvalidWordCount;
  String get errorChapterNotFound;
  String get errorValidationFailed;
  String get errorValidationFieldRequired;
  String get errorInternalError;
  String get errorDataConflict;
  String get login;
  String get nameLabel;
  String get nameRequirements;
  String get passwordRequirements;
  String get confirmPasswordLabel;
  String get marketingAccept;
  String get createAccount;
  String get signInEmail;
  String get forgotPasswordTitle;
  String get forgotPasswordSubtitle;
  String get recoverButton;
  String get emailSentTitle;
  String get emailSentMessage;
  String get backToLogin;
  String get myProjectsTitle;
  String get newProjectTitle;
  String get createButton;
  String get cancelButton;
  String get titleLabel;
  String get enterTitle;
  String get genreLabel;
  String get enterGenre;
  String get synopsisLabel;
  String get enterSynopsis;
  String get targetWordCountLabel;

  // New keys
  String get appName;
  String get welcomeHero;
  String get continueWithGoogle;
  String get continueWithApple;
  String get registerWithGoogle;
  String get registerWithApple;
  String get passwordsDoNotMatch;
  String get mustAcceptTerms;
  String get termsTitle;
  String get privacyTitle;
  String get termsAcceptPrefix;
  String get termsAcceptAnd;
  String get joinAdventure;
  String get recoverAccess;
  String get invalidNumber;
  String get projectCreatedSuccess;
  String get wordsLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

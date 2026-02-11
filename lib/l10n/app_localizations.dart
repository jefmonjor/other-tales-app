import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @createProject.
  ///
  /// In en, this message translates to:
  /// **'Create Project'**
  String get createProject;

  /// No description provided for @untitledChapter.
  ///
  /// In en, this message translates to:
  /// **'Untitled Chapter'**
  String get untitledChapter;

  /// No description provided for @chapterTitle.
  ///
  /// In en, this message translates to:
  /// **'Chapter Title'**
  String get chapterTitle;

  /// No description provided for @startWriting.
  ///
  /// In en, this message translates to:
  /// **'Start writing your story...'**
  String get startWriting;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @saveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get saveSuccess;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get validationRequired;

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get validationError;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server Error'**
  String get serverError;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get networkError;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @googleLogin.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get googleLogin;

  /// No description provided for @appleLogin.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get appleLogin;

  /// No description provided for @projectsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Projects'**
  String get projectsTitle;

  /// No description provided for @newProject.
  ///
  /// In en, this message translates to:
  /// **'New Project'**
  String get newProject;

  /// No description provided for @lastEdited.
  ///
  /// In en, this message translates to:
  /// **'Last edited: {date}'**
  String lastEdited(String date);

  /// No description provided for @orSplitter.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get orSplitter;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your story begins here'**
  String get heroSubtitle;

  /// No description provided for @searchProjects.
  ///
  /// In en, this message translates to:
  /// **'Search projects...'**
  String get searchProjects;

  /// No description provided for @noProjectsYet.
  ///
  /// In en, this message translates to:
  /// **'No projects yet. Start creating one!'**
  String get noProjectsYet;

  /// No description provided for @defaultChapterTitle.
  ///
  /// In en, this message translates to:
  /// **'Chapter 1'**
  String get defaultChapterTitle;

  /// No description provided for @chapterTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Chapter Title...'**
  String get chapterTitleHint;

  /// No description provided for @editorPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Start writing your story...'**
  String get editorPlaceholder;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get genericError;

  /// No description provided for @errorAuthInvalidToken.
  ///
  /// In en, this message translates to:
  /// **'Invalid session. Please login again.'**
  String get errorAuthInvalidToken;

  /// No description provided for @errorAuthTokenExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please login again.'**
  String get errorAuthTokenExpired;

  /// No description provided for @errorAuthUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to perform this action.'**
  String get errorAuthUnauthorized;

  /// No description provided for @errorProfileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Profile not found. Please contact support.'**
  String get errorProfileNotFound;

  /// No description provided for @errorProfileEmailExists.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use.'**
  String get errorProfileEmailExists;

  /// No description provided for @errorProfileInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format.'**
  String get errorProfileInvalidEmail;

  /// No description provided for @errorProfileInvalidName.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty.'**
  String get errorProfileInvalidName;

  /// No description provided for @errorProjectNotFound.
  ///
  /// In en, this message translates to:
  /// **'Project not found.'**
  String get errorProjectNotFound;

  /// No description provided for @errorProjectInvalidTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid project title.'**
  String get errorProjectInvalidTitle;

  /// No description provided for @errorProjectInvalidGenre.
  ///
  /// In en, this message translates to:
  /// **'Invalid genre selected.'**
  String get errorProjectInvalidGenre;

  /// No description provided for @errorProjectInvalidWordCount.
  ///
  /// In en, this message translates to:
  /// **'Word count target must be greater than zero.'**
  String get errorProjectInvalidWordCount;

  /// No description provided for @errorProjectAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to access this project.'**
  String get errorProjectAccessDenied;

  /// No description provided for @errorChapterNotFound.
  ///
  /// In en, this message translates to:
  /// **'Chapter not found.'**
  String get errorChapterNotFound;

  /// No description provided for @errorChapterAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to view this chapter.'**
  String get errorChapterAccessDenied;

  /// No description provided for @errorValidationFailed.
  ///
  /// In en, this message translates to:
  /// **'Please check the data marked in red.'**
  String get errorValidationFailed;

  /// No description provided for @errorValidationFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get errorValidationFieldRequired;

  /// No description provided for @errorValidationFieldInvalid.
  ///
  /// In en, this message translates to:
  /// **'The value of this field is invalid.'**
  String get errorValidationFieldInvalid;

  /// No description provided for @errorInternalError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again later.'**
  String get errorInternalError;

  /// No description provided for @errorDataConflict.
  ///
  /// In en, this message translates to:
  /// **'A record with this data already exists.'**
  String get errorDataConflict;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @nameRequirements.
  ///
  /// In en, this message translates to:
  /// **'Name is invalid'**
  String get nameRequirements;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get passwordRequirements;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @marketingAccept.
  ///
  /// In en, this message translates to:
  /// **'I accept to receive news'**
  String get marketingAccept;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signInEmail.
  ///
  /// In en, this message translates to:
  /// **'Or sign in with email'**
  String get signInEmail;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send instructions.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @recoverButton.
  ///
  /// In en, this message translates to:
  /// **'Recover Password'**
  String get recoverButton;

  /// No description provided for @emailSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Sent!'**
  String get emailSentTitle;

  /// No description provided for @emailSentMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox.'**
  String get emailSentMessage;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @myProjectsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Projects'**
  String get myProjectsTitle;

  /// No description provided for @newProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'New Project'**
  String get newProjectTitle;

  /// No description provided for @createButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleLabel;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter title...'**
  String get enterTitle;

  /// No description provided for @genreLabel.
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get genreLabel;

  /// No description provided for @enterGenre.
  ///
  /// In en, this message translates to:
  /// **'Select a genre'**
  String get enterGenre;

  /// No description provided for @synopsisLabel.
  ///
  /// In en, this message translates to:
  /// **'Synopsis'**
  String get synopsisLabel;

  /// No description provided for @enterSynopsis.
  ///
  /// In en, this message translates to:
  /// **'What is it about...'**
  String get enterSynopsis;

  /// No description provided for @targetWordCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Word Count Target'**
  String get targetWordCountLabel;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'OTHER TALES'**
  String get appName;

  /// No description provided for @welcomeHero.
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nOther Tales'**
  String get welcomeHero;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @registerWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Register with Google'**
  String get registerWithGoogle;

  /// No description provided for @registerWithApple.
  ///
  /// In en, this message translates to:
  /// **'Register with Apple'**
  String get registerWithApple;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @mustAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'You must accept the terms and privacy policy'**
  String get mustAcceptTerms;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsTitle;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyTitle;

  /// No description provided for @termsAcceptPrefix.
  ///
  /// In en, this message translates to:
  /// **'I have read and accept the '**
  String get termsAcceptPrefix;

  /// No description provided for @termsAcceptAnd.
  ///
  /// In en, this message translates to:
  /// **' and the '**
  String get termsAcceptAnd;

  /// No description provided for @joinAdventure.
  ///
  /// In en, this message translates to:
  /// **'Join the adventure'**
  String get joinAdventure;

  /// No description provided for @recoverAccess.
  ///
  /// In en, this message translates to:
  /// **'Recover your access'**
  String get recoverAccess;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get invalidNumber;

  /// No description provided for @projectCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Project created!'**
  String get projectCreatedSuccess;

  /// No description provided for @wordsLabel.
  ///
  /// In en, this message translates to:
  /// **'words'**
  String get wordsLabel;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirm;

  /// No description provided for @editProject.
  ///
  /// In en, this message translates to:
  /// **'Edit Project'**
  String get editProject;

  /// No description provided for @deleteProject.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteProject;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? This cannot be undone.'**
  String get deleteConfirm;

  /// No description provided for @projectUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Project updated!'**
  String get projectUpdatedSuccess;

  /// No description provided for @projectDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Project deleted!'**
  String get projectDeletedSuccess;

  /// No description provided for @chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// No description provided for @addChapter.
  ///
  /// In en, this message translates to:
  /// **'Add Chapter'**
  String get addChapter;

  /// No description provided for @deleteChapter.
  ///
  /// In en, this message translates to:
  /// **'Delete Chapter'**
  String get deleteChapter;

  /// No description provided for @deleteChapterConfirm.
  ///
  /// In en, this message translates to:
  /// **'This chapter will be permanently deleted.'**
  String get deleteChapterConfirm;

  /// No description provided for @chapterDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Chapter deleted!'**
  String get chapterDeletedSuccess;

  /// No description provided for @noChaptersYet.
  ///
  /// In en, this message translates to:
  /// **'No chapters yet. Create the first one!'**
  String get noChaptersYet;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @optionalField.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optionalField;

  /// No description provided for @consentRecorded.
  ///
  /// In en, this message translates to:
  /// **'Preferences saved'**
  String get consentRecorded;
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
  // Lookup logic when only language code is specified.
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

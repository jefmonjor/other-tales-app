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

  /// Sign in button label
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Projects section title
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// Goals section title
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// Settings section title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Create project button label
  ///
  /// In en, this message translates to:
  /// **'Create Project'**
  String get createProject;

  /// Title field label
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Genre field label
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get genre;

  /// Word count label
  ///
  /// In en, this message translates to:
  /// **'Word Count'**
  String get wordCount;

  /// Projects screen title
  ///
  /// In en, this message translates to:
  /// **'My Projects'**
  String get myProjectsTitle;

  /// Empty state message when no projects exist
  ///
  /// In en, this message translates to:
  /// **'No projects yet. Create your first story!'**
  String get noProjectsYet;

  /// Search field placeholder
  ///
  /// In en, this message translates to:
  /// **'Search projects...'**
  String get searchProjects;

  /// Title of create project modal
  ///
  /// In en, this message translates to:
  /// **'New Project'**
  String get newProjectTitle;

  /// Hint for title field
  ///
  /// In en, this message translates to:
  /// **'Enter project title'**
  String get enterTitle;

  /// Hint for genre dropdown
  ///
  /// In en, this message translates to:
  /// **'Select genre'**
  String get enterGenre;

  /// Label for create button
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createButton;

  /// Label for cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// Label for title field
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleLabel;

  /// Label for genre field
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get genreLabel;

  /// Label for synopsis field
  ///
  /// In en, this message translates to:
  /// **'Synopsis'**
  String get synopsisLabel;

  /// Hint for synopsis field
  ///
  /// In en, this message translates to:
  /// **'Enter a short synopsis...'**
  String get enterSynopsis;

  /// Label for target word count field
  ///
  /// In en, this message translates to:
  /// **'Target Word Count'**
  String get targetWordCountLabel;

  /// Sign Up button/title
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Full Name field label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Confirm Password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Create Account button label
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Text for existing account prompt
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Login link text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Label for author name input
  ///
  /// In en, this message translates to:
  /// **'Name of the author'**
  String get nameOfAuthor;

  /// Label for repeat password input
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeatPassword;

  /// Checkbox text for terms
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms and Conditions'**
  String get agreeToTerms;

  /// Label for name input
  ///
  /// In en, this message translates to:
  /// **'Name of the author'**
  String get nameLabel;

  /// Label for email input
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Label for password input
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Label for confirm password input
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get confirmPasswordLabel;

  /// Checkbox text for terms
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service'**
  String get termsCheckbox;

  /// Register button label
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// Footer text for existing account
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Login'**
  String get alreadyAccount;

  /// Forgot password screen title
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// Forgot password screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a link to reset your password'**
  String get forgotPasswordSubtitle;

  /// Send email button label
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get sendEmailButton;

  /// Email sent screen title
  ///
  /// In en, this message translates to:
  /// **'Email Sent!'**
  String get emailSentTitle;

  /// Email sent message
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you an email with instructions to reset your password. Please check your inbox.'**
  String get emailSentMessage;

  /// Back to login button
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your writing journey'**
  String get signInSubtitle;

  /// No account text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// Register link text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Marketing checkbox text
  ///
  /// In en, this message translates to:
  /// **'I want to receive news and updates'**
  String get marketingAccept;

  /// Terms checkbox text
  ///
  /// In en, this message translates to:
  /// **'I accept the Terms of Service and Privacy Policy'**
  String get termsAccept;

  /// Success message after registration
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreated;

  /// Error when terms not accepted
  ///
  /// In en, this message translates to:
  /// **'You must accept the Terms of Service'**
  String get mustAcceptTerms;

  /// Sign in with Email button label
  ///
  /// In en, this message translates to:
  /// **'Sign in with Email'**
  String get signInEmail;

  /// Sign in with Apple button label
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get signInApple;

  /// Sign in with Facebook button label
  ///
  /// In en, this message translates to:
  /// **'Sign in with Facebook'**
  String get signInFacebook;

  /// Recover password button label
  ///
  /// In en, this message translates to:
  /// **'Recover'**
  String get recoverButton;

  /// Password validation error
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters, with letters and numbers'**
  String get passwordRequirements;

  /// Name validation error
  ///
  /// In en, this message translates to:
  /// **'No special characters'**
  String get nameRequirements;

  /// Email validation error
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmail;

  /// Login error
  ///
  /// In en, this message translates to:
  /// **'Invalid login credentials'**
  String get invalidCredentials;
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

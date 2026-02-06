// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get createProject => 'Create Project';

  @override
  String get untitledChapter => 'Untitled Chapter';

  @override
  String get chapterTitle => 'Chapter Title';

  @override
  String get startWriting => 'Start writing your story...';

  @override
  String get done => 'Done';

  @override
  String get saveSuccess => 'Saved successfully';

  @override
  String get validationRequired => 'This field is required.';

  @override
  String get validationError => 'Validation Error';

  @override
  String get serverError => 'Server Error';

  @override
  String get networkError => 'No internet connection';

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Login';

  @override
  String get googleLogin => 'Continue with Google';

  @override
  String get appleLogin => 'Continue with Apple';

  @override
  String get projectsTitle => 'My Projects';

  @override
  String get newProject => 'New Project';

  @override
  String lastEdited(String date) {
    return 'Last edited: $date';
  }

  @override
  String get orSplitter => 'or';

  @override
  String get requiredField => 'Required';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get register => 'Register';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get heroSubtitle => 'Your story begins here';

  @override
  String get searchProjects => 'Search projects...';

  @override
  String get noProjectsYet => 'No projects yet. Start creating one!';

  @override
  String get defaultChapterTitle => 'Chapter 1';

  @override
  String get chapterTitleHint => 'Chapter Title...';

  @override
  String get editorPlaceholder => 'Start writing your story...';

  @override
  String get genericError => 'Something went wrong';

  @override
  String get errorAuthInvalidToken => 'Invalid session. Please login again.';

  @override
  String get errorAuthTokenExpired => 'Session expired. Please login again.';

  @override
  String get errorAuthUnauthorized =>
      'You don\'t have permission to perform this action.';

  @override
  String get errorProfileNotFound =>
      'Profile not found. Please contact support.';

  @override
  String get errorProfileEmailExists => 'This email is already in use.';

  @override
  String get errorProfileInvalidEmail => 'Invalid email format.';

  @override
  String get errorProfileInvalidName => 'Name cannot be empty.';

  @override
  String get errorProjectNotFound => 'Project not found.';

  @override
  String get errorProjectInvalidTitle => 'Invalid project title.';

  @override
  String get errorProjectInvalidGenre => 'Invalid genre selected.';

  @override
  String get errorProjectInvalidWordCount =>
      'Word count target must be greater than zero.';

  @override
  String get errorChapterNotFound => 'Chapter not found.';

  @override
  String get errorValidationFailed => 'Please check the data marked in red.';

  @override
  String get errorValidationFieldRequired => 'This field is required.';

  @override
  String get errorInternalError =>
      'An unexpected error occurred. Please try again later.';

  @override
  String get errorDataConflict => 'A record with this data already exists.';

  @override
  String get login => 'Login';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameRequirements => 'Name is invalid';

  @override
  String get passwordRequirements => 'Password is too weak';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get marketingAccept => 'I accept to receive news';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signInEmail => 'Or sign in with email';

  @override
  String get forgotPasswordTitle => 'Forgot Password?';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email and we\'ll send instructions.';

  @override
  String get recoverButton => 'Recover Password';

  @override
  String get emailSentTitle => 'Email Sent!';

  @override
  String get emailSentMessage => 'Check your inbox.';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get myProjectsTitle => 'My Projects';

  @override
  String get newProjectTitle => 'New Project';

  @override
  String get createButton => 'Create';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get titleLabel => 'Title';

  @override
  String get enterTitle => 'Enter title...';

  @override
  String get genreLabel => 'Genre';

  @override
  String get enterGenre => 'Select a genre';

  @override
  String get synopsisLabel => 'Synopsis';

  @override
  String get enterSynopsis => 'What is it about...';

  @override
  String get targetWordCountLabel => 'Word Count Target';

  // New keys
  @override
  String get appName => 'OTHER TALES';

  @override
  String get welcomeHero => 'Welcome to\nOther Tales';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get registerWithGoogle => 'Register with Google';

  @override
  String get registerWithApple => 'Register with Apple';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get mustAcceptTerms =>
      'You must accept the terms and privacy policy';

  @override
  String get termsTitle => 'Terms and Conditions';

  @override
  String get privacyTitle => 'Privacy Policy';

  @override
  String get termsAcceptPrefix => 'I have read and accept the ';

  @override
  String get termsAcceptAnd => ' and the ';

  @override
  String get joinAdventure => 'Join the adventure';

  @override
  String get recoverAccess => 'Recover your access';

  @override
  String get invalidNumber => 'Invalid number';

  @override
  String get projectCreatedSuccess => 'Project created!';

  @override
  String get wordsLabel => 'words';
}

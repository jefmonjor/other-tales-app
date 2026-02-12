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
  String get startWriting => 'Begin your tale...';

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
  String get loginButton => 'Log in';

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
  String get signUpTitle => 'Sign Up';

  @override
  String get dashboardImages => 'Images';

  @override
  String get dashboardIdeas => 'Ideas';

  @override
  String get dashboardStory => 'Story';

  @override
  String get dashboardCharacters => 'Characters';

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
  String get noProjectsYet => 'No projects yet. Create your first one!';

  @override
  String get defaultChapterTitle => 'Chapter 1';

  @override
  String get chapterTitleHint => 'Chapter Title...';

  @override
  String get editorPlaceholder => 'Begin your tale...';

  @override
  String get genericError => 'Something went wrong';

  @override
  String get errorAuthInvalidToken => 'Invalid session. Please log in again.';

  @override
  String get errorAuthTokenExpired => 'Session expired. Please log in again.';

  @override
  String get errorAuthUnauthorized =>
      'You do not have permission to perform this action.';

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
  String get errorProjectAccessDenied =>
      'You do not have permission to access this project.';

  @override
  String get errorChapterNotFound => 'Chapter not found.';

  @override
  String get errorChapterAccessDenied =>
      'You do not have permission to view this chapter.';

  @override
  String get errorValidationFailed =>
      'Please check the data highlighted in red.';

  @override
  String get errorValidationFieldRequired => 'This field is required.';

  @override
  String get errorValidationFieldInvalid =>
      'The value of this field is invalid.';

  @override
  String get errorInternalError =>
      'An unexpected error occurred. Please try again later.';

  @override
  String get errorDataConflict => 'A record with this data already exists.';

  @override
  String get login => 'Log in';

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
  String get signInEmail => 'Sign in with email';

  @override
  String get forgotPasswordTitle => 'Forgot Password?';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email and we shall send instructions.';

  @override
  String get recoverButton => 'Recover Password';

  @override
  String get emailSentTitle => 'Email Sent!';

  @override
  String get emailSentMessage => 'Check your inbox.';

  @override
  String get backToLogin => 'Back to Log in';

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
  String get mustAcceptTerms => 'You must accept the terms and privacy policy';

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

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get editProject => 'Edit Project';

  @override
  String get deleteProject => 'Delete';

  @override
  String get deleteConfirm => 'Are you sure? This action cannot be undone.';

  @override
  String get projectUpdatedSuccess => 'Project updated!';

  @override
  String get projectDeletedSuccess => 'Project deleted!';

  @override
  String get chapters => 'Chapters';

  @override
  String get addChapter => 'Add Chapter';

  @override
  String get deleteChapter => 'Delete Chapter';

  @override
  String get deleteChapterConfirm =>
      'This chapter will be permanently deleted.';

  @override
  String get chapterDeletedSuccess => 'Chapter deleted!';

  @override
  String get noChaptersYet => 'No chapters yet. Create the first one!';

  @override
  String get confirm => 'Confirm';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get optionalField => 'Optional';

  @override
  String get consentRecorded => 'Preferences saved';

  @override
  String get genreFantasy => 'Fantasy';

  @override
  String get genreSciFi => 'Science Fiction';

  @override
  String get genreRomance => 'Romance';

  @override
  String get genreMystery => 'Mystery';

  @override
  String get genreThriller => 'Thriller';

  @override
  String get genreHorror => 'Horror';

  @override
  String get genreHistorical => 'Historical';

  @override
  String get genreLiteraryFiction => 'Literary Fiction';

  @override
  String get genreAdventure => 'Adventure';

  @override
  String get genreDrama => 'Drama';

  @override
  String get genrePoetry => 'Poetry';

  @override
  String get genreNonFiction => 'Non-Fiction';

  @override
  String get editCharacter => 'Edit Character';

  @override
  String get createCharacter => 'New Character';

  @override
  String get characterNameLabel => 'Name';

  @override
  String get characterNameRequired => 'Name is required';

  @override
  String get characterRoleLabel => 'Role';

  @override
  String get characterDescriptionLabel => 'Description';

  @override
  String get characterPhysicalDescriptionLabel => 'Physical Description';

  @override
  String get tapToAddPhoto => 'Tap to add photo';

  @override
  String get tapToAddCover => 'Tap to add cover';

  @override
  String get editStory => 'Edit Story';

  @override
  String get createStory => 'New Story';

  @override
  String get storyTitleLabel => 'Title';

  @override
  String get storyTitleRequired => 'Title is required';

  @override
  String get storySynopsisLabel => 'Synopsis';

  @override
  String get storyThemeLabel => 'Theme';

  @override
  String get storySecondaryPlotsLabel => 'Secondary Plots';

  @override
  String get noSynopsis => 'No synopsis available.';

  @override
  String get editIdea => 'Edit Idea';

  @override
  String get createIdea => 'New Idea';

  @override
  String get ideaTitleHint => 'Idea Title';

  @override
  String get ideaContentHint => 'Jot down your idea...';

  @override
  String get saveIdea => 'Save Idea';

  @override
  String get ideaTitleRequired => 'Title is required';

  @override
  String get noCharacters => 'No characters yet. Create one!';

  @override
  String get noStories => 'No stories yet. Create one!';

  @override
  String get noIdeas => 'No ideas yet. Create one!';

  @override
  String get uploadingImage => 'Uploading image...';

  @override
  String get imageUploaded => 'Image uploaded successfully';

  @override
  String get projectDefaultTitle => 'Project';
}

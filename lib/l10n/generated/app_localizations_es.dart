// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get createProject => 'Crear proyecto';

  @override
  String get untitledChapter => 'Capítulo sin título';

  @override
  String get chapterTitle => 'Título del capítulo';

  @override
  String get startWriting => 'Empieza a escribir tu historia...';

  @override
  String get done => 'Listo';

  @override
  String get saveSuccess => 'Guardado correctamente';

  @override
  String get validationRequired => 'Este campo es obligatorio.';

  @override
  String get validationError => 'Por favor, revisa los datos.';

  @override
  String get serverError => 'Ha ocurrido un problema en el servidor';

  @override
  String get networkError => 'Comprueba tu conexión a internet';

  @override
  String get loginTitle => 'Te damos la bienvenida';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get loginButton => 'Entrar';

  @override
  String get googleLogin => 'Continuar con Google';

  @override
  String get appleLogin => 'Continuar con Apple';

  @override
  String get projectsTitle => 'Mis proyectos';

  @override
  String get newProject => 'Nuevo proyecto';

  @override
  String lastEdited(String date) {
    return 'Editado: $date';
  }

  @override
  String get orSplitter => 'o';

  @override
  String get requiredField => 'Obligatorio';

  @override
  String get forgotPassword => '¿Has olvidado tu contraseña?';

  @override
  String get signIn => 'Entrar';

  @override
  String get signUpTitle => 'Registrarse';

  @override
  String get dashboardImages => 'Imágenes';

  @override
  String get dashboardIdeas => 'Ideas';

  @override
  String get dashboardStory => 'Historia';

  @override
  String get dashboardCharacters => 'Personajes';

  @override
  String get noAccount => '¿No tienes cuenta?';

  @override
  String get register => 'Regístrate';

  @override
  String get invalidEmail => 'El correo no es válido';

  @override
  String get heroSubtitle => 'Tu historia comienza aquí';

  @override
  String get searchProjects => 'Buscar proyectos...';

  @override
  String get noProjectsYet => 'Todavía no tienes proyectos. ¡Crea el primero!';

  @override
  String get defaultChapterTitle => 'Capítulo 1';

  @override
  String get chapterTitleHint => 'Título del capítulo...';

  @override
  String get editorPlaceholder => 'Empieza a escribir tu historia...';

  @override
  String get genericError => 'Ha ocurrido un error inesperado';

  @override
  String get errorAuthInvalidToken =>
      'Tu sesión no es válida. Por favor, vuelve a entrar.';

  @override
  String get errorAuthTokenExpired =>
      'Tu sesión ha caducado. Por favor, vuelve a entrar.';

  @override
  String get errorAuthUnauthorized =>
      'No tienes permisos para realizar esta acción.';

  @override
  String get errorProfileNotFound =>
      'No hemos encontrado tu perfil. Contacta con soporte.';

  @override
  String get errorProfileEmailExists =>
      'Este correo electrónico ya está en uso.';

  @override
  String get errorProfileInvalidEmail =>
      'El correo no tiene un formato válido.';

  @override
  String get errorProfileInvalidName => 'El nombre no puede estar vacío.';

  @override
  String get errorProjectNotFound => 'No hemos encontrado este proyecto.';

  @override
  String get errorProjectInvalidTitle => 'El título del proyecto no es válido.';

  @override
  String get errorProjectInvalidGenre => 'El género seleccionado no es válido.';

  @override
  String get errorProjectInvalidWordCount =>
      'El objetivo de palabras debe ser mayor que cero.';

  @override
  String get errorProjectAccessDenied =>
      'No tienes permiso para acceder a este proyecto.';

  @override
  String get errorChapterNotFound => 'No hemos encontrado este capítulo.';

  @override
  String get errorChapterAccessDenied =>
      'No tienes permiso para ver este capítulo.';

  @override
  String get errorValidationFailed =>
      'Por favor, revisa los datos marcados en rojo.';

  @override
  String get errorValidationFieldRequired => 'Este campo es obligatorio.';

  @override
  String get errorValidationFieldInvalid =>
      'El valor de este campo no es válido.';

  @override
  String get errorInternalError =>
      'Ha ocurrido un error inesperado. Inténtalo de nuevo más tarde.';

  @override
  String get errorDataConflict => 'Ya existe un registro con estos datos.';

  @override
  String get login => 'Entrar';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get nameRequirements => 'El nombre no es válido';

  @override
  String get passwordRequirements => 'La contraseña es muy débil';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get marketingAccept => 'Acepto recibir novedades';

  @override
  String get createAccount => 'Crear Cuenta';

  @override
  String get signInEmail => 'Entra con tu email';

  @override
  String get forgotPasswordTitle => '¿Has olvidado tu contraseña?';

  @override
  String get forgotPasswordSubtitle =>
      'Introduce tu email y te enviaremos instrucciones.';

  @override
  String get recoverButton => 'Recuperar contraseña';

  @override
  String get emailSentTitle => '¡Correo enviado!';

  @override
  String get emailSentMessage => 'Revisa tu bandeja de entrada.';

  @override
  String get backToLogin => 'Volver a entrar';

  @override
  String get myProjectsTitle => 'Mis Proyectos';

  @override
  String get newProjectTitle => 'Nuevo Proyecto';

  @override
  String get createButton => 'Crear';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get titleLabel => 'Título';

  @override
  String get enterTitle => 'Escribe un título...';

  @override
  String get genreLabel => 'Género';

  @override
  String get enterGenre => 'Selecciona un género';

  @override
  String get synopsisLabel => 'Sinopsis';

  @override
  String get enterSynopsis => 'De qué trata...';

  @override
  String get targetWordCountLabel => 'Objetivo de palabras';

  @override
  String get appName => 'OTHER TALES';

  @override
  String get welcomeHero => 'Bienvenido a\nOther Tales';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get registerWithGoogle => 'Regístrate con Google';

  @override
  String get registerWithApple => 'Regístrate con Apple';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get mustAcceptTerms =>
      'Debes aceptar los términos y la política de privacidad';

  @override
  String get termsTitle => 'Términos y Condiciones';

  @override
  String get privacyTitle => 'Política de Privacidad';

  @override
  String get termsAcceptPrefix => 'He leído y acepto los ';

  @override
  String get termsAcceptAnd => ' y la ';

  @override
  String get joinAdventure => 'Únete a la aventura';

  @override
  String get recoverAccess => 'Recupera tu acceso';

  @override
  String get invalidNumber => 'Número no válido';

  @override
  String get projectCreatedSuccess => '¡Proyecto creado!';

  @override
  String get wordsLabel => 'palabras';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutConfirm => '¿Seguro que quieres cerrar sesión?';

  @override
  String get editProject => 'Editar Proyecto';

  @override
  String get deleteProject => 'Eliminar';

  @override
  String get deleteConfirm =>
      '¿Estás seguro? Esta acción no se puede deshacer.';

  @override
  String get projectUpdatedSuccess => '¡Proyecto actualizado!';

  @override
  String get projectDeletedSuccess => '¡Proyecto eliminado!';

  @override
  String get chapters => 'Capítulos';

  @override
  String get addChapter => 'Añadir Capítulo';

  @override
  String get deleteChapter => 'Eliminar Capítulo';

  @override
  String get deleteChapterConfirm =>
      'Este capítulo se eliminará permanentemente.';

  @override
  String get chapterDeletedSuccess => '¡Capítulo eliminado!';

  @override
  String get noChaptersYet => 'Aún no hay capítulos. ¡Crea el primero!';

  @override
  String get confirm => 'Confirmar';

  @override
  String get save => 'Guardar';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get optionalField => 'Opcional';

  @override
  String get consentRecorded => 'Preferencias guardadas';

  @override
  String get genreFantasy => 'Fantasía';

  @override
  String get genreSciFi => 'Ciencia Ficción';

  @override
  String get genreRomance => 'Romance';

  @override
  String get genreMystery => 'Misterio';

  @override
  String get genreThriller => 'Thriller';

  @override
  String get genreHorror => 'Terror';

  @override
  String get genreHistorical => 'Histórica';

  @override
  String get genreLiteraryFiction => 'Ficción Literaria';

  @override
  String get genreAdventure => 'Aventura';

  @override
  String get genreDrama => 'Drama';

  @override
  String get genrePoetry => 'Poesía';

  @override
  String get genreNonFiction => 'No Ficción';

  @override
  String get editCharacter => 'Editar Personaje';

  @override
  String get createCharacter => 'Nuevo Personaje';

  @override
  String get characterNameLabel => 'Nombre';

  @override
  String get characterNameRequired => 'El nombre es obligatorio';

  @override
  String get characterRoleLabel => 'Rol';

  @override
  String get characterDescriptionLabel => 'Descripción';

  @override
  String get characterPhysicalDescriptionLabel => 'Descripción Física';

  @override
  String get tapToAddPhoto => 'Toca para añadir foto';

  @override
  String get tapToAddCover => 'Toca para añadir portada';

  @override
  String get editStory => 'Editar Historia';

  @override
  String get createStory => 'Nueva Historia';

  @override
  String get storyTitleLabel => 'Título';

  @override
  String get storyTitleRequired => 'El título es obligatorio';

  @override
  String get storySynopsisLabel => 'Sinopsis';

  @override
  String get storyThemeLabel => 'Tema';

  @override
  String get storySecondaryPlotsLabel => 'Tramas Secundarias';

  @override
  String get noSynopsis => 'Sin sinopsis.';

  @override
  String get editIdea => 'Editar Idea';

  @override
  String get createIdea => 'Nueva Idea';

  @override
  String get ideaTitleHint => 'Título de la idea';

  @override
  String get ideaContentHint => 'Escribe tu idea...';

  @override
  String get saveIdea => 'Guardar Idea';

  @override
  String get ideaTitleRequired => 'El título es obligatorio';

  @override
  String get noCharacters => 'No hay personajes. ¡Crea uno!';

  @override
  String get noStories => 'No hay historias. ¡Crea una!';

  @override
  String get noIdeas => 'No hay ideas. ¡Crea una!';

  @override
  String get uploadingImage => 'Subiendo imagen...';

  @override
  String get imageUploaded => 'Imagen subida correctamente';

  @override
  String get projectDefaultTitle => 'Proyecto';
}

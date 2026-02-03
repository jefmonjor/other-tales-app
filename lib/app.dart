import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:other_tales_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class OtherTalesApp extends ConsumerWidget {
  const OtherTalesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Other Tales',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
      
      // Internationalization
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      localeListResolutionCallback: (locales, supportedLocales) {
        if (locales == null || locales.isEmpty) {
          return const Locale('en');
        }
        for (final locale in locales) {
          if (locale.languageCode == 'es') {
            return const Locale('es');
          }
        }
        return const Locale('en');
      },
      builder: (context, child) {
        // Mobile Wrapper for Desktop Web
        final isWebDesktop = kIsWeb && MediaQuery.of(context).size.width > 600;
        
        if (!isWebDesktop) return child!;
        
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600), // Max width for mobile feel
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 20, 
                    color: Colors.black12,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: child!,
            ),
          ),
        );
      },
    );
  }
}

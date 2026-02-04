import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/presentation/providers/auth_state_provider.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/auth/presentation/screens/landing_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/password_sent_screen.dart';
import '../../features/projects/presentation/screens/projects_screen.dart';
import '../../features/writing/presentation/screens/editor_screen.dart';
import '../components/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'go_router_refresh_stream.dart';

part 'app_router.g.dart';

/// Routes that don't require authentication
const _publicRoutes = ['/landing', '/login', '/register', '/forgot-password', '/password-sent', '/splash'];

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  // We do NOT watch authStateProvider here anymore to avoid rebuilding the Router
  // Instead, we use refreshListenable with the Stream.
  
  return GoRouter(
    initialLocation: '/landing',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(Supabase.instance.client.auth.onAuthStateChange),
    redirect: (context, state) {
      final currentPath = state.uri.path;
      
      // 1. Get current Supabase Session directly (Sync)
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggedIn = session != null;
      
      final isLoggingIn = currentPath == '/login' || currentPath == '/register' || currentPath == '/landing';
      final isSplash = currentPath == '/splash';

      print('--- ROUTER CHECK ---');
      print('Path actual: $currentPath');
      print('¿Tiene sesión?: $isLoggedIn');
      if (isLoggedIn) print('User ID: ${session.user.id}');
      
      // 2. Redirection Logic (Guard)

      // A. If NOT logged in and trying to access protected route -> Landing/Login
      if (!isLoggedIn) {
         // Allow public routes
         if (_publicRoutes.contains(currentPath)) {
           return null;
         }
         // Redirect strict protected routes to landing/login
         print('>> REDIRECT: Forzando a Login');
         return '/landing';
      }

      // B. If LOGGED IN and trying to access Auth screens -> Projects (Home)
      if (isLoggedIn) {
        if (isLoggingIn || isSplash) {
          print('>> REDIRECT: Usuario logueado intentando ver login. Enviando a /projects');
          return '/projects';
        }
      }

      // C. Allow navigation
      return null;
    },
    routes: [
      // ========== PUBLIC ROUTES ==========
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/landing',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LandingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignInScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignUpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/password-sent',
        builder: (context, state) => const PasswordSentScreen(),
      ),
      
      // ========== PROTECTED ROUTES ==========
      GoRoute(
        path: '/projects',
        builder: (context, state) => const ProjectsScreen(),
      ),
      GoRoute(
        path: '/editor',
        builder: (context, state) => const EditorScreen(),
      ),
    ],
  );
}

import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/auth/presentation/screens/landing_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/password_sent_screen.dart';
import '../../features/projects/presentation/screens/projects_screen.dart';
import '../../features/writing/presentation/screens/editor_screen.dart';
import '../components/screens/splash_screen.dart';
import 'go_router_refresh_stream.dart';

part 'app_router.g.dart';

/// Routes that don't require authentication
const _publicRoutes = [
  '/landing',
  '/login',
  '/register',
  '/forgot-password',
  '/password-sent',
  '/splash',
];

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/landing',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      Supabase.instance.client.auth.onAuthStateChange,
    ),
    redirect: (context, state) {
      final currentPath = state.uri.path;
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggedIn = session != null;
      final isAuthRoute = currentPath == '/login' ||
          currentPath == '/register' ||
          currentPath == '/landing';
      final isSplash = currentPath == '/splash';

      // A. Not logged in -> only allow public routes
      if (!isLoggedIn) {
        if (_publicRoutes.contains(currentPath)) return null;
        return '/landing';
      }

      // B. Logged in + on auth/splash screen -> redirect to home
      if (isLoggedIn && (isAuthRoute || isSplash)) {
        return '/projects';
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignInScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignUpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
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
        path: '/editor/:projectId',
        builder: (context, state) => EditorScreen(
          projectId: state.pathParameters['projectId']!,
        ),
      ),
    ],
  );
}

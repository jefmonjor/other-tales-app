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

part 'app_router.g.dart';

/// Routes that don't require authentication
const _publicRoutes = ['/landing', '/login', '/register', '/forgot-password', '/password-sent', '/splash'];

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/landing',
    debugLogDiagnostics: true, // Enable debug logging to see navigation
    redirect: (context, state) {
      final currentPath = state.uri.path;
      
      // If still loading auth state, stay on splash
      if (authState.isLoading) {
        return currentPath == '/splash' ? null : '/splash';
      }

      final status = authState.valueOrNull ?? AuthStatus.unauthenticated;
      final isPublicRoute = _publicRoutes.contains(currentPath);

      // If authenticated
      if (status == AuthStatus.authenticated) {
        // Redirect away from auth screens to projects
        if (currentPath == '/splash' || currentPath == '/login') {
          return '/projects';
        }
        // Allow other routes
        return null;
      }

      // If unauthenticated
      if (status == AuthStatus.unauthenticated) {
        // Allow public routes (including register, forgot-password)
        if (isPublicRoute) {
          return null; // <-- KEY FIX: Allow navigation to public routes!
        }
        // Redirect protected routes to login
        return '/login';
      }

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
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const SignUpScreen(),
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

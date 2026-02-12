import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/auth/presentation/screens/landing_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/password_sent_screen.dart';
import '../../features/projects/presentation/screens/projects_screen.dart';
import '../../features/writing/presentation/screens/editor_screen.dart';
import '../../features/projects/presentation/screens/project_dashboard_screen.dart';
import '../../features/projects/presentation/screens/characters/character_list_screen.dart';
import '../../features/projects/presentation/screens/characters/character_edit_screen.dart';
import '../../features/projects/presentation/screens/stories/story_list_screen.dart';
import '../../features/projects/presentation/screens/stories/story_edit_screen.dart';
import '../../features/projects/presentation/screens/ideas/idea_list_screen.dart';
import '../../features/projects/presentation/screens/ideas/idea_edit_screen.dart';
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
GoRouter appRouter(Ref ref) {
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
        path: '/projects/:projectId',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId']!;
          // Attempt to get the project title from the extra object if passed
          final extra = state.extra as Map<String, dynamic>?;
          final projectTitle = extra?['title'] as String?;
          
          return ProjectDashboardScreen(
            projectId: projectId,
            projectTitle: projectTitle,
          );
        },
      routes: [
           GoRoute(
            path: 'characters',
            builder: (context, state) {
              final projectId = state.pathParameters['projectId']!;
              return CharacterListScreen(projectId: projectId);
            },
            routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) {
                  final projectId = state.pathParameters['projectId']!;
                  return CharacterEditScreen(projectId: projectId);
                },
              ),
              GoRoute(
                path: ':characterId',
                builder: (context, state) {
                  final projectId = state.pathParameters['projectId']!;
                  final characterId = state.pathParameters['characterId']!;
                  return CharacterEditScreen(
                    projectId: projectId,
                    characterId: characterId,
                  );
                },
              ),
            ]
          ),
          GoRoute(
            path: 'stories',
             builder: (context, state) {
              final projectId = state.pathParameters['projectId']!;
              return StoryListScreen(projectId: projectId);
            },
             routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) {
                  final projectId = state.pathParameters['projectId']!;
                  return StoryEditScreen(projectId: projectId);
                },
              ),
              GoRoute(
                path: ':storyId',
                builder: (context, state) {
                  final projectId = state.pathParameters['projectId']!;
                  final storyId = state.pathParameters['storyId']!;
                  return StoryEditScreen(
                    projectId: projectId,
                    storyId: storyId,
                  );
                },
              ),
            ]
          ),
          GoRoute(
            path: 'ideas',
             builder: (context, state) {
              final projectId = state.pathParameters['projectId']!;
              return IdeaListScreen(projectId: projectId);
            },
             routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) {
                  final projectId = state.pathParameters['projectId']!;
                  return IdeaEditScreen(projectId: projectId);
                },
              ),
              GoRoute(
                path: ':ideaId',
                builder: (context, state) {
                  final projectId = state.pathParameters['projectId']!;
                  final ideaId = state.pathParameters['ideaId']!;
                  return IdeaEditScreen(
                    projectId: projectId,
                    ideaId: ideaId,
                  );
                },
              ),
            ]
          ),
          GoRoute(
             path: 'images',
             builder: (context, state) => const Scaffold(body: Center(child: Text('Images Placeholder'))), // TODO: Implement Images Screen
          ),
        ],
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/pages/splash/splash_screen.dart';
import '../../presentation/pages/onboarding/onboarding_screen.dart';
import '../../presentation/pages/auth/login_screen.dart';
import '../../presentation/pages/auth/signup_screen.dart';
import '../../presentation/pages/home/home_screen.dart';
import '../../presentation/pages/creator/creator_profile_screen.dart';
import '../../presentation/pages/creator/creator_dashboard_screen.dart';
import '../../presentation/pages/subscription/subscription_screen.dart';
import '../../presentation/pages/content/content_viewer_screen.dart';
import '../../presentation/pages/search/search_screen.dart';
import '../../presentation/pages/profile/profile_screen.dart';
import '../../test_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TestScreen(), // 임시로 TestScreen으로 변경
        ),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SignupScreen(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const HomeScreen(),
            ),
            routes: [
              GoRoute(
                path: 'creator/:creatorId',
                name: 'creator-profile',
                pageBuilder: (context, state) {
                  final creatorId = state.pathParameters['creatorId']!;
                  return MaterialPage(
                    key: state.pageKey,
                    child: CreatorProfileScreen(creatorId: creatorId),
                  );
                },
              ),
              GoRoute(
                path: 'content/:contentId',
                name: 'content-viewer',
                pageBuilder: (context, state) {
                  final contentId = state.pathParameters['contentId']!;
                  return MaterialPage(
                    key: state.pageKey,
                    child: ContentViewerScreen(contentId: contentId),
                  );
                },
              ),
              GoRoute(
                path: 'subscription/:creatorId',
                name: 'subscription',
                pageBuilder: (context, state) {
                  final creatorId = state.pathParameters['creatorId']!;
                  return MaterialPage(
                    key: state.pageKey,
                    child: SubscriptionScreen(creatorId: creatorId),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/search',
            name: 'search',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const SearchScreen(),
            ),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const ProfileScreen(),
            ),
          ),
          GoRoute(
            path: '/creator-dashboard',
            name: 'creator-dashboard',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const CreatorDashboardScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});
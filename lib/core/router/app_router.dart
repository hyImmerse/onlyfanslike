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
import '../../presentation/pages/payment/payment_history_screen.dart';
import '../../presentation/screens/notification_screen.dart';
import '../../presentation/screens/notification_settings_screen.dart';
import '../../presentation/screens/conversations_screen.dart';
import '../../presentation/screens/chat_screen.dart';
import '../../test_screen.dart';
import '../../presentation/providers/auth_state_notifier.dart';
import '../../presentation/providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // AuthStateNotifier를 watch하여 인증 상태 변경 시 라우터가 재빌드되도록 함
  final authState = ref.watch(authStateNotifierProvider);
  
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    // 인증 기반 라우트 가드 구현
    redirect: (BuildContext context, GoRouterState state) {
      final isAuthenticated = authState.isAuthenticated;
      final isLoading = authState.isLoading;
      final location = state.matchedLocation;
      
      // 로딩 중인 경우 현재 위치 유지
      if (isLoading) {
        return null;
      }
      
      // 인증이 필요하지 않은 페이지들
      final publicRoutes = [
        '/login',
        '/signup',
        '/onboarding',
        '/',
      ];
      
      // 현재 페이지가 public route인지 확인
      final isPublicRoute = publicRoutes.contains(location);
      
      // 인증되지 않은 사용자가 보호된 페이지에 접근하려는 경우
      if (!isAuthenticated && !isPublicRoute) {
        return '/login';
      }
      
      // 인증된 사용자가 로그인/회원가입 페이지에 접근하려는 경우
      if (isAuthenticated && (location == '/login' || location == '/signup')) {
        return '/home';
      }
      
      // 크리에이터 대시보드는 크리에이터만 접근 가능
      if (location == '/creator-dashboard' && isAuthenticated) {
        final currentUser = ref.read(currentUserProvider);
        // 크리에이터가 아닌 경우 홈으로 리다이렉트
        if (currentUser != null && !currentUser.isCreator) {
          return '/home';
        }
      }
      
      // 그 외의 경우 현재 위치 유지
      return null;
    },
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
          GoRoute(
            path: '/payment-history',
            name: 'payment-history',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const PaymentHistoryScreen(),
            ),
          ),
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const NotificationScreen(),
            ),
            routes: [
              GoRoute(
                path: 'settings',
                name: 'notification-settings',
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const NotificationSettingsScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/conversations',
            name: 'conversations',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const ConversationsScreen(),
            ),
          ),
          GoRoute(
            path: '/chat/:conversationId',
            name: 'chat',
            pageBuilder: (context, state) {
              final conversationId = state.pathParameters['conversationId']!;
              return MaterialPage(
                key: state.pageKey,
                child: ChatScreen(conversationId: conversationId),
              );
            },
          ),
        ],
      ),
    ],
  );
});
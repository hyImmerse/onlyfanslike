import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/repositories/user_repository.dart';
import 'package:creator_platform_demo/domain/repositories/creator_repository.dart';
import 'package:creator_platform_demo/domain/repositories/content_repository.dart';
import 'package:creator_platform_demo/domain/repositories/subscription_repository.dart';
import 'package:creator_platform_demo/domain/repositories/payment_history_repository.dart';
import 'package:creator_platform_demo/data/repositories/mock_user_repository.dart';
import 'package:creator_platform_demo/data/repositories/mock_creator_repository.dart';
import 'package:creator_platform_demo/data/repositories/mock_content_repository.dart';
// import 'package:creator_platform_demo/data/repositories/firebase_content_repository.dart'; // Firebase 패키지 설치 후 주석 해제
import 'package:creator_platform_demo/data/repositories/mock_subscription_repository.dart';
import 'package:creator_platform_demo/data/repositories/mock_payment_history_repository.dart';

/// Repository Providers - Centralized repository management
/// 
/// These providers expose repository instances to the entire application.
/// Using Provider ensures single instances are created and reused throughout the app.

/// User Repository Provider
/// Provides access to user-related operations (login, register, profile management)
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return MockUserRepository();
});

/// Creator Repository Provider
/// Provides access to creator-related operations (search, profile, becoming creator)
final creatorRepositoryProvider = Provider<CreatorRepository>((ref) {
  return MockCreatorRepository();
});

/// Content Repository Provider
/// Provides access to content-related operations (upload, view, manage content)
final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  // Firebase가 설치되지 않은 경우 임시로 Mock 사용
  return MockContentRepository();
  // Firebase 설치 후 아래 라인으로 변경:
  // return FirebaseContentRepository();
});

/// Subscription Repository Provider
/// Provides access to subscription-related operations (subscribe, unsubscribe, revenue)
final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  return MockSubscriptionRepository();
});

/// Payment History Repository Provider
/// Provides access to payment history operations (payments, statistics, refunds)
final paymentHistoryRepositoryProvider = Provider<PaymentHistoryRepository>((ref) {
  return MockPaymentHistoryRepository();
});

/// Repository Provider Container
/// Groups all repository providers for easy access and management
class RepositoryProviders {
  static final user = userRepositoryProvider;
  static final creator = creatorRepositoryProvider;
  static final content = contentRepositoryProvider;
  static final subscription = subscriptionRepositoryProvider;
  static final paymentHistory = paymentHistoryRepositoryProvider;
}
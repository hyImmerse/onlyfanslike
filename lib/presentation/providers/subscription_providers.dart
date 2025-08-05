import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/subscription.dart';
import 'package:creator_platform_demo/presentation/providers/repository_providers.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';

/// Subscription Status Provider
/// Checks if current user is subscribed to a specific creator
final subscriptionStatusProvider = FutureProvider.family<bool, String>((ref, creatorId) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return false;
  
  final subscriptionRepository = ref.watch(RepositoryProviders.subscription);
  return await subscriptionRepository.isSubscribed(currentUser.id, creatorId);
});

/// User Subscriptions Provider
/// Gets all subscriptions for the current user
final userSubscriptionsProvider = FutureProvider<List<Subscription>>((ref) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return [];
  
  final subscriptionRepository = ref.watch(RepositoryProviders.subscription);
  return await subscriptionRepository.getUserSubscriptions(currentUser.id);
});

/// Creator Subscriber Count Provider
/// Gets subscriber count for a specific creator
final creatorSubscriberCountProvider = FutureProvider.family<int, String>((ref, creatorId) async {
  final subscriptionRepository = ref.watch(RepositoryProviders.subscription);
  return await subscriptionRepository.getSubscriberCount(creatorId);
});

/// Subscription Action Notifier
/// Manages subscription/unsubscription actions
final subscriptionActionProvider = StateNotifierProvider<SubscriptionActionNotifier, SubscriptionActionState>((ref) {
  final subscriptionRepository = ref.watch(RepositoryProviders.subscription);
  final currentUser = ref.watch(currentUserProvider);
  return SubscriptionActionNotifier(subscriptionRepository, currentUser?.id);
});

/// Subscription Action State
class SubscriptionActionState {
  const SubscriptionActionState({
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.successMessage,
  });

  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final String? successMessage;

  SubscriptionActionState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    String? successMessage,
  }) {
    return SubscriptionActionState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

/// Subscription Action Notifier
class SubscriptionActionNotifier extends StateNotifier<SubscriptionActionState> {
  SubscriptionActionNotifier(this._subscriptionRepository, this._currentUserId) 
      : super(const SubscriptionActionState());

  final dynamic _subscriptionRepository;
  final String? _currentUserId;

  /// Subscribe to a creator
  Future<void> subscribe(String creatorId, String planId) async {
    if (_currentUserId == null) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '로그인이 필요합니다',
      );
      return;
    }

    try {
      state = state.copyWith(isLoading: true, hasError: false);
      
      await _subscriptionRepository.subscribe(
        userId: _currentUserId!,
        creatorId: creatorId,
        planId: planId,
      );
      
      state = state.copyWith(
        isLoading: false,
        successMessage: '구독이 완료되었습니다!',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  /// Unsubscribe from a creator
  Future<void> unsubscribe(String subscriptionId) async {
    try {
      state = state.copyWith(isLoading: true, hasError: false);
      
      await _subscriptionRepository.unsubscribe(subscriptionId);
      
      state = state.copyWith(
        isLoading: false,
        successMessage: '구독이 해지되었습니다',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  /// Clear messages
  void clearMessages() {
    state = state.copyWith(
      hasError: false,
      errorMessage: null,
      successMessage: null,
    );
  }
}

/// Creator Revenue Provider (Simple)
/// Gets monthly revenue for a creator
final creatorMonthlyRevenueProvider = FutureProvider.family<double, String>((ref, creatorId) async {
  final subscriptionRepository = ref.watch(RepositoryProviders.subscription);
  return await subscriptionRepository.getMonthlyRevenue(creatorId);
});

/// Creator Revenue Provider (Dashboard)
/// Gets comprehensive revenue data for creator dashboard
final creatorRevenueProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, creatorId) async {
  final subscriptionRepository = ref.watch(RepositoryProviders.subscription);
  final subscriberCount = await subscriptionRepository.getSubscriberCount(creatorId);
  final monthlyRevenue = await subscriptionRepository.getMonthlyRevenue(creatorId);
  
  // Calculate revenue metrics (assuming 10,000 won per subscription for demo)
  final totalRevenue = subscriberCount * 10000 * 6; // 6 months average
  
  return {
    'totalRevenue': totalRevenue,
    'monthlyRevenue': monthlyRevenue.toInt(),
    'pendingRevenue': (monthlyRevenue * 0.3).toInt(), // 30% as pending
    'subscriberCount': subscriberCount,
    'newSubscribersThisMonth': (subscriberCount * 0.2).toInt(), // Mock data
    'churnRate': 0.05, // 5% churn rate mock
  };
});
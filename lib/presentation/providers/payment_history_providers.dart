import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/payment_history.dart';
import 'package:creator_platform_demo/domain/repositories/payment_history_repository.dart';
import 'package:creator_platform_demo/presentation/providers/repository_providers.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';

/// Payment History State Management
/// Manages payment history data and operations

/// User Payment History Provider
/// Fetches the current user's payment history
final userPaymentHistoryProvider = FutureProvider.autoDispose<List<PaymentHistory>>((ref) async {
  final repository = ref.watch(paymentHistoryRepositoryProvider);
  final authState = ref.watch(authStateNotifierProvider);
  
  if (!authState.isAuthenticated || authState.user == null) {
    return [];
  }
  
  return repository.getUserPaymentHistory(authState.user!.id);
});

/// Filtered User Payment History Provider
/// Fetches payment history with filters
final filteredUserPaymentHistoryProvider = FutureProvider.autoDispose
    .family<List<PaymentHistory>, PaymentHistoryFilter>((ref, filter) async {
  final repository = ref.watch(paymentHistoryRepositoryProvider);
  final authState = ref.watch(authStateNotifierProvider);
  
  if (!authState.isAuthenticated || authState.user == null) {
    return [];
  }
  
  return repository.getUserPaymentHistory(
    authState.user!.id,
    limit: filter.limit,
    offset: filter.offset,
    status: filter.status,
    type: filter.type,
    startDate: filter.startDate,
    endDate: filter.endDate,
  );
});

/// Creator Payment History Provider
/// Fetches payment history for a specific creator
final creatorPaymentHistoryProvider = FutureProvider.autoDispose
    .family<List<PaymentHistory>, String>((ref, creatorId) async {
  final repository = ref.watch(paymentHistoryRepositoryProvider);
  
  return repository.getCreatorPaymentHistory(creatorId);
});

/// User Payment Statistics Provider
/// Fetches payment statistics for the current user
final userPaymentStatisticsProvider = FutureProvider.autoDispose<PaymentStatistics>((ref) async {
  final repository = ref.watch(paymentHistoryRepositoryProvider);
  final authState = ref.watch(authStateNotifierProvider);
  
  if (!authState.isAuthenticated || authState.user == null) {
    return const PaymentStatistics(
      totalAmount: 0,
      totalCount: 0,
      thisMonthAmount: 0,
      thisMonthCount: 0,
      lastMonthAmount: 0,
      lastMonthCount: 0,
      averageAmount: 0.0,
      successRate: 0.0,
      paymentsByMethod: {},
      paymentsByType: {},
      monthlyTrend: [],
    );
  }
  
  return repository.getUserPaymentStatistics(authState.user!.id);
});

/// Creator Payment Statistics Provider
/// Fetches payment statistics for a specific creator
final creatorPaymentStatisticsProvider = FutureProvider.autoDispose
    .family<PaymentStatistics, String>((ref, creatorId) async {
  final repository = ref.watch(paymentHistoryRepositoryProvider);
  
  return repository.getCreatorPaymentStatistics(creatorId);
});

/// Payment History Detail Provider
/// Fetches details of a specific payment
final paymentHistoryDetailProvider = FutureProvider.autoDispose
    .family<PaymentHistory?, String>((ref, paymentId) async {
  final repository = ref.watch(paymentHistoryRepositoryProvider);
  
  return repository.getPaymentHistory(paymentId);
});

/// Subscription Payment History Provider
/// Fetches payment history for a specific subscription
final subscriptionPaymentHistoryProvider = FutureProvider.autoDispose
    .family<List<PaymentHistory>, String>((ref, subscriptionId) async {
  final repository = ref.watch(paymentHistoryRepositoryProvider);
  
  return repository.getSubscriptionPaymentHistory(subscriptionId);
});

/// Payment History Actions Provider
/// Provides payment history action methods
final paymentHistoryActionsProvider = Provider<PaymentHistoryActions>((ref) {
  final repository = ref.watch(paymentHistoryRepositoryProvider);
  
  return PaymentHistoryActions(repository);
});

/// Payment History Actions Class
/// Encapsulates payment history operations
class PaymentHistoryActions {
  const PaymentHistoryActions(this._repository);
  
  final PaymentHistoryRepository _repository;
  
  /// Create a new payment history entry
  Future<PaymentHistory> createPayment(PaymentHistory payment) async {
    return _repository.createPaymentHistory(payment);
  }
  
  /// Process a refund
  Future<PaymentHistory> processRefund(String paymentId, String reason) async {
    return _repository.processRefund(paymentId, reason);
  }
}

/// Payment History Filter Class
/// Defines filtering options for payment history
class PaymentHistoryFilter {
  const PaymentHistoryFilter({
    this.limit = 20,
    this.offset = 0,
    this.status,
    this.type,
    this.startDate,
    this.endDate,
  });
  
  final int limit;
  final int offset;
  final PaymentStatus? status;
  final PaymentType? type;
  final DateTime? startDate;
  final DateTime? endDate;
  
  PaymentHistoryFilter copyWith({
    int? limit,
    int? offset,
    PaymentStatus? status,
    PaymentType? type,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return PaymentHistoryFilter(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      status: status ?? this.status,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

/// Payment History State Notifier
/// Manages complex payment history operations and local state
class PaymentHistoryStateNotifier extends StateNotifier<PaymentHistoryState> {
  PaymentHistoryStateNotifier(this._repository) 
      : super(const PaymentHistoryState());
  
  final PaymentHistoryRepository _repository;
  
  /// Load payment history with pagination
  Future<void> loadPaymentHistory(String userId, {
    bool refresh = false,
    PaymentHistoryFilter? filter,
  }) async {
    if (state.isLoading && !refresh) return;
    
    try {
      if (refresh || state.payments.isEmpty) {
        state = state.copyWith(isLoading: true, error: null);
      } else {
        state = state.copyWith(isLoadingMore: true);
      }
      
      final payments = await _repository.getUserPaymentHistory(
        userId,
        limit: filter?.limit ?? 20,
        offset: refresh ? 0 : state.payments.length,
        status: filter?.status,
        type: filter?.type,
        startDate: filter?.startDate,
        endDate: filter?.endDate,
      );
      
      if (refresh) {
        state = state.copyWith(
          payments: payments,
          isLoading: false,
          hasMore: payments.length >= (filter?.limit ?? 20),
        );
      } else {
        state = state.copyWith(
          payments: [...state.payments, ...payments],
          isLoadingMore: false,
          hasMore: payments.length >= (filter?.limit ?? 20),
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }
  
  /// Apply filter to payment history
  void applyFilter(PaymentHistoryFilter filter) {
    state = state.copyWith(filter: filter);
  }
  
  /// Clear all data
  void clear() {
    state = const PaymentHistoryState();
  }
}

/// Payment History State Class
/// Represents the state of payment history operations
class PaymentHistoryState {
  const PaymentHistoryState({
    this.payments = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.filter,
  });
  
  final List<PaymentHistory> payments;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final PaymentHistoryFilter? filter;
  
  PaymentHistoryState copyWith({
    List<PaymentHistory>? payments,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    PaymentHistoryFilter? filter,
  }) {
    return PaymentHistoryState(
      payments: payments ?? this.payments,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      filter: filter ?? this.filter,
    );
  }
}

/// Payment History State Notifier Provider
final paymentHistoryStateNotifierProvider = 
    StateNotifierProvider<PaymentHistoryStateNotifier, PaymentHistoryState>((ref) {
  final repository = ref.watch(paymentHistoryRepositoryProvider);
  return PaymentHistoryStateNotifier(repository);
});
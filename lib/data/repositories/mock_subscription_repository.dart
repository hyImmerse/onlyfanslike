import 'package:creator_platform_demo/domain/entities/subscription.dart';
import 'package:creator_platform_demo/domain/repositories/subscription_repository.dart';
import 'package:creator_platform_demo/data/models/subscription_model.dart';

class MockSubscriptionRepository implements SubscriptionRepository {
  static final List<SubscriptionModel> _mockSubscriptions = [
    // User 2 subscribed to TechGuru (c1)
    SubscriptionModel(
      id: 'sub_1',
      userId: '2',
      creatorId: 'c1',
      planId: 'plan_basic_c1',
      status: SubscriptionStatus.active,
      startDate: DateTime.now().subtract(const Duration(days: 45)),
      endDate: DateTime.now().add(const Duration(days: 15)),
      amount: 9.99,
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
      updatedAt: DateTime.now().subtract(const Duration(days: 45)),
    ),
    
    // User 2 subscribed to CookingChef (c5)
    SubscriptionModel(
      id: 'sub_2',
      userId: '2',
      creatorId: 'c5',
      planId: 'plan_basic_c5',
      status: SubscriptionStatus.active,
      startDate: DateTime.now().subtract(const Duration(days: 20)),
      endDate: DateTime.now().add(const Duration(days: 40)),
      amount: 8.99,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    
    // User 1 subscribed to ArtMaster (c2)
    SubscriptionModel(
      id: 'sub_3',
      userId: '1',
      creatorId: 'c2',
      planId: 'plan_basic_c2',
      status: SubscriptionStatus.active,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now().add(const Duration(days: 30)),
      amount: 12.99,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    
    // User 3 subscribed to FitnessCoach (c3) but cancelled
    SubscriptionModel(
      id: 'sub_4',
      userId: '3',
      creatorId: 'c3',
      planId: 'plan_basic_c3',
      status: SubscriptionStatus.cancelled,
      startDate: DateTime.now().subtract(const Duration(days: 60)),
      endDate: DateTime.now().subtract(const Duration(days: 10)),
      amount: 14.99,
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      updatedAt: DateTime.now().subtract(const Duration(days: 50)),
    ),
    
    // User 4 subscribed to MusicProducer (c4)
    SubscriptionModel(
      id: 'sub_5',
      userId: '4',
      creatorId: 'c4',
      planId: 'plan_basic_c4',
      status: SubscriptionStatus.active,
      startDate: DateTime.now().subtract(const Duration(days: 10)),
      endDate: DateTime.now().add(const Duration(days: 50)),
      amount: 11.99,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    
    // User 5 subscription expired
    SubscriptionModel(
      id: 'sub_6',
      userId: '5',
      creatorId: 'c1',
      planId: 'plan_basic_c1',
      status: SubscriptionStatus.expired,
      startDate: DateTime.now().subtract(const Duration(days: 90)),
      endDate: DateTime.now().subtract(const Duration(days: 5)),
      amount: 9.99,
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  @override
  Future<List<Subscription>> getUserSubscriptions(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final userSubscriptions = _mockSubscriptions
        .where((sub) => sub.userId == userId)
        .toList();
    
    // Sort by creation date (most recent first)
    userSubscriptions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    
    return userSubscriptions.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Subscription>> getCreatorSubscribers(String creatorId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final creatorSubscriptions = _mockSubscriptions
        .where((sub) => sub.creatorId == creatorId)
        .toList();
    
    // Sort by creation date (most recent first)
    creatorSubscriptions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    
    return creatorSubscriptions.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Subscription?> getSubscription(String userId, String creatorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final subscriptionModel = _mockSubscriptions
        .where((sub) => sub.userId == userId && sub.creatorId == creatorId)
        .firstOrNull;
    
    return subscriptionModel?.toEntity();
  }

  @override
  Future<Subscription> subscribe({
    required String userId,
    required String creatorId,
    required String planId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    
    // Check if user is already subscribed
    final existingSubscription = _mockSubscriptions
        .where((sub) => 
            sub.userId == userId && 
            sub.creatorId == creatorId && 
            sub.status == SubscriptionStatus.active)
        .firstOrNull;
    
    if (existingSubscription != null) {
      throw Exception('User is already subscribed to this creator');
    }
    
    // Mock subscription prices based on creator
    double amount = 9.99; // Default price
    switch (creatorId) {
      case 'c1': amount = 9.99; break;
      case 'c2': amount = 12.99; break;
      case 'c3': amount = 14.99; break;
      case 'c4': amount = 11.99; break;
      case 'c5': amount = 8.99; break;
    }
    
    // Create new subscription
    final newSubscriptionModel = SubscriptionModel(
      id: 'sub_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      creatorId: creatorId,
      planId: planId,
      status: SubscriptionStatus.active,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)), // Monthly subscription
      amount: amount,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _mockSubscriptions.add(newSubscriptionModel);
    
    return newSubscriptionModel.toEntity();
  }

  @override
  Future<void> unsubscribe(String subscriptionId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final index = _mockSubscriptions.indexWhere((sub) => sub.id == subscriptionId);
    if (index == -1) {
      throw Exception('Subscription not found');
    }
    
    // Update subscription status to cancelled
    final subscription = _mockSubscriptions[index];
    _mockSubscriptions[index] = subscription.copyWith(
      status: SubscriptionStatus.cancelled,
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<bool> isSubscribed(String userId, String creatorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final activeSubscription = _mockSubscriptions
        .where((sub) => 
            sub.userId == userId && 
            sub.creatorId == creatorId && 
            sub.status == SubscriptionStatus.active &&
            sub.endDate != null &&
            sub.endDate!.isAfter(DateTime.now()))
        .firstOrNull;
    
    return activeSubscription != null;
  }

  @override
  Future<int> getSubscriberCount(String creatorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final activeSubscriptions = _mockSubscriptions
        .where((sub) => 
            sub.creatorId == creatorId && 
            sub.status == SubscriptionStatus.active &&
            sub.endDate != null &&
            sub.endDate!.isAfter(DateTime.now()))
        .length;
    
    return activeSubscriptions;
  }

  @override
  Future<double> getMonthlyRevenue(String creatorId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    
    final monthlySubscriptions = _mockSubscriptions
        .where((sub) => 
            sub.creatorId == creatorId && 
            sub.status == SubscriptionStatus.active &&
            sub.startDate.isBefore(now) &&
            (sub.endDate == null || sub.endDate!.isAfter(startOfMonth)))
        .toList();
    
    double totalRevenue = 0.0;
    for (final sub in monthlySubscriptions) {
      totalRevenue += sub.amount;
    }
    
    return totalRevenue;
  }
}
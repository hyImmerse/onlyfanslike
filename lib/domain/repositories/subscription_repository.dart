import 'package:creator_platform_demo/domain/entities/subscription.dart';

abstract class SubscriptionRepository {
  Future<List<Subscription>> getUserSubscriptions(String userId);
  Future<List<Subscription>> getCreatorSubscribers(String creatorId);
  Future<Subscription?> getSubscription(String userId, String creatorId);
  Future<Subscription> subscribe({
    required String userId,
    required String creatorId,
    required String planId,
  });
  Future<void> unsubscribe(String subscriptionId);
  Future<bool> isSubscribed(String userId, String creatorId);
  Future<int> getSubscriberCount(String creatorId);
  Future<double> getMonthlyRevenue(String creatorId);
}
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

enum SubscriptionStatus { active, cancelled, expired, pending }

@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required String id,
    required String userId,
    required String creatorId,
    required String tierId,
    required String tierName,
    required String planId,
    required int price,
    required int amount,
    required SubscriptionStatus status,
    required DateTime startDate,
    DateTime? endDate,
    DateTime? cancelledAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Subscription;
  
  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);
}
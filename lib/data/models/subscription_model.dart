import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:creator_platform_demo/domain/entities/subscription.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

@freezed
class SubscriptionModel with _$SubscriptionModel {
  const factory SubscriptionModel({
    required String id,
    required String userId,
    required String creatorId,
    required String planId,
    required SubscriptionStatus status,
    required DateTime startDate,
    DateTime? endDate,
    required double amount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubscriptionModel;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => _$SubscriptionModelFromJson(json);

  factory SubscriptionModel.fromEntity(Subscription subscription) => SubscriptionModel(
    id: subscription.id,
    userId: subscription.userId,
    creatorId: subscription.creatorId,
    planId: subscription.planId,
    status: subscription.status,
    startDate: subscription.startDate,
    endDate: subscription.endDate,
    amount: subscription.amount,
    createdAt: subscription.createdAt,
    updatedAt: subscription.updatedAt,
  );
}

extension SubscriptionModelX on SubscriptionModel {
  Subscription toEntity() => Subscription(
    id: id,
    userId: userId,
    creatorId: creatorId,
    planId: planId,
    status: status,
    startDate: startDate,
    endDate: endDate,
    amount: amount,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
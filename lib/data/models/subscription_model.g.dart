// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionModelImpl _$$SubscriptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      creatorId: json['creatorId'] as String,
      planId: json['planId'] as String,
      status: $enumDecode(_$SubscriptionStatusEnumMap, json['status']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      amount: (json['amount'] as num).toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SubscriptionModelImplToJson(
        _$SubscriptionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'creatorId': instance.creatorId,
      'planId': instance.planId,
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'amount': instance.amount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.active: 'active',
  SubscriptionStatus.cancelled: 'cancelled',
  SubscriptionStatus.expired: 'expired',
  SubscriptionStatus.pending: 'pending',
};

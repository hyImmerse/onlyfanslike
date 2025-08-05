// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentHistoryImpl _$$PaymentHistoryImplFromJson(Map<String, dynamic> json) =>
    _$PaymentHistoryImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      creatorId: json['creatorId'] as String?,
      subscriptionId: json['subscriptionId'] as String?,
      contentId: json['contentId'] as String?,
      type: $enumDecode(_$PaymentTypeEnumMap, json['type']),
      method: $enumDecode(_$PaymentMethodEnumMap, json['method']),
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      amount: (json['amount'] as num).toInt(),
      currency: json['currency'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      transactionId: json['transactionId'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      failureReason: json['failureReason'] as String?,
      refundedAt: json['refundedAt'] == null
          ? null
          : DateTime.parse(json['refundedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PaymentHistoryImplToJson(
        _$PaymentHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'creatorId': instance.creatorId,
      'subscriptionId': instance.subscriptionId,
      'contentId': instance.contentId,
      'type': _$PaymentTypeEnumMap[instance.type]!,
      'method': _$PaymentMethodEnumMap[instance.method]!,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'amount': instance.amount,
      'currency': instance.currency,
      'title': instance.title,
      'description': instance.description,
      'transactionId': instance.transactionId,
      'receiptUrl': instance.receiptUrl,
      'metadata': instance.metadata,
      'failureReason': instance.failureReason,
      'refundedAt': instance.refundedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PaymentTypeEnumMap = {
  PaymentType.subscription: 'subscription',
  PaymentType.oneTimePayment: 'oneTimePayment',
  PaymentType.tip: 'tip',
  PaymentType.refund: 'refund',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.creditCard: 'creditCard',
  PaymentMethod.debitCard: 'debitCard',
  PaymentMethod.bankTransfer: 'bankTransfer',
  PaymentMethod.digitalWallet: 'digitalWallet',
  PaymentMethod.inAppPurchase: 'inAppPurchase',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.cancelled: 'cancelled',
  PaymentStatus.refunded: 'refunded',
};

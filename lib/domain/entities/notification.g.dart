// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      message: json['message'] as String,
      priority: $enumDecodeNullable(
              _$NotificationPriorityEnumMap, json['priority']) ??
          NotificationPriority.normal,
      status:
          $enumDecodeNullable(_$NotificationStatusEnumMap, json['status']) ??
              NotificationStatus.unread,
      imageUrl: json['imageUrl'] as String?,
      actionUrl: json['actionUrl'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      relatedId: json['relatedId'] as String?,
      senderUserId: json['senderUserId'] as String?,
      senderUserName: json['senderUserName'] as String?,
      scheduledAt: json['scheduledAt'] == null
          ? null
          : DateTime.parse(json['scheduledAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'message': instance.message,
      'priority': _$NotificationPriorityEnumMap[instance.priority]!,
      'status': _$NotificationStatusEnumMap[instance.status]!,
      'imageUrl': instance.imageUrl,
      'actionUrl': instance.actionUrl,
      'metadata': instance.metadata,
      'relatedId': instance.relatedId,
      'senderUserId': instance.senderUserId,
      'senderUserName': instance.senderUserName,
      'scheduledAt': instance.scheduledAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.payment: 'payment',
  NotificationType.subscription: 'subscription',
  NotificationType.content: 'content',
  NotificationType.message: 'message',
  NotificationType.system: 'system',
  NotificationType.creator: 'creator',
  NotificationType.promotion: 'promotion',
};

const _$NotificationPriorityEnumMap = {
  NotificationPriority.low: 'low',
  NotificationPriority.normal: 'normal',
  NotificationPriority.high: 'high',
  NotificationPriority.urgent: 'urgent',
};

const _$NotificationStatusEnumMap = {
  NotificationStatus.unread: 'unread',
  NotificationStatus.read: 'read',
  NotificationStatus.archived: 'archived',
};

_$NotificationStatisticsImpl _$$NotificationStatisticsImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationStatisticsImpl(
      totalCount: (json['totalCount'] as num).toInt(),
      unreadCount: (json['unreadCount'] as num).toInt(),
      readCount: (json['readCount'] as num).toInt(),
      archivedCount: (json['archivedCount'] as num).toInt(),
      countByType: (json['countByType'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$NotificationTypeEnumMap, k), (e as num).toInt()),
      ),
      countByPriority: (json['countByPriority'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$NotificationPriorityEnumMap, k), (e as num).toInt()),
      ),
      lastNotificationAt: DateTime.parse(json['lastNotificationAt'] as String),
      averageReadTime: (json['averageReadTime'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$NotificationStatisticsImplToJson(
        _$NotificationStatisticsImpl instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'unreadCount': instance.unreadCount,
      'readCount': instance.readCount,
      'archivedCount': instance.archivedCount,
      'countByType': instance.countByType
          .map((k, e) => MapEntry(_$NotificationTypeEnumMap[k]!, e)),
      'countByPriority': instance.countByPriority
          .map((k, e) => MapEntry(_$NotificationPriorityEnumMap[k]!, e)),
      'lastNotificationAt': instance.lastNotificationAt.toIso8601String(),
      'averageReadTime': instance.averageReadTime,
    };

_$NotificationSettingsImpl _$$NotificationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsImpl(
      userId: json['userId'] as String,
      pushEnabled: json['pushEnabled'] as bool? ?? true,
      emailEnabled: json['emailEnabled'] as bool? ?? true,
      inAppEnabled: json['inAppEnabled'] as bool? ?? true,
      paymentEnabled: json['paymentEnabled'] as bool? ?? true,
      subscriptionEnabled: json['subscriptionEnabled'] as bool? ?? true,
      contentEnabled: json['contentEnabled'] as bool? ?? true,
      messageEnabled: json['messageEnabled'] as bool? ?? true,
      systemEnabled: json['systemEnabled'] as bool? ?? true,
      creatorEnabled: json['creatorEnabled'] as bool? ?? true,
      promotionEnabled: json['promotionEnabled'] as bool? ?? false,
      quietHoursStart: json['quietHoursStart'] as String? ?? '09:00',
      quietHoursEnd: json['quietHoursEnd'] as String? ?? '22:00',
      quietHoursEnabled: json['quietHoursEnabled'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$NotificationSettingsImplToJson(
        _$NotificationSettingsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'pushEnabled': instance.pushEnabled,
      'emailEnabled': instance.emailEnabled,
      'inAppEnabled': instance.inAppEnabled,
      'paymentEnabled': instance.paymentEnabled,
      'subscriptionEnabled': instance.subscriptionEnabled,
      'contentEnabled': instance.contentEnabled,
      'messageEnabled': instance.messageEnabled,
      'systemEnabled': instance.systemEnabled,
      'creatorEnabled': instance.creatorEnabled,
      'promotionEnabled': instance.promotionEnabled,
      'quietHoursStart': instance.quietHoursStart,
      'quietHoursEnd': instance.quietHoursEnd,
      'quietHoursEnabled': instance.quietHoursEnabled,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

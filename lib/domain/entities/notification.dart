import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

enum NotificationType {
  payment,      // 결제 관련
  subscription, // 구독 관련
  content,      // 콘텐츠 관련
  message,      // 메시지 관련
  system,       // 시스템 공지
  creator,      // 크리에이터 활동
  promotion,    // 프로모션/마케팅
}

enum NotificationPriority {
  low,
  normal,
  high,
  urgent,
}

enum NotificationStatus {
  unread,
  read,
  archived,
}

/// NotificationType 한국어 표시 확장
extension NotificationTypeExtension on NotificationType {
  String get displayName {
    switch (this) {
      case NotificationType.payment:
        return '결제';
      case NotificationType.subscription:
        return '구독';
      case NotificationType.content:
        return '콘텐츠';
      case NotificationType.message:
        return '메시지';
      case NotificationType.system:
        return '시스템';
      case NotificationType.creator:
        return '크리에이터';
      case NotificationType.promotion:
        return '프로모션';
    }
  }

  String get icon {
    switch (this) {
      case NotificationType.payment:
        return '💳';
      case NotificationType.subscription:
        return '📅';
      case NotificationType.content:
        return '🎬';
      case NotificationType.message:
        return '💬';
      case NotificationType.system:
        return '🔔';
      case NotificationType.creator:
        return '👤';
      case NotificationType.promotion:
        return '🎉';
    }
  }
}

/// NotificationPriority 한국어 표시 확장
extension NotificationPriorityExtension on NotificationPriority {
  String get displayName {
    switch (this) {
      case NotificationPriority.low:
        return '낮음';
      case NotificationPriority.normal:
        return '보통';
      case NotificationPriority.high:
        return '높음';
      case NotificationPriority.urgent:
        return '긴급';
    }
  }
}

/// NotificationStatus 한국어 표시 확장
extension NotificationStatusExtension on NotificationStatus {
  String get displayName {
    switch (this) {
      case NotificationStatus.unread:
        return '읽지 않음';
      case NotificationStatus.read:
        return '읽음';
      case NotificationStatus.archived:
        return '보관됨';
    }
  }
}

@freezed
class Notification with _$Notification {
  const factory Notification({
    required String id,
    required String userId,
    required NotificationType type,
    required String title,
    required String message,
    @Default(NotificationPriority.normal) NotificationPriority priority,
    @Default(NotificationStatus.unread) NotificationStatus status,
    String? imageUrl,
    String? actionUrl,
    Map<String, dynamic>? metadata,
    String? relatedId,          // 관련 엔티티 ID (결제 ID, 콘텐츠 ID 등)
    String? senderUserId,       // 발신자 ID (메시지 알림 등)
    String? senderUserName,     // 발신자 이름
    DateTime? scheduledAt,      // 예약 전송 시간
    DateTime? expiresAt,        // 만료 시간
    required DateTime createdAt,
    DateTime? readAt,           // 읽은 시간
    DateTime? updatedAt,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}

// Extension for convenient getters
extension NotificationExtension on Notification {
  /// 읽지 않은 알림인지 확인
  bool get isUnread => status == NotificationStatus.unread;

  /// 읽은 알림인지 확인
  bool get isRead => status == NotificationStatus.read;

  /// 보관된 알림인지 확인
  bool get isArchived => status == NotificationStatus.archived;

  /// 긴급 알림인지 확인
  bool get isUrgent => priority == NotificationPriority.urgent;

  /// 만료된 알림인지 확인
  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);

  /// 예약된 알림인지 확인
  bool get isScheduled => scheduledAt != null && DateTime.now().isBefore(scheduledAt!);

  /// 알림 아이콘
  String get typeIcon => type.icon;

  /// 알림 타입 이름
  String get typeName => type.displayName;

  /// 우선순위 이름
  String get priorityName => priority.displayName;

  /// 상태 이름
  String get statusName => status.displayName;

  /// 시간 경과 표시 (예: "1시간 전", "방금 전")
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}개월 전';
    } else if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()}주 전';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}

/// 알림 통계 클래스
@freezed
class NotificationStatistics with _$NotificationStatistics {
  const factory NotificationStatistics({
    required int totalCount,
    required int unreadCount,
    required int readCount,
    required int archivedCount,
    required Map<NotificationType, int> countByType,
    required Map<NotificationPriority, int> countByPriority,
    required DateTime lastNotificationAt,
    @Default(0.0) double averageReadTime, // 평균 읽기까지 걸리는 시간 (시간 단위)
  }) = _NotificationStatistics;

  factory NotificationStatistics.fromJson(Map<String, dynamic> json) =>
      _$NotificationStatisticsFromJson(json);
}

/// 알림 설정 클래스
@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    required String userId,
    @Default(true) bool pushEnabled,        // 푸시 알림 허용
    @Default(true) bool emailEnabled,       // 이메일 알림 허용
    @Default(true) bool inAppEnabled,       // 인앱 알림 허용
    @Default(true) bool paymentEnabled,     // 결제 알림
    @Default(true) bool subscriptionEnabled, // 구독 알림
    @Default(true) bool contentEnabled,     // 콘텐츠 알림
    @Default(true) bool messageEnabled,     // 메시지 알림
    @Default(true) bool systemEnabled,      // 시스템 알림
    @Default(true) bool creatorEnabled,     // 크리에이터 알림
    @Default(false) bool promotionEnabled, // 프로모션 알림
    @Default('09:00') String quietHoursStart, // 무음 시간 시작
    @Default('22:00') String quietHoursEnd,   // 무음 시간 종료
    @Default(true) bool quietHoursEnabled,    // 무음 시간 활성화
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
}

// NotificationSettings Extension
extension NotificationSettingsExtension on NotificationSettings {
  /// 특정 알림 타입이 활성화되어 있는지 확인
  bool isTypeEnabled(NotificationType type) {
    switch (type) {
      case NotificationType.payment:
        return paymentEnabled;
      case NotificationType.subscription:
        return subscriptionEnabled;
      case NotificationType.content:
        return contentEnabled;
      case NotificationType.message:
        return messageEnabled;
      case NotificationType.system:
        return systemEnabled;
      case NotificationType.creator:
        return creatorEnabled;
      case NotificationType.promotion:
        return promotionEnabled;
    }
  }

  /// 현재 무음 시간인지 확인
  bool get isQuietHours {
    if (!quietHoursEnabled) return false;

    final now = DateTime.now();
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    
    return currentTime.compareTo(quietHoursStart) >= 0 && 
           currentTime.compareTo(quietHoursEnd) <= 0;
  }
}
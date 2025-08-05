import 'package:creator_platform_demo/domain/entities/notification.dart';

abstract class NotificationRepository {
  /// 특정 사용자의 알림 조회
  Future<List<Notification>> getUserNotifications(String userId, {
    int limit = 20,
    int offset = 0,
    NotificationType? type,
    NotificationStatus? status,
    NotificationPriority? priority,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// 읽지 않은 알림 조회
  Future<List<Notification>> getUnreadNotifications(String userId, {
    int limit = 50,
    NotificationType? type,
  });

  /// 특정 알림 조회
  Future<Notification?> getNotification(String notificationId);

  /// 알림 생성
  Future<Notification> createNotification(Notification notification);

  /// 알림 읽음 처리
  Future<Notification> markAsRead(String notificationId);

  /// 여러 알림 읽음 처리
  Future<List<Notification>> markMultipleAsRead(List<String> notificationIds);

  /// 모든 알림 읽음 처리
  Future<int> markAllAsRead(String userId);

  /// 알림 보관 처리
  Future<Notification> archiveNotification(String notificationId);

  /// 알림 삭제
  Future<bool> deleteNotification(String notificationId);

  /// 여러 알림 삭제
  Future<int> deleteMultipleNotifications(List<String> notificationIds);

  /// 만료된 알림 정리
  Future<int> cleanupExpiredNotifications();

  /// 사용자의 알림 통계 조회
  Future<NotificationStatistics> getUserNotificationStatistics(String userId);

  /// 사용자의 알림 설정 조회
  Future<NotificationSettings> getUserNotificationSettings(String userId);

  /// 사용자의 알림 설정 업데이트
  Future<NotificationSettings> updateUserNotificationSettings(
    String userId,
    NotificationSettings settings,
  );

  /// 알림 발송 (푸시, 이메일 등)
  Future<bool> sendNotification(Notification notification, {
    bool sendPush = true,
    bool sendEmail = false,
    bool sendInApp = true,
  });

  /// 예약 알림 발송
  Future<bool> scheduleNotification(Notification notification, DateTime scheduledAt);

  /// 알림 템플릿 기반 생성
  Future<Notification> createNotificationFromTemplate({
    required String userId,
    required NotificationType type,
    required String templateKey,
    required Map<String, dynamic> variables,
    String? relatedId,
    String? senderUserId,
    NotificationPriority priority = NotificationPriority.normal,
  });

  /// 타입별 알림 개수 조회
  Future<Map<NotificationType, int>> getNotificationCountsByType(String userId);

  /// 읽지 않은 알림 개수 조회
  Future<int> getUnreadNotificationCount(String userId);

  /// 특정 기간의 알림 조회
  Future<List<Notification>> getNotificationsByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    NotificationType? type,
  });

  /// 관련 ID로 알림 조회 (예: 특정 결제의 모든 알림)
  Future<List<Notification>> getNotificationsByRelatedId(String relatedId);

  /// 발신자별 알림 조회 (메시지 알림 등)
  Future<List<Notification>> getNotificationsBySender({
    required String userId,
    required String senderUserId,
    int limit = 20,
    int offset = 0,
  });
}
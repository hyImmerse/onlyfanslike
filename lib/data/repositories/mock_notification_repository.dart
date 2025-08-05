import 'package:creator_platform_demo/domain/entities/notification.dart';
import 'package:creator_platform_demo/domain/repositories/notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  static final List<Notification> _mockNotifications = [
    // 최근 알림들 (User 1 - john@example.com)
    Notification(
      id: 'notif_001',
      userId: '1',
      type: NotificationType.payment,
      title: '결제 완료',
      message: 'ArtMaster 구독 결제가 완료되었습니다. (12,990원)',
      priority: NotificationPriority.high,
      status: NotificationStatus.unread,
      relatedId: 'pay_001',
      actionUrl: '/payment-history',
      metadata: {
        'payment_amount': 12990,
        'creator_name': 'ArtMaster',
        'subscription_plan': 'Basic Plan',
      },
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),

    Notification(
      id: 'notif_002',
      userId: '1',
      type: NotificationType.content,
      title: '새 콘텐츠 업로드',
      message: 'TechGuru님이 새로운 React 강의를 업로드했습니다.',
      priority: NotificationPriority.normal,
      status: NotificationStatus.unread,
      relatedId: 'content_premium_01',
      senderUserId: 'c1',
      senderUserName: 'TechGuru',
      actionUrl: '/home/content/content_premium_01',
      imageUrl: 'https://picsum.photos/200/200?random=1',
      metadata: {
        'content_title': 'React 고급 패턴 완전정복',
        'content_type': 'video',
        'duration': '2시간 30분',
      },
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),

    Notification(
      id: 'notif_003',
      userId: '1',
      type: NotificationType.message,
      title: '새 메시지',
      message: 'FitnessCoach님이 메시지를 보냈습니다: "후원 감사합니다!"',
      priority: NotificationPriority.normal,
      status: NotificationStatus.read,
      senderUserId: 'c3',
      senderUserName: 'FitnessCoach',
      actionUrl: '/messages/c3',
      metadata: {
        'message_preview': '후원 감사합니다!',
        'conversation_id': 'conv_001',
      },
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      readAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),

    Notification(
      id: 'notif_004',
      userId: '1',
      type: NotificationType.subscription,
      title: '구독 갱신 안내',
      message: 'ArtMaster 구독이 3일 후 자동 갱신됩니다.',
      priority: NotificationPriority.normal,
      status: NotificationStatus.read,
      relatedId: 'sub_3',
      actionUrl: '/subscription/sub_3',
      metadata: {
        'creator_name': 'ArtMaster',
        'renewal_date': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
        'amount': 12990,
      },
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      readAt: DateTime.now().subtract(const Duration(hours: 20)),
    ),

    Notification(
      id: 'notif_005',
      userId: '1',
      type: NotificationType.system,
      title: '서비스 업데이트',
      message: '새로운 기능이 추가되었습니다. 결제 내역 페이지를 확인해보세요!',
      priority: NotificationPriority.low,
      status: NotificationStatus.read,
      actionUrl: '/payment-history',
      imageUrl: 'https://picsum.photos/200/200?random=2',
      metadata: {
        'version': '1.2.0',
        'features': ['결제 내역', '필터링', '통계'],
      },
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      readAt: DateTime.now().subtract(const Duration(days: 1)),
    ),

    Notification(
      id: 'notif_006',
      userId: '1',
      type: NotificationType.creator,
      title: '크리에이터 활동',
      message: 'MusicMaker님이 라이브 방송을 시작했습니다.',
      priority: NotificationPriority.high,
      status: NotificationStatus.archived,
      senderUserId: 'c4',
      senderUserName: 'MusicMaker',
      actionUrl: '/live/c4',
      expiresAt: DateTime.now().add(const Duration(hours: 2)),
      metadata: {
        'live_title': '로파이 힙합 비트 만들기',
        'viewer_count': 0,
      },
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      readAt: DateTime.now().subtract(const Duration(days: 2)),
    ),

    Notification(
      id: 'notif_007',
      userId: '1',
      type: NotificationType.promotion,
      title: '특별 할인 이벤트',
      message: '신규 구독자 대상 30% 할인! 지금 바로 확인하세요.',
      priority: NotificationPriority.normal,
      status: NotificationStatus.read,
      actionUrl: '/promotion/new-user-discount',
      imageUrl: 'https://picsum.photos/200/200?random=3',
      expiresAt: DateTime.now().add(const Duration(days: 7)),
      metadata: {
        'discount_rate': 30,
        'event_code': 'NEWUSER30',
        'valid_until': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
      },
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      readAt: DateTime.now().subtract(const Duration(days: 3)),
    ),

    // 결제 실패 알림
    Notification(
      id: 'notif_008',
      userId: '1',
      type: NotificationType.payment,
      title: '결제 실패',
      message: 'CookingChef 구독 결제가 실패했습니다. 결제 수단을 확인해주세요.',
      priority: NotificationPriority.urgent,
      status: NotificationStatus.read,
      relatedId: 'pay_006',
      actionUrl: '/payment-history',
      metadata: {
        'failure_reason': '카드 한도 초과',
        'creator_name': 'CookingChef',
        'amount': 8000,
      },
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      readAt: DateTime.now().subtract(const Duration(days: 6)),
    ),

    // User 2의 알림들
    Notification(
      id: 'notif_009',
      userId: '2',
      type: NotificationType.subscription,
      title: '구독 시작',
      message: 'TechGuru 구독이 시작되었습니다. 프리미엄 콘텐츠를 즐겨보세요!',
      priority: NotificationPriority.high,
      status: NotificationStatus.read,
      relatedId: 'sub_1',
      actionUrl: '/home/creator/c1',
      metadata: {
        'creator_name': 'TechGuru',
        'plan_name': 'Basic Plan',
        'amount': 9990,
      },
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      readAt: DateTime.now().subtract(const Duration(days: 1)),
    ),

    Notification(
      id: 'notif_010',
      userId: '2',
      type: NotificationType.content,
      title: '새 콘텐츠 알림',
      message: 'CookingChef님이 새로운 레시피를 공유했습니다.',
      priority: NotificationPriority.normal,
      status: NotificationStatus.unread,
      senderUserId: 'c5',
      senderUserName: 'CookingChef',
      actionUrl: '/home/creator/c5',
      imageUrl: 'https://picsum.photos/200/200?random=4',
      metadata: {
        'content_title': '간단한 파스타 만들기',
        'content_type': 'recipe',
      },
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),

    // 만료 예정 알림
    Notification(
      id: 'notif_011',
      userId: '1',
      type: NotificationType.system,
      title: '임시 공지',
      message: '시스템 점검이 예정되어 있습니다.',
      priority: NotificationPriority.low,
      status: NotificationStatus.unread,
      actionUrl: '/system/maintenance',
      expiresAt: DateTime.now().subtract(const Duration(hours: 1)), // 이미 만료됨
      metadata: {
        'maintenance_date': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
        'duration': '2시간',
      },
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),

    // 예약된 알림 (미래)
    Notification(
      id: 'notif_012',
      userId: '1',
      type: NotificationType.subscription,
      title: '구독 만료 예정',
      message: 'ArtMaster 구독이 내일 만료됩니다.',
      priority: NotificationPriority.high,
      status: NotificationStatus.unread,
      scheduledAt: DateTime.now().add(const Duration(hours: 1)), // 1시간 후 발송
      relatedId: 'sub_3',
      actionUrl: '/subscription/sub_3',
      metadata: {
        'creator_name': 'ArtMaster',
        'expiry_date': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
      },
      createdAt: DateTime.now(),
    ),
  ];

  static NotificationSettings _mockSettings = NotificationSettings(
    userId: '1',
    pushEnabled: true,
    emailEnabled: true,
    inAppEnabled: true,
    paymentEnabled: true,
    subscriptionEnabled: true,
    contentEnabled: true,
    messageEnabled: true,
    systemEnabled: true,
    creatorEnabled: true,
    promotionEnabled: false,
    quietHoursStart: '22:00',
    quietHoursEnd: '08:00',
    quietHoursEnabled: true,
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  );

  @override
  Future<List<Notification>> getUserNotifications(String userId, {
    int limit = 20,
    int offset = 0,
    NotificationType? type,
    NotificationStatus? status,
    NotificationPriority? priority,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var filtered = _mockNotifications.where((notification) {
      if (notification.userId != userId) return false;
      if (type != null && notification.type != type) return false;
      if (status != null && notification.status != status) return false;
      if (priority != null && notification.priority != priority) return false;
      if (startDate != null && notification.createdAt.isBefore(startDate)) return false;
      if (endDate != null && notification.createdAt.isAfter(endDate)) return false;
      
      // 만료된 알림 제외 (시스템 알림 제외)
      if (notification.isExpired && notification.type != NotificationType.system) {
        return false;
      }
      
      return true;
    }).toList();

    // 최신 순으로 정렬
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // 페이지네이션
    final start = offset;
    final end = (start + limit).clamp(0, filtered.length);

    if (start >= filtered.length) return [];

    return filtered.sublist(start, end);
  }

  @override
  Future<List<Notification>> getUnreadNotifications(String userId, {
    int limit = 50,
    NotificationType? type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    var unread = _mockNotifications.where((notification) {
      if (notification.userId != userId) return false;
      if (notification.status != NotificationStatus.unread) return false;
      if (type != null && notification.type != type) return false;
      if (notification.isExpired) return false;
      return true;
    }).toList();

    unread.sort((a, b) {
      // 우선순위별 정렬 (긴급 > 높음 > 보통 > 낮음)
      final priorityOrder = {
        NotificationPriority.urgent: 0,
        NotificationPriority.high: 1,
        NotificationPriority.normal: 2,
        NotificationPriority.low: 3,
      };
      final priorityCompare = priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
      if (priorityCompare != 0) return priorityCompare;
      
      // 같은 우선순위면 최신 순
      return b.createdAt.compareTo(a.createdAt);
    });

    return unread.take(limit).toList();
  }

  @override
  Future<Notification?> getNotification(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      return _mockNotifications.firstWhere((notification) => notification.id == notificationId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Notification> createNotification(Notification notification) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final newId = 'notif_${DateTime.now().millisecondsSinceEpoch}';
    final newNotification = notification.copyWith(
      id: newId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _mockNotifications.add(newNotification);
    return newNotification;
  }

  @override
  Future<Notification> markAsRead(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _mockNotifications.indexWhere((n) => n.id == notificationId);
    if (index == -1) {
      throw Exception('알림을 찾을 수 없습니다.');
    }

    final notification = _mockNotifications[index];
    final updatedNotification = notification.copyWith(
      status: NotificationStatus.read,
      readAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _mockNotifications[index] = updatedNotification;
    return updatedNotification;
  }

  @override
  Future<List<Notification>> markMultipleAsRead(List<String> notificationIds) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final updatedNotifications = <Notification>[];
    final now = DateTime.now();

    for (final id in notificationIds) {
      final index = _mockNotifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        final notification = _mockNotifications[index];
        final updatedNotification = notification.copyWith(
          status: NotificationStatus.read,
          readAt: now,
          updatedAt: now,
        );
        _mockNotifications[index] = updatedNotification;
        updatedNotifications.add(updatedNotification);
      }
    }

    return updatedNotifications;
  }

  @override
  Future<int> markAllAsRead(String userId) async {
    await Future.delayed(const Duration(milliseconds: 800));

    int count = 0;
    final now = DateTime.now();

    for (int i = 0; i < _mockNotifications.length; i++) {
      final notification = _mockNotifications[i];
      if (notification.userId == userId && notification.status == NotificationStatus.unread) {
        _mockNotifications[i] = notification.copyWith(
          status: NotificationStatus.read,
          readAt: now,
          updatedAt: now,
        );
        count++;
      }
    }

    return count;
  }

  @override
  Future<Notification> archiveNotification(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _mockNotifications.indexWhere((n) => n.id == notificationId);
    if (index == -1) {
      throw Exception('알림을 찾을 수 없습니다.');
    }

    final notification = _mockNotifications[index];
    final updatedNotification = notification.copyWith(
      status: NotificationStatus.archived,
      updatedAt: DateTime.now(),
    );

    _mockNotifications[index] = updatedNotification;
    return updatedNotification;
  }

  @override
  Future<bool> deleteNotification(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _mockNotifications.indexWhere((n) => n.id == notificationId);
    if (index == -1) return false;

    _mockNotifications.removeAt(index);
    return true;
  }

  @override
  Future<int> deleteMultipleNotifications(List<String> notificationIds) async {
    await Future.delayed(const Duration(milliseconds: 500));

    int count = 0;
    for (final id in notificationIds.reversed) {
      if (await deleteNotification(id)) {
        count++;
      }
    }
    return count;
  }

  @override
  Future<int> cleanupExpiredNotifications() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final initialCount = _mockNotifications.length;
    _mockNotifications.removeWhere((notification) => notification.isExpired);
    return initialCount - _mockNotifications.length;
  }

  @override
  Future<NotificationStatistics> getUserNotificationStatistics(String userId) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final userNotifications = _mockNotifications
        .where((notification) => notification.userId == userId)
        .toList();

    final countByType = <NotificationType, int>{};
    final countByPriority = <NotificationPriority, int>{};

    int unreadCount = 0;
    int readCount = 0;
    int archivedCount = 0;
    DateTime? lastNotificationAt;

    for (final notification in userNotifications) {
      // 상태별 카운트
      switch (notification.status) {
        case NotificationStatus.unread:
          unreadCount++;
          break;
        case NotificationStatus.read:
          readCount++;
          break;
        case NotificationStatus.archived:
          archivedCount++;
          break;
      }

      // 타입별 카운트
      countByType[notification.type] = (countByType[notification.type] ?? 0) + 1;

      // 우선순위별 카운트
      countByPriority[notification.priority] = (countByPriority[notification.priority] ?? 0) + 1;

      // 마지막 알림 시간
      if (lastNotificationAt == null || notification.createdAt.isAfter(lastNotificationAt)) {
        lastNotificationAt = notification.createdAt;
      }
    }

    // 평균 읽기 시간 계산 (읽은 알림 중)
    final readNotifications = userNotifications.where((n) => n.readAt != null).toList();
    double averageReadTime = 0.0;
    if (readNotifications.isNotEmpty) {
      final totalReadTime = readNotifications.fold<double>(0.0, (sum, notification) {
        final readTime = notification.readAt!.difference(notification.createdAt).inMinutes;
        return sum + readTime;
      });
      averageReadTime = totalReadTime / readNotifications.length / 60; // 시간 단위로 변환
    }

    return NotificationStatistics(
      totalCount: userNotifications.length,
      unreadCount: unreadCount,
      readCount: readCount,
      archivedCount: archivedCount,
      countByType: countByType,
      countByPriority: countByPriority,
      lastNotificationAt: lastNotificationAt ?? DateTime.now(),
      averageReadTime: averageReadTime,
    );
  }

  @override
  Future<NotificationSettings> getUserNotificationSettings(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockSettings.copyWith(userId: userId);
  }

  @override
  Future<NotificationSettings> updateUserNotificationSettings(
    String userId,
    NotificationSettings settings,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    _mockSettings = settings.copyWith(
      userId: userId,
      updatedAt: DateTime.now(),
    );

    return _mockSettings;
  }

  @override
  Future<bool> sendNotification(Notification notification, {
    bool sendPush = true,
    bool sendEmail = false,
    bool sendInApp = true,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // 실제 구현에서는 푸시 알림 서비스, 이메일 서비스 등을 호출
    // 데모에서는 로깅 대신 성공으로 처리
    // TODO: 실제 푸시 알림, 이메일 서비스 연동

    return true;
  }

  @override
  Future<bool> scheduleNotification(Notification notification, DateTime scheduledAt) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final scheduledNotification = notification.copyWith(
      scheduledAt: scheduledAt,
    );

    await createNotification(scheduledNotification);
    return true;
  }

  @override
  Future<Notification> createNotificationFromTemplate({
    required String userId,
    required NotificationType type,
    required String templateKey,
    required Map<String, dynamic> variables,
    String? relatedId,
    String? senderUserId,
    NotificationPriority priority = NotificationPriority.normal,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    // 템플릿 기반 알림 생성 로직
    String title = '알림';
    String message = '새로운 알림이 있습니다.';

    switch (templateKey) {
      case 'payment_success':
        title = '결제 완료';
        message = '${variables['creator_name']} 구독 결제가 완료되었습니다. (${variables['amount']}원)';
        break;
      case 'content_uploaded':
        title = '새 콘텐츠 업로드';
        message = '${variables['creator_name']}님이 새로운 콘텐츠를 업로드했습니다.';
        break;
      case 'message_received':
        title = '새 메시지';
        message = '${variables['sender_name']}님이 메시지를 보냈습니다.';
        break;
    }

    final notification = Notification(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      type: type,
      title: title,
      message: message,
      priority: priority,
      relatedId: relatedId,
      senderUserId: senderUserId,
      metadata: variables,
      createdAt: DateTime.now(),
    );

    return await createNotification(notification);
  }

  @override
  Future<Map<NotificationType, int>> getNotificationCountsByType(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final userNotifications = _mockNotifications
        .where((notification) => notification.userId == userId)
        .toList();

    final countsByType = <NotificationType, int>{};
    for (final notification in userNotifications) {
      countsByType[notification.type] = (countsByType[notification.type] ?? 0) + 1;
    }

    return countsByType;
  }

  @override
  Future<int> getUnreadNotificationCount(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    return _mockNotifications
        .where((notification) =>
            notification.userId == userId &&
            notification.status == NotificationStatus.unread &&
            !notification.isExpired)
        .length;
  }

  @override
  Future<List<Notification>> getNotificationsByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    NotificationType? type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    return _mockNotifications.where((notification) {
      if (notification.userId != userId) return false;
      if (notification.createdAt.isBefore(startDate)) return false;
      if (notification.createdAt.isAfter(endDate)) return false;
      if (type != null && notification.type != type) return false;
      return true;
    }).toList();
  }

  @override
  Future<List<Notification>> getNotificationsByRelatedId(String relatedId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _mockNotifications
        .where((notification) => notification.relatedId == relatedId)
        .toList();
  }

  @override
  Future<List<Notification>> getNotificationsBySender({
    required String userId,
    required String senderUserId,
    int limit = 20,
    int offset = 0,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final filtered = _mockNotifications.where((notification) {
      return notification.userId == userId && notification.senderUserId == senderUserId;
    }).toList();

    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final start = offset;
    final end = (start + limit).clamp(0, filtered.length);

    if (start >= filtered.length) return [];

    return filtered.sublist(start, end);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/app_notification.dart';
import 'package:creator_platform_demo/domain/repositories/notification_repository.dart';
import 'package:creator_platform_demo/presentation/providers/repository_providers.dart';

/// 알림 상태 클래스
class NotificationState {
  final List<AppNotification> notifications;
  final int unreadCount;
  final bool isLoading;
  final String? error;
  final NotificationSettings? settings;

  const NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
    this.isLoading = false,
    this.error,
    this.settings,
  });

  NotificationState copyWith({
    List<AppNotification>? notifications,
    int? unreadCount,
    bool? isLoading,
    String? error,
    NotificationSettings? settings,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      settings: settings ?? this.settings,
    );
  }
}

/// 알림 StateNotifier
class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository _repository;
  final String _userId = '1'; // 실제로는 auth provider에서 가져와야 함

  NotificationNotifier(this._repository) : super(const NotificationState()) {
    loadNotifications();
    loadUnreadCount();
    loadSettings();
  }

  /// 알림 목록 로드
  Future<void> loadNotifications({
    NotificationType? type,
    NotificationStatus? status,
    int limit = 50,
    int offset = 0,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final notifications = await _repository.getUserNotifications(
        _userId,
        type: type,
        status: status,
        limit: limit,
        offset: offset,
      );

      state = state.copyWith(
        notifications: notifications,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// 읽지 않은 알림 개수 로드
  Future<void> loadUnreadCount() async {
    try {
      final count = await _repository.getUnreadNotificationCount(_userId);
      state = state.copyWith(unreadCount: count);
    } catch (e) {
      // 에러 무시 (UI에서 카운트만 업데이트하지 않음)
    }
  }

  /// 알림 설정 로드
  Future<void> loadSettings() async {
    try {
      final settings = await _repository.getUserNotificationSettings(_userId);
      state = state.copyWith(settings: settings);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 특정 알림을 읽음으로 처리
  Future<void> markAsRead(String notificationId) async {
    try {
      await _repository.markAsRead(notificationId);
      
      // 로컬 상태 업데이트
      final updatedNotifications = state.notifications.map((notification) {
        if (notification.id == notificationId) {
          return notification.copyWith(
            status: NotificationStatus.read,
            readAt: DateTime.now(),
          );
        }
        return notification;
      }).toList();

      state = state.copyWith(notifications: updatedNotifications);
      await loadUnreadCount(); // 읽지 않은 개수 업데이트
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 여러 알림을 읽음으로 처리
  Future<void> markMultipleAsRead(List<String> notificationIds) async {
    try {
      await _repository.markMultipleAsRead(notificationIds);
      
      // 로컬 상태 업데이트
      final updatedNotifications = state.notifications.map((notification) {
        if (notificationIds.contains(notification.id)) {
          return notification.copyWith(
            status: NotificationStatus.read,
            readAt: DateTime.now(),
          );
        }
        return notification;
      }).toList();

      state = state.copyWith(notifications: updatedNotifications);
      await loadUnreadCount();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 모든 알림을 읽음으로 처리
  Future<void> markAllAsRead() async {
    try {
      await _repository.markAllAsRead(_userId);
      
      // 로컬 상태 업데이트
      final updatedNotifications = state.notifications.map((notification) {
        if (notification.status == NotificationStatus.unread) {
          return notification.copyWith(
            status: NotificationStatus.read,
            readAt: DateTime.now(),
          );
        }
        return notification;
      }).toList();

      state = state.copyWith(
        notifications: updatedNotifications,
        unreadCount: 0,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 알림을 보관함으로 이동
  Future<void> archiveNotification(String notificationId) async {
    try {
      await _repository.archiveNotification(notificationId);
      
      // 로컬 상태 업데이트
      final updatedNotifications = state.notifications.map((notification) {
        if (notification.id == notificationId) {
          return notification.copyWith(status: NotificationStatus.archived);
        }
        return notification;
      }).toList();

      state = state.copyWith(notifications: updatedNotifications);
      await loadUnreadCount();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 알림 삭제
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _repository.deleteNotification(notificationId);
      
      // 로컬 상태 업데이트
      final updatedNotifications = state.notifications
          .where((notification) => notification.id != notificationId)
          .toList();

      state = state.copyWith(notifications: updatedNotifications);
      await loadUnreadCount();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 읽지 않은 알림만 가져오기
  Future<void> loadUnreadNotifications() async {
    await loadNotifications(status: NotificationStatus.unread);
  }

  /// 보관된 알림만 가져오기
  Future<void> loadArchivedNotifications() async {
    await loadNotifications(status: NotificationStatus.archived);
  }

  /// 특정 유형의 알림만 가져오기
  Future<void> loadNotificationsByType(NotificationType type) async {
    await loadNotifications(type: type);
  }

  /// 알림 설정 업데이트
  Future<void> updateSettings(NotificationSettings settings) async {
    try {
      final updatedSettings = await _repository.updateUserNotificationSettings(
        _userId,
        settings,
      );
      state = state.copyWith(settings: updatedSettings);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 새 알림 생성 (테스트용)
  Future<void> createNotification(AppNotification notification) async {
    try {
      await _repository.createNotification(notification);
      await loadNotifications(); // 목록 새로고침
      await loadUnreadCount();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 에러 클리어
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// 상태 새로고침
  Future<void> refresh() async {
    await Future.wait([
      loadNotifications(),
      loadUnreadCount(),
      loadSettings(),
    ]);
  }
}

/// 알림 Provider
final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return NotificationNotifier(repository);
});

/// 읽지 않은 알림 개수만을 위한 Provider
final unreadNotificationCountProvider = Provider<int>((ref) {
  return ref.watch(notificationProvider).unreadCount;
});

/// 알림 설정을 위한 Provider
final notificationSettingsProvider = Provider<NotificationSettings?>((ref) {
  return ref.watch(notificationProvider).settings;
});

/// 알림 로딩 상태 Provider
final notificationLoadingProvider = Provider<bool>((ref) {
  return ref.watch(notificationProvider).isLoading;
});

/// 알림 에러 상태 Provider
final notificationErrorProvider = Provider<String?>((ref) {
  return ref.watch(notificationProvider).error;
});

/// 특정 유형의 알림 통계 Provider
final notificationStatisticsProvider = FutureProvider<NotificationStatistics>((ref) async {
  final repository = ref.watch(notificationRepositoryProvider);
  return repository.getUserNotificationStatistics('1');
});

/// 실시간 알림 스트림 Provider (실제 구현에서는 WebSocket이나 FCM 사용)
final realTimeNotificationProvider = StreamProvider<Notification>((ref) {
  // 실제 구현에서는 WebSocket이나 FCM으로 실시간 알림을 받아야 함
  // 데모용으로 빈 스트림 반환
  return Stream.empty();
});

/// 알림 액션 헬퍼 클래스
class NotificationActions {
  final WidgetRef ref;

  NotificationActions(this.ref);

  /// 알림을 읽음으로 처리하고 해당 화면으로 이동
  Future<void> handleNotificationTap(AppNotification notification) async {
    // 읽지 않은 알림이면 읽음으로 처리
    if (notification.status == NotificationStatus.unread) {
      await ref.read(notificationProvider.notifier).markAsRead(notification.id);
    }

    // 액션 URL이 있으면 해당 화면으로 이동
    if (notification.actionUrl != null) {
      // TODO: 라우팅 구현
      // Navigator.pushNamed(context, notification.actionUrl!);
    }
  }

  /// 알림 유형에 따른 아이콘 반환
  static IconData getTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.payment:
        return Icons.payment;
      case NotificationType.subscription:
        return Icons.subscriptions;
      case NotificationType.content:
        return Icons.video_library;
      case NotificationType.message:
        return Icons.message;
      case NotificationType.system:
        return Icons.settings;
      case NotificationType.creator:
        return Icons.person;
      case NotificationType.promotion:
        return Icons.local_offer;
    }
  }

  /// 알림 유형에 따른 색상 반환
  static Color getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.payment:
        return Colors.green;
      case NotificationType.subscription:
        return Colors.blue;
      case NotificationType.content:
        return Colors.purple;
      case NotificationType.message:
        return Colors.orange;
      case NotificationType.system:
        return Colors.grey;
      case NotificationType.creator:
        return Colors.pink;
      case NotificationType.promotion:
        return Colors.amber;
    }
  }

  /// 우선순위에 따른 색상 반환
  static Color getPriorityColor(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.low:
        return Colors.grey;
      case NotificationPriority.normal:
        return Colors.blue;
      case NotificationPriority.high:
        return Colors.orange;
      case NotificationPriority.urgent:
        return Colors.red;
    }
  }
}
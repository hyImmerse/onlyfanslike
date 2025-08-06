// Re-export notification entities with app-specific naming to avoid conflicts with Flutter's Notification
export 'notification.dart' 
  show 
    NotificationType,
    NotificationPriority, 
    NotificationStatus,
    NotificationSettings,
    NotificationStatistics;

// Hide the conflicting Notification class, use AppNotification instead
export 'notification.dart' hide Notification;

// Create an alias for our notification class
import 'notification.dart' as notification_entities;
typedef AppNotification = notification_entities.Notification;
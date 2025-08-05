import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/app_notification.dart';
import 'package:creator_platform_demo/presentation/providers/repository_providers.dart';
import 'package:creator_platform_demo/presentation/widgets/app_bar_widget.dart';

/// 알림 화면 - 사용자의 모든 알림을 표시하고 관리
class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  NotificationType? _selectedType;
  NotificationStatus? _selectedStatus;
  bool _isLoading = false;
  List<AppNotification> _notifications = [];
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadNotifications();
    _loadUnreadCount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadNotifications() async {
    setState(() => _isLoading = true);
    try {
      final repository = ref.read(notificationRepositoryProvider);
      final notifications = await repository.getUserNotifications(
        '1', // 현재 사용자 ID (실제로는 auth provider에서 가져와야 함)
        type: _selectedType,
        status: _selectedStatus,
        limit: 50,
      );
      setState(() {
        _notifications = notifications;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('알림을 불러오는데 실패했습니다: $e')),
        );
      }
    }
  }

  Future<void> _loadUnreadCount() async {
    try {
      final repository = ref.read(notificationRepositoryProvider);
      final count = await repository.getUnreadNotificationCount('1');
      setState(() => _unreadCount = count);
    } catch (e) {
      // 에러 무시 (UI 표시는 계속)
    }
  }

  Future<void> _markAsRead(AppNotification notification) async {
    if (notification.status == NotificationStatus.read) return;

    try {
      final repository = ref.read(notificationRepositoryProvider);
      await repository.markAsRead(notification.id);
      await _loadNotifications();
      await _loadUnreadCount();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('알림 읽기 처리에 실패했습니다: $e')),
        );
      }
    }
  }

  Future<void> _markAllAsRead() async {
    try {
      final repository = ref.read(notificationRepositoryProvider);
      await repository.markAllAsRead('1');
      await _loadNotifications();
      await _loadUnreadCount();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('모든 알림을 읽음으로 처리했습니다'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('전체 읽기 처리에 실패했습니다: $e')),
        );
      }
    }
  }

  Future<void> _archiveNotification(AppNotification notification) async {
    try {
      final repository = ref.read(notificationRepositoryProvider);
      await repository.archiveNotification(notification.id);
      await _loadNotifications();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('알림을 보관함으로 이동했습니다'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('알림 보관에 실패했습니다: $e')),
        );
      }
    }
  }

  void _applyFilter(NotificationType? type, NotificationStatus? status) {
    setState(() {
      _selectedType = type;
      _selectedStatus = status;
    });
    _loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '알림',
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                '모두 읽음',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'settings':
                  Navigator.pushNamed(context, '/notifications/settings');
                  break;
                case 'all':
                  _applyFilter(null, null);
                  break;
                case 'unread':
                  _applyFilter(null, NotificationStatus.unread);
                  break;
                case 'payment':
                  _applyFilter(NotificationType.payment, null);
                  break;
                case 'content':
                  _applyFilter(NotificationType.content, null);
                  break;
                case 'message':
                  _applyFilter(NotificationType.message, null);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 16),
                    SizedBox(width: 8),
                    Text('알림 설정'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(value: 'all', child: Text('전체')),
              const PopupMenuItem(value: 'unread', child: Text('읽지 않음')),
              const PopupMenuDivider(),
              const PopupMenuItem(value: 'payment', child: Text('결제 알림')),
              const PopupMenuItem(value: 'content', child: Text('콘텐츠 알림')),
              const PopupMenuItem(value: 'message', child: Text('메시지 알림')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 탭바
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).primaryColor,
              onTap: (index) {
                switch (index) {
                  case 0:
                    _applyFilter(null, null);
                    break;
                  case 1:
                    _applyFilter(null, NotificationStatus.unread);
                    break;
                  case 2:
                    _applyFilter(null, NotificationStatus.archived);
                    break;
                }
              },
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('전체'),
                      if (_notifications.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_notifications.length}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('읽지 않음'),
                      if (_unreadCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$_unreadCount',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Tab(text: '보관함'),
              ],
            ),
          ),
          
          // 알림 목록
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _notifications.isEmpty
                    ? _buildEmptyState()
                    : RefreshIndicator(
                        onRefresh: () async {
                          await _loadNotifications();
                          await _loadUnreadCount();
                        },
                        child: ListView.builder(
                          itemCount: _notifications.length,
                          itemBuilder: (context, index) {
                            final notification = _notifications[index];
                            return _buildNotificationItem(notification);
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    String message = '알림이 없습니다';
    IconData icon = Icons.notifications_none;

    if (_selectedStatus == NotificationStatus.unread) {
      message = '읽지 않은 알림이 없습니다';
      icon = Icons.mark_email_read;
    } else if (_selectedStatus == NotificationStatus.archived) {
      message = '보관된 알림이 없습니다';
      icon = Icons.archive;
    } else if (_selectedType != null) {
      message = '해당 유형의 알림이 없습니다';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(AppNotification notification) {
    final isUnread = notification.status == NotificationStatus.unread;
    final isArchived = notification.status == NotificationStatus.archived;

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.archive,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        _archiveNotification(notification);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        color: isUnread ? Colors.blue[50] : Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getTypeColor(notification.type),
            child: Icon(
              _getTypeIcon(notification.type),
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  notification.title,
                  style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (isUnread)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isUnread ? Colors.black87 : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notification.type.displayName,
                    style: TextStyle(
                      fontSize: 12,
                      color: _getTypeColor(notification.type),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    notification.timeAgo,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'read':
                  _markAsRead(notification);
                  break;
                case 'archive':
                  _archiveNotification(notification);
                  break;
              }
            },
            itemBuilder: (context) => [
              if (isUnread)
                const PopupMenuItem(
                  value: 'read',
                  child: Row(
                    children: [
                      Icon(Icons.mark_email_read, size: 16),
                      SizedBox(width: 8),
                      Text('읽음 처리'),
                    ],
                  ),
                ),
              if (!isArchived)
                const PopupMenuItem(
                  value: 'archive',
                  child: Row(
                    children: [
                      Icon(Icons.archive, size: 16),
                      SizedBox(width: 8),
                      Text('보관하기'),
                    ],
                  ),
                ),
            ],
          ),
          onTap: () {
            _markAsRead(notification);
            // 알림에 액션 URL이 있으면 해당 화면으로 이동
            if (notification.actionUrl != null) {
              // TODO: 라우팅 구현
            }
          },
        ),
      ),
    );
  }

  Color _getTypeColor(NotificationType type) {
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

  IconData _getTypeIcon(NotificationType type) {
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
}
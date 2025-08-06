import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/notification.dart';
import 'package:creator_platform_demo/presentation/providers/notification_provider.dart';
import 'package:creator_platform_demo/presentation/widgets/app_bar_widget.dart';

/// 알림 화면 - 사용자의 모든 알림을 표시하고 관리
/// Material 3 디자인과 NotificationProvider를 활용한 현대적 UI
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
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // 알림 로드 (Provider 사용)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 필터 적용
  void _applyFilter(NotificationType? type, NotificationStatus? status) {
    setState(() {
      _selectedType = type;
      _selectedStatus = status;
    });
    ref.read(notificationProvider.notifier).loadNotifications(
      type: type,
      status: status,
    );
  }

  /// 필터 초기화
  void _clearFilters() {
    setState(() {
      _selectedType = null;
      _selectedStatus = null;
    });
    ref.read(notificationProvider.notifier).loadNotifications();
  }

  /// 알림을 읽음으로 처리
  void _markAsRead(Notification notification) {
    if (notification.status == NotificationStatus.read) return;
    ref.read(notificationProvider.notifier).markAsRead(notification.id);
  }

  /// 모든 알림을 읽음으로 처리
  void _markAllAsRead() {
    ref.read(notificationProvider.notifier).markAllAsRead();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('모든 알림을 읽음으로 처리했습니다'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 알림 보관
  void _archiveNotification(Notification notification) {
    ref.read(notificationProvider.notifier).archiveNotification(notification.id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('알림을 보관함으로 이동했습니다'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 새로고침
  Future<void> _onRefresh() async {
    await ref.read(notificationProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBarWidget(
        title: '알림',
        actions: [
          // 필터 토글 버튼
          IconButton(
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            icon: Icon(
              _showFilters ? Icons.filter_list : Icons.filter_list_outlined,
              color: _selectedType != null || _selectedStatus != null 
                  ? colorScheme.primary 
                  : null,
            ),
            tooltip: '필터',
          ),
          // 모두 읽음 버튼
          if (unreadCount > 0)
            TextButton.icon(
              onPressed: _markAllAsRead,
              icon: Icon(Icons.done_all, size: 16, color: colorScheme.primary),
              label: Text(
                '모두 읽음',
                style: TextStyle(color: colorScheme.primary),
              ),
            ),
          // 설정 버튼
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notifications/settings');
            },
            icon: const Icon(Icons.settings_outlined),
            tooltip: '알림 설정',
          ),
        ],
      ),
      body: Column(
        children: [
          // 필터 섹션
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showFilters ? null : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showFilters ? 1.0 : 0.0,
              child: _showFilters ? _buildFilterSection(colorScheme) : null,
            ),
          ),
          
          // 탭바
          Material(
            color: colorScheme.surface,
            elevation: 1,
            child: TabBar(
              controller: _tabController,
              labelColor: colorScheme.primary,
              unselectedLabelColor: colorScheme.onSurfaceVariant,
              indicatorColor: colorScheme.primary,
              dividerColor: colorScheme.outlineVariant,
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
                _buildTabWithBadge(
                  '전체',
                  notificationState.notifications.length,
                  colorScheme.onSurfaceVariant,
                ),
                _buildTabWithBadge(
                  '읽지 않음',
                  unreadCount,
                  colorScheme.error,
                ),
                const Tab(text: '보관함'),
              ],
            ),
          ),
          
          // 알림 목록
          Expanded(
            child: notificationState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : notificationState.error != null
                    ? _buildErrorState(notificationState.error!, colorScheme)
                    : notificationState.notifications.isEmpty
                        ? _buildEmptyState(colorScheme)
                        : RefreshIndicator(
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: notificationState.notifications.length,
                              itemBuilder: (context, index) {
                                final notification = notificationState.notifications[index];
                                return _buildNotificationCard(notification, colorScheme);
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  /// 필터 섹션 위젯 생성
  Widget _buildFilterSection(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '필터',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              if (_selectedType != null || _selectedStatus != null)
                TextButton.icon(
                  onPressed: _clearFilters,
                  icon: Icon(Icons.clear, size: 16, color: colorScheme.primary),
                  label: Text(
                    '초기화',
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          // 타입별 필터
          Text(
            '알림 타입',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: NotificationType.values.map((type) {
              final isSelected = _selectedType == type;
              return FilterChip(
                selected: isSelected,
                label: Text(type.displayName),
                avatar: Text(type.icon),
                onSelected: (selected) {
                  _applyFilter(selected ? type : null, _selectedStatus);
                },
                backgroundColor: colorScheme.surface,
                selectedColor: colorScheme.secondaryContainer,
                checkmarkColor: colorScheme.onSecondaryContainer,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// 배지가 있는 탭 위젯 생성
  Widget _buildTabWithBadge(String text, int count, Color badgeColor) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          if (count > 0)
            Container(
              margin: const EdgeInsets.only(left: 6),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 빈 상태 위젯
  Widget _buildEmptyState(ColorScheme colorScheme) {
    String message = '알림이 없습니다';
    IconData icon = Icons.notifications_none_outlined;

    if (_selectedStatus == NotificationStatus.unread) {
      message = '읽지 않은 알림이 없습니다';
      icon = Icons.mark_email_read_outlined;
    } else if (_selectedStatus == NotificationStatus.archived) {
      message = '보관된 알림이 없습니다';
      icon = Icons.archive_outlined;
    } else if (_selectedType != null) {
      message = '해당 유형의 알림이 없습니다';
      icon = Icons.filter_list_off_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '새로운 알림이 도착하면 여기에 표시됩니다',
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// 에러 상태 위젯
  Widget _buildErrorState(String error, ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            '알림을 불러올 수 없습니다',
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }

  /// 알림 카드 위젯
  Widget _buildNotificationCard(Notification notification, ColorScheme colorScheme) {
    final isUnread = notification.status == NotificationStatus.unread;
    final isArchived = notification.status == NotificationStatus.archived;
    final typeColor = NotificationActions.getTypeColor(notification.type);
    final priorityColor = NotificationActions.getPriorityColor(notification.priority);

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.archive_outlined,
          color: colorScheme.onErrorContainer,
        ),
      ),
      onDismissed: (direction) {
        _archiveNotification(notification);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        color: isUnread 
            ? colorScheme.secondaryContainer.withOpacity(0.3)
            : colorScheme.surface,
        elevation: isUnread ? 2 : 1,
        child: InkWell(
          onTap: () {
            _markAsRead(notification);
            // TODO: 액션 URL로 이동
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 알림 타입 아이콘
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: typeColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    NotificationActions.getTypeIcon(notification.type),
                    color: typeColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                
                // 알림 내용
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 제목과 읽음 표시
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isUnread ? FontWeight.w600 : FontWeight.w500,
                                color: colorScheme.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      
                      // 메시지
                      Text(
                        notification.message,
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      // 하단 정보
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 타입 및 우선순위
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: typeColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  notification.typeName,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: typeColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (notification.priority == NotificationPriority.urgent ||
                                  notification.priority == NotificationPriority.high) ...[
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: priorityColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    notification.priorityName,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: priorityColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          
                          // 시간
                          Text(
                            notification.timeAgo,
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // 액션 메뉴
                PopupMenuButton<String>(
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
                            Icon(Icons.archive_outlined, size: 16),
                            SizedBox(width: 8),
                            Text('보관하기'),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
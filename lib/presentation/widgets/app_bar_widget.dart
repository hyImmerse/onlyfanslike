import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/presentation/providers/notification_provider.dart';

/// 공통 AppBar 위젯 - 알림 아이콘과 배지 포함
class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final bool showNotificationIcon;
  final VoidCallback? onNotificationTap;

  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.showNotificationIcon = true,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return AppBar(
      title: Text(title),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
      actions: [
        if (showNotificationIcon) ...[
          _buildNotificationIcon(context, unreadCount),
          const SizedBox(width: 8),
        ],
        if (actions != null) ...actions!,
      ],
    );
  }

  Widget _buildNotificationIcon(BuildContext context, int unreadCount) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: onNotificationTap ?? () => _navigateToNotifications(context),
        ),
        if (unreadCount > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                unreadCount > 99 ? '99+' : unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  void _navigateToNotifications(BuildContext context) {
    Navigator.pushNamed(context, '/notifications');
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// 간단한 AppBar 위젯 (알림 아이콘 없음)
class SimpleAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;

  const SimpleAppBarWidget({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// 알림 뱃지만을 위한 독립적인 위젯
class NotificationBadge extends ConsumerWidget {
  final Widget child;
  final VoidCallback? onTap;

  const NotificationBadge({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          child,
          if (unreadCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Text(
                  unreadCount > 99 ? '99+' : unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 플로팅 알림 아이콘 위젯 (홈 화면 등에서 사용)
class FloatingNotificationIcon extends ConsumerWidget {
  final VoidCallback? onTap;

  const FloatingNotificationIcon({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return FloatingActionButton(
      mini: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 2,
      onPressed: onTap ?? () => Navigator.pushNamed(context, '/notifications'),
      child: NotificationBadge(
        onTap: onTap,
        child: const Icon(Icons.notifications_outlined),
      ),
    );
  }
}
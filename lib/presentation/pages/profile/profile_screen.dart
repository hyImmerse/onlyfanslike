import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';
import 'package:creator_platform_demo/presentation/providers/notification_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);
    final currentUser = authState.user;

    return Scaffold(
      appBar: AppBar(title: const Text('프로필')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 프로필 헤더
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // 아바타 이미지
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue[400]!,
                              Colors.blue[600]!,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: currentUser?.profileImageUrl != null
                            ? ClipOval(
                                child: Image.network(
                                  currentUser!.profileImageUrl!,
                                  width: 94,
                                  height: 94,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    );
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                      ),
                      
                      // 온라인 상태 표시 (선택사항)
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // 사용자 이름
                  Text(
                    currentUser?.name ?? '사용자',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // 이메일
                  Text(
                    currentUser?.email ?? 'example@example.com',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // 사용자 타입 배지
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: currentUser?.isCreator == true 
                          ? Colors.purple.withOpacity(0.1)
                          : Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: currentUser?.isCreator == true 
                            ? Colors.purple
                            : Colors.blue,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      currentUser?.isCreator == true ? '크리에이터' : '일반 사용자',
                      style: TextStyle(
                        color: currentUser?.isCreator == true 
                            ? Colors.purple
                            : Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 프로필 편집 버튼
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('프로필 편집 기능 구현 예정')),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('프로필 편집'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('결제 내역'),
              subtitle: const Text('구독, 결제 및 환불 내역 확인'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.go('/payment-history');
              },
            ),
          ),
          Card(
            child: Consumer(
              builder: (context, ref, child) {
                final unreadCount = ref.watch(unreadNotificationCountProvider);
                return ListTile(
                  leading: Stack(
                    children: [
                      const Icon(Icons.notifications_outlined),
                      if (unreadCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: const Text('알림'),
                  subtitle: Text(unreadCount > 0 
                      ? '읽지 않은 알림 ${unreadCount}개'
                      : '알림 설정 및 확인'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    context.go('/notifications');
                  },
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('설정'),
              subtitle: const Text('앱 설정 및 계정 관리'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Settings screen to be implemented
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('설정 화면 구현 예정')),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.help),
              title: const Text('고객 지원'),
              subtitle: const Text('문의 및 도움말'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Support screen to be implemented
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('고객 지원 화면 구현 예정')),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 로그아웃 버튼
          Card(
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.red[600]),
              title: Text(
                '로그아웃',
                style: TextStyle(color: Colors.red[600]),
              ),
              subtitle: const Text('계정에서 로그아웃'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.red[600]),
              onTap: () => _showLogoutDialog(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그아웃'),
          content: const Text('정말로 로그아웃하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(authStateNotifierProvider.notifier).logout();
                context.go('/login');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('로그아웃'),
            ),
          ],
        );
      },
    );
  }
}
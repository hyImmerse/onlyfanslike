import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:creator_platform_demo/domain/entities/message.dart';
import 'package:creator_platform_demo/presentation/providers/chat_provider.dart';

/// 대화 목록 화면
class ConversationsScreen extends ConsumerWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationsProvider);
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('메시지'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('검색 기능은 준비 중입니다')),
              );
            },
          ),
        ],
      ),
      body: conversationsAsync.when(
        data: (conversations) {
          if (conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '아직 대화가 없습니다',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '크리에이터에게 메시지를 보내보세요',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            );
          }
          
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(conversationsProvider);
            },
            child: ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return _ConversationTile(conversation: conversation);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('오류가 발생했습니다: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(conversationsProvider),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 대화 타일 위젯
class _ConversationTile extends StatelessWidget {
  final Conversation conversation;
  
  const _ConversationTile({
    required this.conversation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasUnread = conversation.unreadCount > 0;
    
    return ListTile(
      onTap: () {
        context.push('/chat/${conversation.id}');
      },
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: theme.colorScheme.surfaceVariant,
            backgroundImage: _getUnsplashAvatar(conversation.id),
            child: null, // Always show image
          ),
          if (hasUnread)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.surface,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          if (conversation.isPinned)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(
                Icons.push_pin,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          Expanded(
            child: Text(
              conversation.creatorName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (conversation.isMuted)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(
                Icons.notifications_off,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
      subtitle: Row(
        children: [
          if (conversation.lastMessage != null) ...[
            Expanded(
              child: Text(
                conversation.lastMessage!.content,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: hasUnread 
                      ? theme.colorScheme.onSurface 
                      : theme.colorScheme.onSurfaceVariant,
                  fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _formatTime(conversation.lastMessage!.createdAt),
              style: theme.textTheme.labelSmall?.copyWith(
                color: hasUnread 
                    ? theme.colorScheme.primary 
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ] else ...[
            Text(
              '메시지가 없습니다',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
      trailing: hasUnread
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                conversation.unreadCount.toString(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
  
  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return '방금';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays < 7) {
      return DateFormat('E', 'ko').format(dateTime);
    } else {
      return DateFormat('M/d').format(dateTime);
    }
  }
  
  ImageProvider _getUnsplashAvatar(String conversationId) {
    // Using Unsplash for realistic profile images
    final List<String> profileImages = [
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop', // Male portrait 1
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop', // Female portrait 1
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop', // Female portrait 2
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150&h=150&fit=crop', // Female portrait 3
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop', // Male portrait 2
      'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=150&h=150&fit=crop', // Male portrait 3
      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop', // Male portrait 4
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop', // Female portrait 4
    ];
    
    // Use conversation ID to consistently select same image
    final index = conversationId.hashCode % profileImages.length;
    return NetworkImage(profileImages[index.abs()]);
  }
}
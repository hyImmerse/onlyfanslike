import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:creator_platform_demo/domain/entities/message.dart';

/// 메시지 버블 위젯
class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool showAvatar;
  final VoidCallback? onLongPress;
  
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.showAvatar,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bubbleColor = isMe 
        ? theme.colorScheme.primary 
        : theme.colorScheme.surfaceVariant;
    final textColor = isMe 
        ? theme.colorScheme.onPrimary 
        : theme.colorScheme.onSurfaceVariant;
    
    return Padding(
      padding: EdgeInsets.only(
        left: isMe ? 64 : 0,
        right: isMe ? 0 : 64,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && showAvatar) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              backgroundImage: _getUnsplashAvatar(message.senderId),
              child: _getUnsplashAvatar(message.senderId) == null
                  ? Text(
                      message.senderName.isNotEmpty 
                          ? message.senderName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
          ] else if (!isMe) ...[
            const SizedBox(width: 40),
          ],
          
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe && showAvatar)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 4),
                    child: Text(
                      message.senderName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                
                GestureDetector(
                  onLongPress: onLongPress,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isMe ? 20 : 4),
                        topRight: Radius.circular(isMe ? 4 : 20),
                        bottomLeft: const Radius.circular(20),
                        bottomRight: const Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.replyToMessageId != null)
                          Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onSurface.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 3,
                                  height: 40,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '답장',
                                        style: theme.textTheme.labelSmall?.copyWith(
                                          color: textColor.withOpacity(0.7),
                                        ),
                                      ),
                                      Text(
                                        '원본 메시지...',
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: textColor.withOpacity(0.7),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        _buildMessageContent(context, textColor),
                        
                        const SizedBox(height: 4),
                        
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatTime(message.createdAt),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: textColor.withOpacity(0.7),
                              ),
                            ),
                            if (isMe) ...[
                              const SizedBox(width: 4),
                              Icon(
                                _getStatusIcon(message.status),
                                size: 14,
                                color: textColor.withOpacity(0.7),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMessageContent(BuildContext context, Color textColor) {
    switch (message.type) {
      case MessageType.text:
        return Text(
          message.content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: textColor,
          ),
        );
        
      case MessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                message.attachmentUrls?.first ?? '',
                width: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 200,
                    height: 150,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: const Icon(Icons.broken_image),
                  );
                },
              ),
            ),
            if (message.content.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                message.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ],
        );
        
      case MessageType.video:
        return Row(
          children: [
            const Icon(Icons.play_circle_filled, size: 40),
            const SizedBox(width: 8),
            Text(
              '동영상',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textColor,
              ),
            ),
          ],
        );
        
      case MessageType.audio:
        return Row(
          children: [
            const Icon(Icons.mic, size: 24),
            const SizedBox(width: 8),
            Text(
              '음성 메시지',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textColor,
              ),
            ),
          ],
        );
        
      case MessageType.file:
        return Row(
          children: [
            const Icon(Icons.attach_file, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
        
      case MessageType.system:
        return Text(
          message.content,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: textColor,
            fontStyle: FontStyle.italic,
          ),
        );
    }
  }
  
  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays == 0) {
      // Today - show time
      return DateFormat('HH:mm').format(dateTime);
    } else if (difference.inDays == 1) {
      // Yesterday
      return '어제';
    } else if (difference.inDays < 7) {
      // This week - show day of week
      return DateFormat('E', 'ko').format(dateTime);
    } else {
      // Older - show date
      return DateFormat('M/d').format(dateTime);
    }
  }
  
  IconData _getStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.sending:
        return Icons.access_time;
      case MessageStatus.sent:
        return Icons.check;
      case MessageStatus.delivered:
        return Icons.done_all;
      case MessageStatus.read:
        return Icons.done_all;
      case MessageStatus.failed:
        return Icons.error_outline;
    }
  }
  
  ImageProvider? _getUnsplashAvatar(String userId) {
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
      'https://images.unsplash.com/photo-1504199367641-aba8151af406?w=150&h=150&fit=crop', // Female portrait 5
      'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=150&h=150&fit=crop', // Female portrait 6
    ];
    
    // Use user ID to consistently select same image for same user
    final index = userId.hashCode % profileImages.length;
    return NetworkImage(profileImages[index.abs()]);
  }
}
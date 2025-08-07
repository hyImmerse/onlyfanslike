import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:creator_platform_demo/domain/entities/message.dart';
import 'package:creator_platform_demo/presentation/providers/chat_provider.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';
import 'package:creator_platform_demo/presentation/widgets/chat/message_bubble.dart';
import 'package:creator_platform_demo/presentation/widgets/chat/message_input.dart';

/// 채팅 화면
class ChatScreen extends ConsumerStatefulWidget {
  final String conversationId;
  
  const ChatScreen({
    super.key,
    required this.conversationId,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController _messageController;
  late FocusNode _messageFocusNode;
  bool _isTyping = false;
  Timer? _typingTimer;
  
  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _messageFocusNode = FocusNode();
    _scrollController.addListener(_onScroll);
    
    // Initialize conversation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatProvider.notifier).initializeConversation(widget.conversationId);
    });
  }
  
  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    _scrollController.dispose();
    _typingTimer?.cancel();
    
    // Cleanup conversation
    ref.read(chatProvider.notifier).cleanupConversation(widget.conversationId);
    
    super.dispose();
  }
  
  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      // Load more messages when near bottom
      ref.read(chatProvider.notifier).loadMoreMessages(widget.conversationId);
    }
  }
  
  void _handleTyping(String text) {
    if (text.isNotEmpty && !_isTyping) {
      _isTyping = true;
      ref.read(chatProvider.notifier).updateTypingStatus(widget.conversationId, true);
    }
    
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (_isTyping) {
        _isTyping = false;
        ref.read(chatProvider.notifier).updateTypingStatus(widget.conversationId, false);
      }
    });
  }
  
  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;
    
    _messageController.clear();
    _isTyping = false;
    _typingTimer?.cancel();
    
    await ref.read(chatProvider.notifier).sendMessage(
      conversationId: widget.conversationId,
      content: content,
    );
    
    // Scroll to bottom
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(conversationMessagesProvider(widget.conversationId));
    final isOtherUserTyping = ref.watch(conversationTypingProvider(widget.conversationId));
    final chatState = ref.watch(chatProvider);
    final currentUser = ref.watch(currentUserProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              backgroundImage: _getConversationAvatar(),
              child: _getConversationAvatar() == null
                  ? Icon(
                      Icons.person_outline,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getConversationTitle(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (isOtherUserTyping)
                    Text(
                      '입력 중...',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'mute',
                child: Row(
                  children: [
                    Icon(Icons.notifications_off_outlined),
                    SizedBox(width: 8),
                    Text('알림 끄기'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'pin',
                child: Row(
                  children: [
                    Icon(Icons.push_pin_outlined),
                    SizedBox(width: 8),
                    Text('대화 고정'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'archive',
                child: Row(
                  children: [
                    Icon(Icons.archive_outlined),
                    SizedBox(width: 8),
                    Text('보관하기'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: chatState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: messages.length + (isOtherUserTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (isOtherUserTyping && index == 0) {
                        return _buildTypingIndicator();
                      }
                      
                      final messageIndex = isOtherUserTyping ? index - 1 : index;
                      final message = messages[messageIndex];
                      final isMe = message.senderId == currentUser?.id;
                      final showAvatar = !isMe && (
                        messageIndex == messages.length - 1 ||
                        messages[messageIndex + 1].senderId != message.senderId
                      );
                      
                      return MessageBubble(
                        message: message,
                        isMe: isMe,
                        showAvatar: showAvatar,
                        onLongPress: () => _showMessageOptions(message),
                      );
                    },
                  ),
          ),
          
          // Message input
          MessageInput(
            controller: _messageController,
            focusNode: _messageFocusNode,
            onChanged: _handleTyping,
            onSubmitted: (_) => _sendMessage(),
            onSend: _sendMessage,
            onAttachment: _handleAttachment,
          ),
        ],
      ),
    );
  }
  
  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 80, bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 600 + (index * 200)),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(
              0.3 + (0.7 * value),
            ),
            shape: BoxShape.circle,
          ),
        );
      },
      onEnd: () {
        Future.delayed(Duration(milliseconds: 300 + (index * 100)), () {
          if (mounted) setState(() {});
        });
      },
    );
  }
  
  ImageProvider? _getConversationAvatar() {
    // Using Unsplash for realistic profile images
    // Using specific portrait photos from Unsplash
    final List<String> profileImages = [
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop', // Male portrait 1
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop', // Female portrait 1
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop', // Female portrait 2
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150&h=150&fit=crop', // Female portrait 3
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop', // Male portrait 2
      'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=150&h=150&fit=crop', // Male portrait 3
    ];
    
    // Use conversation ID to consistently select same image
    final index = widget.conversationId.hashCode % profileImages.length;
    return NetworkImage(profileImages[index.abs()]);
  }
  
  String _getConversationTitle() {
    // In a real app, would get from conversation data
    return '크리에이터 이름';
  }
  
  void _handleMenuAction(String action) {
    switch (action) {
      case 'mute':
        // TODO: Implement mute
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('알림이 꺼졌습니다')),
        );
        break;
      case 'pin':
        // TODO: Implement pin
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('대화가 고정되었습니다')),
        );
        break;
      case 'archive':
        // TODO: Implement archive
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('대화가 보관되었습니다')),
        );
        context.pop();
        break;
    }
  }
  
  void _showMessageOptions(Message message) {
    final isMe = message.senderId == ref.read(currentUserProvider)?.id;
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.reply),
              title: const Text('답장'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement reply
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('복사'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement copy
              },
            ),
            if (isMe)
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('삭제'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteMessage(message);
                },
              ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _deleteMessage(Message message) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('메시지 삭제'),
        content: const Text('이 메시지를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await ref.read(chatProvider.notifier).deleteMessage(
        widget.conversationId,
        message.id,
      );
    }
  }
  
  void _handleAttachment() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('사진/동영상'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement photo/video picker
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('파일'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement file picker
              },
            ),
          ],
        ),
      ),
    );
  }
}
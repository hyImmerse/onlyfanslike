import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/message.dart';
import 'package:creator_platform_demo/domain/repositories/chat_repository.dart';
import 'package:creator_platform_demo/presentation/providers/repository_providers.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';

/// 대화 목록 Provider
final conversationsProvider = FutureProvider.autoDispose<List<Conversation>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getConversations(user.id);
});

/// 특정 대화의 메시지 목록 Provider
final messagesProvider = FutureProvider.family<List<Message>, String>((ref, conversationId) async {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getMessages(conversationId: conversationId);
});

/// 채팅 상태 관리 클래스
class ChatState {
  final Map<String, List<Message>> messages;
  final Map<String, bool> isTyping;
  final bool isLoading;
  final String? error;
  
  const ChatState({
    this.messages = const {},
    this.isTyping = const {},
    this.isLoading = false,
    this.error,
  });
  
  ChatState copyWith({
    Map<String, List<Message>>? messages,
    Map<String, bool>? isTyping,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 채팅 StateNotifier
class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository _repository;
  final Ref _ref;
  final Map<String, StreamSubscription> _messageSubscriptions = {};
  final Map<String, StreamSubscription> _typingSubscriptions = {};
  
  ChatNotifier(this._repository, this._ref) : super(const ChatState());
  
  /// 대화 초기화 및 메시지 로드
  Future<void> initializeConversation(String conversationId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Load initial messages
      final messages = await _repository.getMessages(conversationId: conversationId);
      
      state = state.copyWith(
        messages: {...state.messages, conversationId: messages},
        isLoading: false,
      );
      
      // Subscribe to new messages
      _subscribeToMessages(conversationId);
      
      // Subscribe to typing status
      _subscribeToTypingStatus(conversationId);
      
      // Mark messages as read
      final user = _ref.read(currentUserProvider);
      if (user != null) {
        await _repository.markMessagesAsRead(
          conversationId: conversationId,
          userId: user.id,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  
  /// 메시지 전송
  Future<void> sendMessage({
    required String conversationId,
    required String content,
    MessageType type = MessageType.text,
    String? replyToMessageId,
    List<String>? attachmentUrls,
  }) async {
    final user = _ref.read(currentUserProvider);
    if (user == null) return;
    
    try {
      final message = await _repository.sendMessage(
        conversationId: conversationId,
        senderId: user.id,
        content: content,
        type: type,
        replyToMessageId: replyToMessageId,
        attachmentUrls: attachmentUrls,
      );
      
      // Add message to state immediately
      final messages = List<Message>.from(state.messages[conversationId] ?? []);
      messages.insert(0, message);
      
      state = state.copyWith(
        messages: {...state.messages, conversationId: messages},
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
  
  /// 타이핑 상태 업데이트
  Future<void> updateTypingStatus(String conversationId, bool isTyping) async {
    final user = _ref.read(currentUserProvider);
    if (user == null) return;
    
    await _repository.updateTypingStatus(
      conversationId: conversationId,
      userId: user.id,
      isTyping: isTyping,
    );
  }
  
  /// 메시지 삭제
  Future<void> deleteMessage(String conversationId, String messageId) async {
    try {
      await _repository.deleteMessage(messageId);
      
      // Remove from state
      final messages = List<Message>.from(state.messages[conversationId] ?? []);
      messages.removeWhere((m) => m.id == messageId);
      
      state = state.copyWith(
        messages: {...state.messages, conversationId: messages},
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
  
  /// 더 많은 메시지 로드 (페이지네이션)
  Future<void> loadMoreMessages(String conversationId) async {
    final currentMessages = state.messages[conversationId] ?? [];
    if (currentMessages.isEmpty) return;
    
    try {
      final moreMessages = await _repository.getMessages(
        conversationId: conversationId,
        beforeMessageId: currentMessages.last.id,
      );
      
      if (moreMessages.isNotEmpty) {
        final messages = List<Message>.from(currentMessages)..addAll(moreMessages);
        
        state = state.copyWith(
          messages: {...state.messages, conversationId: messages},
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
  
  /// 새 메시지 스트림 구독
  void _subscribeToMessages(String conversationId) {
    _messageSubscriptions[conversationId]?.cancel();
    
    _messageSubscriptions[conversationId] = _repository
        .watchNewMessages(conversationId)
        .listen((message) {
      final messages = List<Message>.from(state.messages[conversationId] ?? []);
      
      // Check if message already exists
      final index = messages.indexWhere((m) => m.id == message.id);
      if (index != -1) {
        // Update existing message
        messages[index] = message;
      } else {
        // Add new message
        messages.insert(0, message);
      }
      
      state = state.copyWith(
        messages: {...state.messages, conversationId: messages},
      );
    });
  }
  
  /// 타이핑 상태 스트림 구독
  void _subscribeToTypingStatus(String conversationId) {
    _typingSubscriptions[conversationId]?.cancel();
    
    final user = _ref.read(currentUserProvider);
    if (user == null) return;
    
    _typingSubscriptions[conversationId] = _repository
        .watchTypingStatus(conversationId)
        .listen((typingStatuses) {
      // Check if other user is typing
      final isOtherUserTyping = typingStatuses.any((s) => s.userId != user.id);
      
      state = state.copyWith(
        isTyping: {...state.isTyping, conversationId: isOtherUserTyping},
      );
    });
  }
  
  /// 대화 정리 (스트림 구독 취소)
  void cleanupConversation(String conversationId) {
    _messageSubscriptions[conversationId]?.cancel();
    _messageSubscriptions.remove(conversationId);
    
    _typingSubscriptions[conversationId]?.cancel();
    _typingSubscriptions.remove(conversationId);
  }
  
  @override
  void dispose() {
    // Cancel all subscriptions
    for (final subscription in _messageSubscriptions.values) {
      subscription.cancel();
    }
    for (final subscription in _typingSubscriptions.values) {
      subscription.cancel();
    }
    super.dispose();
  }
}

/// 채팅 Provider
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatNotifier(repository, ref);
});

/// 특정 대화의 메시지 리스트 Provider
final conversationMessagesProvider = Provider.family<List<Message>, String>((ref, conversationId) {
  final chatState = ref.watch(chatProvider);
  return chatState.messages[conversationId] ?? [];
});

/// 특정 대화의 타이핑 상태 Provider
final conversationTypingProvider = Provider.family<bool, String>((ref, conversationId) {
  final chatState = ref.watch(chatProvider);
  return chatState.isTyping[conversationId] ?? false;
});

/// 대화 생성/가져오기 Provider
final getOrCreateConversationProvider = FutureProvider.family<Conversation, String>((ref, creatorId) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) throw Exception('User not logged in');
  
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getOrCreateConversation(
    creatorId: creatorId,
    subscriberId: user.id,
  );
});
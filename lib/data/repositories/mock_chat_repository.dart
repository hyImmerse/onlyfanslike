import 'dart:async';
import 'dart:math';
import 'package:creator_platform_demo/domain/entities/message.dart';
import 'package:creator_platform_demo/domain/repositories/chat_repository.dart';
import 'package:uuid/uuid.dart';

/// Mock Chat Repository 구현
class MockChatRepository implements ChatRepository {
  final _uuid = const Uuid();
  final _random = Random();
  
  // In-memory storage
  final Map<String, Conversation> _conversations = {};
  final Map<String, List<Message>> _messages = {};
  final Map<String, List<TypingStatus>> _typingStatuses = {};
  
  // Stream controllers
  final _messageStreamController = StreamController<Message>.broadcast();
  final _conversationStreamController = StreamController<Conversation>.broadcast();
  final _typingStreamController = StreamController<List<TypingStatus>>.broadcast();

  MockChatRepository() {
    _initializeMockData();
  }

  void _initializeMockData() {
    // Create mock conversations
    final mockConversations = [
      Conversation(
        id: 'conv1',
        creatorId: 'creator1',
        subscriberId: '1',
        creatorName: '김민수 작가',
        subscriberName: '구독자',
        creatorAvatar: 'https://i.pravatar.cc/150?img=1',
        lastMessage: Message(
          id: 'msg1',
          conversationId: 'conv1',
          senderId: 'creator1',
          senderName: '김민수 작가',
          content: '안녕하세요! 새 콘텐츠 업로드했어요 😊',
          createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        unreadCount: 1,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      Conversation(
        id: 'conv2',
        creatorId: 'creator2',
        subscriberId: '1',
        creatorName: '박지은 PD',
        subscriberName: '구독자',
        creatorAvatar: 'https://i.pravatar.cc/150?img=2',
        lastMessage: Message(
          id: 'msg2',
          conversationId: 'conv2',
          senderId: '1',
          senderName: '구독자',
          content: '콘텐츠 너무 재밌어요!',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        unreadCount: 0,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];

    for (final conv in mockConversations) {
      _conversations[conv.id] = conv;
      _generateMockMessages(conv.id);
    }
  }

  void _generateMockMessages(String conversationId) {
    final messages = <Message>[];
    final now = DateTime.now();
    
    final sampleMessages = [
      '안녕하세요! 구독해주셔서 감사합니다 😊',
      '새로운 콘텐츠 업로드했어요!',
      '오늘은 특별한 라이브 방송이 있을 예정이에요',
      '질문 있으시면 편하게 물어보세요',
      '감사합니다! 항상 응원하고 있어요',
      '다음 콘텐츠도 기대해주세요',
      '피드백 감사합니다 👍',
      '좋은 하루 보내세요!',
    ];

    for (int i = 0; i < 20; i++) {
      final isCreator = _random.nextBool();
      final conv = _conversations[conversationId]!;
      
      messages.add(Message(
        id: _uuid.v4(),
        conversationId: conversationId,
        senderId: isCreator ? conv.creatorId : conv.subscriberId,
        senderName: isCreator ? conv.creatorName : conv.subscriberName,
        senderAvatar: isCreator ? conv.creatorAvatar : null,
        content: sampleMessages[_random.nextInt(sampleMessages.length)],
        status: MessageStatus.read,
        createdAt: now.subtract(Duration(minutes: (20 - i) * 30)),
        readAt: now.subtract(Duration(minutes: (20 - i) * 25)),
      ));
    }
    
    _messages[conversationId] = messages;
  }

  @override
  Future<List<Conversation>> getConversations(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _conversations.values
        .where((conv) => conv.subscriberId == userId || conv.creatorId == userId)
        .toList()
      ..sort((a, b) {
        // Sort by last message time or created time
        final aTime = a.lastMessage?.createdAt ?? a.createdAt;
        final bTime = b.lastMessage?.createdAt ?? b.createdAt;
        return bTime.compareTo(aTime);
      });
  }

  @override
  Future<Conversation?> getConversation(String conversationId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _conversations[conversationId];
  }

  @override
  Future<Conversation> getOrCreateConversation({
    required String creatorId,
    required String subscriberId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Check if conversation already exists
    final existing = _conversations.values.firstWhere(
      (conv) => 
        (conv.creatorId == creatorId && conv.subscriberId == subscriberId) ||
        (conv.creatorId == subscriberId && conv.subscriberId == creatorId),
      orElse: () => Conversation(
        id: '',
        creatorId: '',
        subscriberId: '',
        creatorName: '',
        subscriberName: '',
        unreadCount: 0,
        createdAt: DateTime.now(),
      ),
    );
    
    if (existing.id.isNotEmpty) {
      return existing;
    }
    
    // Create new conversation
    final newConv = Conversation(
      id: _uuid.v4(),
      creatorId: creatorId,
      subscriberId: subscriberId,
      creatorName: '크리에이터',
      subscriberName: '구독자',
      unreadCount: 0,
      createdAt: DateTime.now(),
    );
    
    _conversations[newConv.id] = newConv;
    _messages[newConv.id] = [];
    
    return newConv;
  }

  @override
  Future<List<Message>> getMessages({
    required String conversationId,
    int limit = 50,
    String? beforeMessageId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final messages = _messages[conversationId] ?? [];
    
    if (beforeMessageId != null) {
      final index = messages.indexWhere((m) => m.id == beforeMessageId);
      if (index > 0) {
        return messages.sublist(0, index).take(limit).toList();
      }
    }
    
    return messages.take(limit).toList();
  }

  @override
  Future<Message> sendMessage({
    required String conversationId,
    required String senderId,
    required String content,
    MessageType type = MessageType.text,
    String? replyToMessageId,
    List<String>? attachmentUrls,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final conversation = _conversations[conversationId];
    if (conversation == null) {
      throw Exception('Conversation not found');
    }
    
    final message = Message(
      id: _uuid.v4(),
      conversationId: conversationId,
      senderId: senderId,
      senderName: senderId == conversation.creatorId 
          ? conversation.creatorName 
          : conversation.subscriberName,
      senderAvatar: senderId == conversation.creatorId 
          ? conversation.creatorAvatar 
          : null,
      content: content,
      type: type,
      status: MessageStatus.sent,
      createdAt: DateTime.now(),
      replyToMessageId: replyToMessageId,
      attachmentUrls: attachmentUrls,
    );
    
    // Add to messages
    _messages[conversationId] ??= [];
    _messages[conversationId]!.insert(0, message);
    
    // Update conversation
    final updatedConv = conversation.copyWith(
      lastMessage: message,
      updatedAt: DateTime.now(),
    );
    _conversations[conversationId] = updatedConv;
    
    // Emit to streams
    _messageStreamController.add(message);
    _conversationStreamController.add(updatedConv);
    
    // Simulate message delivery
    Future.delayed(const Duration(seconds: 1), () {
      final deliveredMessage = message.copyWith(status: MessageStatus.delivered);
      final index = _messages[conversationId]!.indexWhere((m) => m.id == message.id);
      if (index != -1) {
        _messages[conversationId]![index] = deliveredMessage;
        _messageStreamController.add(deliveredMessage);
      }
    });
    
    // Simulate auto-reply for demo
    if (senderId == conversation.subscriberId) {
      _simulateAutoReply(conversationId, conversation.creatorId);
    }
    
    return message;
  }

  void _simulateAutoReply(String conversationId, String creatorId) {
    Future.delayed(Duration(seconds: 2 + _random.nextInt(3)), () async {
      final replies = [
        '감사합니다! 😊',
        '좋은 의견 감사해요!',
        '다음 콘텐츠도 기대해주세요',
        '항상 응원해주셔서 힘이 됩니다',
        '궁금한 점이 더 있으시면 말씀해주세요',
      ];
      
      await sendMessage(
        conversationId: conversationId,
        senderId: creatorId,
        content: replies[_random.nextInt(replies.length)],
      );
    });
  }

  @override
  Future<void> markMessagesAsRead({
    required String conversationId,
    required String userId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final messages = _messages[conversationId] ?? [];
    final conversation = _conversations[conversationId];
    
    if (conversation == null) return;
    
    // Mark messages as read
    for (int i = 0; i < messages.length; i++) {
      final message = messages[i];
      if (message.senderId != userId && message.status != MessageStatus.read) {
        messages[i] = message.copyWith(
          status: MessageStatus.read,
          readAt: DateTime.now(),
        );
      }
    }
    
    // Update conversation unread count
    final updatedConv = conversation.copyWith(unreadCount: 0);
    _conversations[conversationId] = updatedConv;
    _conversationStreamController.add(updatedConv);
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    for (final entry in _messages.entries) {
      final index = entry.value.indexWhere((m) => m.id == messageId);
      if (index != -1) {
        entry.value.removeAt(index);
        break;
      }
    }
  }

  @override
  Future<void> archiveConversation(String conversationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final conversation = _conversations[conversationId];
    if (conversation != null) {
      _conversations[conversationId] = conversation.copyWith(isArchived: true);
    }
  }

  @override
  Future<void> muteConversation(String conversationId, bool mute) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final conversation = _conversations[conversationId];
    if (conversation != null) {
      _conversations[conversationId] = conversation.copyWith(isMuted: mute);
    }
  }

  @override
  Future<void> pinConversation(String conversationId, bool pin) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final conversation = _conversations[conversationId];
    if (conversation != null) {
      _conversations[conversationId] = conversation.copyWith(isPinned: pin);
    }
  }

  @override
  Future<void> updateTypingStatus({
    required String conversationId,
    required String userId,
    required bool isTyping,
  }) async {
    _typingStatuses[conversationId] ??= [];
    
    if (isTyping) {
      final status = TypingStatus(
        conversationId: conversationId,
        userId: userId,
        timestamp: DateTime.now(),
      );
      
      _typingStatuses[conversationId]!.removeWhere((s) => s.userId == userId);
      _typingStatuses[conversationId]!.add(status);
    } else {
      _typingStatuses[conversationId]!.removeWhere((s) => s.userId == userId);
    }
    
    _typingStreamController.add(_typingStatuses[conversationId]!);
  }

  @override
  Stream<List<TypingStatus>> watchTypingStatus(String conversationId) {
    return _typingStreamController.stream
        .where((statuses) => statuses.any((s) => s.conversationId == conversationId))
        .map((statuses) => statuses.where((s) => s.conversationId == conversationId).toList());
  }

  @override
  Stream<Message> watchNewMessages(String conversationId) {
    return _messageStreamController.stream
        .where((message) => message.conversationId == conversationId);
  }

  @override
  Stream<Conversation> watchConversation(String conversationId) {
    return _conversationStreamController.stream
        .where((conversation) => conversation.id == conversationId);
  }

  @override
  Future<void> addReaction({
    required String messageId,
    required String userId,
    required String emoji,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // In a real implementation, would store reactions
  }

  @override
  Future<void> removeReaction({
    required String messageId,
    required String userId,
    required String emoji,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // In a real implementation, would remove reactions
  }

  @override
  Future<String> uploadFile(String filePath) async {
    await Future.delayed(const Duration(seconds: 2));
    // In a real implementation, would upload to storage
    return 'https://example.com/uploads/${_uuid.v4()}';
  }

  void dispose() {
    _messageStreamController.close();
    _conversationStreamController.close();
    _typingStreamController.close();
  }
}
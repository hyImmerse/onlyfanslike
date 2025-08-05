import 'package:creator_platform_demo/domain/entities/message.dart';

/// 채팅 Repository 인터페이스
abstract class ChatRepository {
  /// 대화 목록 조회
  Future<List<Conversation>> getConversations(String userId);
  
  /// 특정 대화 조회
  Future<Conversation?> getConversation(String conversationId);
  
  /// 대화 생성 또는 가져오기
  Future<Conversation> getOrCreateConversation({
    required String creatorId,
    required String subscriberId,
  });
  
  /// 메시지 목록 조회
  Future<List<Message>> getMessages({
    required String conversationId,
    int limit = 50,
    String? beforeMessageId,
  });
  
  /// 메시지 전송
  Future<Message> sendMessage({
    required String conversationId,
    required String senderId,
    required String content,
    MessageType type = MessageType.text,
    String? replyToMessageId,
    List<String>? attachmentUrls,
  });
  
  /// 메시지 읽음 처리
  Future<void> markMessagesAsRead({
    required String conversationId,
    required String userId,
  });
  
  /// 메시지 삭제
  Future<void> deleteMessage(String messageId);
  
  /// 대화 아카이브
  Future<void> archiveConversation(String conversationId);
  
  /// 대화 음소거
  Future<void> muteConversation(String conversationId, bool mute);
  
  /// 대화 고정
  Future<void> pinConversation(String conversationId, bool pin);
  
  /// 타이핑 상태 업데이트
  Future<void> updateTypingStatus({
    required String conversationId,
    required String userId,
    required bool isTyping,
  });
  
  /// 타이핑 상태 스트림
  Stream<List<TypingStatus>> watchTypingStatus(String conversationId);
  
  /// 새 메시지 스트림
  Stream<Message> watchNewMessages(String conversationId);
  
  /// 대화 업데이트 스트림
  Stream<Conversation> watchConversation(String conversationId);
  
  /// 메시지 반응 추가
  Future<void> addReaction({
    required String messageId,
    required String userId,
    required String emoji,
  });
  
  /// 메시지 반응 제거
  Future<void> removeReaction({
    required String messageId,
    required String userId,
    required String emoji,
  });
  
  /// 파일 업로드
  Future<String> uploadFile(String filePath);
}
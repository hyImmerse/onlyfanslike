import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

/// 메시지 유형
enum MessageType {
  text,
  image,
  video,
  audio,
  file,
  system,
}

/// 메시지 상태
enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}

/// 메시지 모델
@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String conversationId,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    required String content,
    @Default(MessageType.text) MessageType type,
    @Default(MessageStatus.sent) MessageStatus status,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? readAt,
    
    // 추가 메타데이터
    String? replyToMessageId,
    List<String>? attachmentUrls,
    Map<String, dynamic>? metadata,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}

/// 대화 모델
@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required String creatorId,
    required String subscriberId,
    required String creatorName,
    required String subscriberName,
    String? creatorAvatar,
    String? subscriberAvatar,
    Message? lastMessage,
    required int unreadCount,
    required DateTime createdAt,
    DateTime? updatedAt,
    
    // 대화 설정
    @Default(false) bool isArchived,
    @Default(false) bool isMuted,
    @Default(false) bool isPinned,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
}

/// 타이핑 상태
@freezed
class TypingStatus with _$TypingStatus {
  const factory TypingStatus({
    required String conversationId,
    required String userId,
    required DateTime timestamp,
  }) = _TypingStatus;

  factory TypingStatus.fromJson(Map<String, dynamic> json) => _$TypingStatusFromJson(json);
}

/// 메시지 반응 (이모지)
@freezed
class MessageReaction with _$MessageReaction {
  const factory MessageReaction({
    required String messageId,
    required String userId,
    required String emoji,
    required DateTime createdAt,
  }) = _MessageReaction;

  factory MessageReaction.fromJson(Map<String, dynamic> json) => _$MessageReactionFromJson(json);
}
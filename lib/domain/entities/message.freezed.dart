// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String get id => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String? get senderAvatar => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  MessageType get type => throw _privateConstructorUsedError;
  MessageStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError; // 추가 메타데이터
  String? get replyToMessageId => throw _privateConstructorUsedError;
  List<String>? get attachmentUrls => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {String id,
      String conversationId,
      String senderId,
      String senderName,
      String? senderAvatar,
      String content,
      MessageType type,
      MessageStatus status,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? readAt,
      String? replyToMessageId,
      List<String>? attachmentUrls,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderAvatar = freezed,
    Object? content = null,
    Object? type = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? readAt = freezed,
    Object? replyToMessageId = freezed,
    Object? attachmentUrls = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderAvatar: freezed == senderAvatar
          ? _value.senderAvatar
          : senderAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      replyToMessageId: freezed == replyToMessageId
          ? _value.replyToMessageId
          : replyToMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrls: freezed == attachmentUrls
          ? _value.attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String conversationId,
      String senderId,
      String senderName,
      String? senderAvatar,
      String content,
      MessageType type,
      MessageStatus status,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? readAt,
      String? replyToMessageId,
      List<String>? attachmentUrls,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderAvatar = freezed,
    Object? content = null,
    Object? type = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? readAt = freezed,
    Object? replyToMessageId = freezed,
    Object? attachmentUrls = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$MessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderAvatar: freezed == senderAvatar
          ? _value.senderAvatar
          : senderAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      replyToMessageId: freezed == replyToMessageId
          ? _value.replyToMessageId
          : replyToMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrls: freezed == attachmentUrls
          ? _value._attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {required this.id,
      required this.conversationId,
      required this.senderId,
      required this.senderName,
      this.senderAvatar,
      required this.content,
      this.type = MessageType.text,
      this.status = MessageStatus.sent,
      required this.createdAt,
      this.updatedAt,
      this.readAt,
      this.replyToMessageId,
      final List<String>? attachmentUrls,
      final Map<String, dynamic>? metadata})
      : _attachmentUrls = attachmentUrls,
        _metadata = metadata;

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String id;
  @override
  final String conversationId;
  @override
  final String senderId;
  @override
  final String senderName;
  @override
  final String? senderAvatar;
  @override
  final String content;
  @override
  @JsonKey()
  final MessageType type;
  @override
  @JsonKey()
  final MessageStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? readAt;
// 추가 메타데이터
  @override
  final String? replyToMessageId;
  final List<String>? _attachmentUrls;
  @override
  List<String>? get attachmentUrls {
    final value = _attachmentUrls;
    if (value == null) return null;
    if (_attachmentUrls is EqualUnmodifiableListView) return _attachmentUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Message(id: $id, conversationId: $conversationId, senderId: $senderId, senderName: $senderName, senderAvatar: $senderAvatar, content: $content, type: $type, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, readAt: $readAt, replyToMessageId: $replyToMessageId, attachmentUrls: $attachmentUrls, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderAvatar, senderAvatar) ||
                other.senderAvatar == senderAvatar) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId) &&
            const DeepCollectionEquality()
                .equals(other._attachmentUrls, _attachmentUrls) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      conversationId,
      senderId,
      senderName,
      senderAvatar,
      content,
      type,
      status,
      createdAt,
      updatedAt,
      readAt,
      replyToMessageId,
      const DeepCollectionEquality().hash(_attachmentUrls),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {required final String id,
      required final String conversationId,
      required final String senderId,
      required final String senderName,
      final String? senderAvatar,
      required final String content,
      final MessageType type,
      final MessageStatus status,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final DateTime? readAt,
      final String? replyToMessageId,
      final List<String>? attachmentUrls,
      final Map<String, dynamic>? metadata}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String get id;
  @override
  String get conversationId;
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  String? get senderAvatar;
  @override
  String get content;
  @override
  MessageType get type;
  @override
  MessageStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get readAt; // 추가 메타데이터
  @override
  String? get replyToMessageId;
  @override
  List<String>? get attachmentUrls;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  String get id => throw _privateConstructorUsedError;
  String get creatorId => throw _privateConstructorUsedError;
  String get subscriberId => throw _privateConstructorUsedError;
  String get creatorName => throw _privateConstructorUsedError;
  String get subscriberName => throw _privateConstructorUsedError;
  String? get creatorAvatar => throw _privateConstructorUsedError;
  String? get subscriberAvatar => throw _privateConstructorUsedError;
  Message? get lastMessage => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError; // 대화 설정
  bool get isArchived => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call(
      {String id,
      String creatorId,
      String subscriberId,
      String creatorName,
      String subscriberName,
      String? creatorAvatar,
      String? subscriberAvatar,
      Message? lastMessage,
      int unreadCount,
      DateTime createdAt,
      DateTime? updatedAt,
      bool isArchived,
      bool isMuted,
      bool isPinned});

  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorId = null,
    Object? subscriberId = null,
    Object? creatorName = null,
    Object? subscriberName = null,
    Object? creatorAvatar = freezed,
    Object? subscriberAvatar = freezed,
    Object? lastMessage = freezed,
    Object? unreadCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isArchived = null,
    Object? isMuted = null,
    Object? isPinned = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      subscriberId: null == subscriberId
          ? _value.subscriberId
          : subscriberId // ignore: cast_nullable_to_non_nullable
              as String,
      creatorName: null == creatorName
          ? _value.creatorName
          : creatorName // ignore: cast_nullable_to_non_nullable
              as String,
      subscriberName: null == subscriberName
          ? _value.subscriberName
          : subscriberName // ignore: cast_nullable_to_non_nullable
              as String,
      creatorAvatar: freezed == creatorAvatar
          ? _value.creatorAvatar
          : creatorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriberAvatar: freezed == subscriberAvatar
          ? _value.subscriberAvatar
          : subscriberAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
          _$ConversationImpl value, $Res Function(_$ConversationImpl) then) =
      __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String creatorId,
      String subscriberId,
      String creatorName,
      String subscriberName,
      String? creatorAvatar,
      String? subscriberAvatar,
      Message? lastMessage,
      int unreadCount,
      DateTime createdAt,
      DateTime? updatedAt,
      bool isArchived,
      bool isMuted,
      bool isPinned});

  @override
  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
      _$ConversationImpl _value, $Res Function(_$ConversationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorId = null,
    Object? subscriberId = null,
    Object? creatorName = null,
    Object? subscriberName = null,
    Object? creatorAvatar = freezed,
    Object? subscriberAvatar = freezed,
    Object? lastMessage = freezed,
    Object? unreadCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isArchived = null,
    Object? isMuted = null,
    Object? isPinned = null,
  }) {
    return _then(_$ConversationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      subscriberId: null == subscriberId
          ? _value.subscriberId
          : subscriberId // ignore: cast_nullable_to_non_nullable
              as String,
      creatorName: null == creatorName
          ? _value.creatorName
          : creatorName // ignore: cast_nullable_to_non_nullable
              as String,
      subscriberName: null == subscriberName
          ? _value.subscriberName
          : subscriberName // ignore: cast_nullable_to_non_nullable
              as String,
      creatorAvatar: freezed == creatorAvatar
          ? _value.creatorAvatar
          : creatorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriberAvatar: freezed == subscriberAvatar
          ? _value.subscriberAvatar
          : subscriberAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationImpl implements _Conversation {
  const _$ConversationImpl(
      {required this.id,
      required this.creatorId,
      required this.subscriberId,
      required this.creatorName,
      required this.subscriberName,
      this.creatorAvatar,
      this.subscriberAvatar,
      this.lastMessage,
      required this.unreadCount,
      required this.createdAt,
      this.updatedAt,
      this.isArchived = false,
      this.isMuted = false,
      this.isPinned = false});

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

  @override
  final String id;
  @override
  final String creatorId;
  @override
  final String subscriberId;
  @override
  final String creatorName;
  @override
  final String subscriberName;
  @override
  final String? creatorAvatar;
  @override
  final String? subscriberAvatar;
  @override
  final Message? lastMessage;
  @override
  final int unreadCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
// 대화 설정
  @override
  @JsonKey()
  final bool isArchived;
  @override
  @JsonKey()
  final bool isMuted;
  @override
  @JsonKey()
  final bool isPinned;

  @override
  String toString() {
    return 'Conversation(id: $id, creatorId: $creatorId, subscriberId: $subscriberId, creatorName: $creatorName, subscriberName: $subscriberName, creatorAvatar: $creatorAvatar, subscriberAvatar: $subscriberAvatar, lastMessage: $lastMessage, unreadCount: $unreadCount, createdAt: $createdAt, updatedAt: $updatedAt, isArchived: $isArchived, isMuted: $isMuted, isPinned: $isPinned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.subscriberId, subscriberId) ||
                other.subscriberId == subscriberId) &&
            (identical(other.creatorName, creatorName) ||
                other.creatorName == creatorName) &&
            (identical(other.subscriberName, subscriberName) ||
                other.subscriberName == subscriberName) &&
            (identical(other.creatorAvatar, creatorAvatar) ||
                other.creatorAvatar == creatorAvatar) &&
            (identical(other.subscriberAvatar, subscriberAvatar) ||
                other.subscriberAvatar == subscriberAvatar) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      creatorId,
      subscriberId,
      creatorName,
      subscriberName,
      creatorAvatar,
      subscriberAvatar,
      lastMessage,
      unreadCount,
      createdAt,
      updatedAt,
      isArchived,
      isMuted,
      isPinned);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(
      this,
    );
  }
}

abstract class _Conversation implements Conversation {
  const factory _Conversation(
      {required final String id,
      required final String creatorId,
      required final String subscriberId,
      required final String creatorName,
      required final String subscriberName,
      final String? creatorAvatar,
      final String? subscriberAvatar,
      final Message? lastMessage,
      required final int unreadCount,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final bool isArchived,
      final bool isMuted,
      final bool isPinned}) = _$ConversationImpl;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override
  String get id;
  @override
  String get creatorId;
  @override
  String get subscriberId;
  @override
  String get creatorName;
  @override
  String get subscriberName;
  @override
  String? get creatorAvatar;
  @override
  String? get subscriberAvatar;
  @override
  Message? get lastMessage;
  @override
  int get unreadCount;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt; // 대화 설정
  @override
  bool get isArchived;
  @override
  bool get isMuted;
  @override
  bool get isPinned;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TypingStatus _$TypingStatusFromJson(Map<String, dynamic> json) {
  return _TypingStatus.fromJson(json);
}

/// @nodoc
mixin _$TypingStatus {
  String get conversationId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this TypingStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TypingStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypingStatusCopyWith<TypingStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypingStatusCopyWith<$Res> {
  factory $TypingStatusCopyWith(
          TypingStatus value, $Res Function(TypingStatus) then) =
      _$TypingStatusCopyWithImpl<$Res, TypingStatus>;
  @useResult
  $Res call({String conversationId, String userId, DateTime timestamp});
}

/// @nodoc
class _$TypingStatusCopyWithImpl<$Res, $Val extends TypingStatus>
    implements $TypingStatusCopyWith<$Res> {
  _$TypingStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypingStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? userId = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TypingStatusImplCopyWith<$Res>
    implements $TypingStatusCopyWith<$Res> {
  factory _$$TypingStatusImplCopyWith(
          _$TypingStatusImpl value, $Res Function(_$TypingStatusImpl) then) =
      __$$TypingStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String conversationId, String userId, DateTime timestamp});
}

/// @nodoc
class __$$TypingStatusImplCopyWithImpl<$Res>
    extends _$TypingStatusCopyWithImpl<$Res, _$TypingStatusImpl>
    implements _$$TypingStatusImplCopyWith<$Res> {
  __$$TypingStatusImplCopyWithImpl(
      _$TypingStatusImpl _value, $Res Function(_$TypingStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of TypingStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? userId = null,
    Object? timestamp = null,
  }) {
    return _then(_$TypingStatusImpl(
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TypingStatusImpl implements _TypingStatus {
  const _$TypingStatusImpl(
      {required this.conversationId,
      required this.userId,
      required this.timestamp});

  factory _$TypingStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypingStatusImplFromJson(json);

  @override
  final String conversationId;
  @override
  final String userId;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'TypingStatus(conversationId: $conversationId, userId: $userId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypingStatusImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, userId, timestamp);

  /// Create a copy of TypingStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypingStatusImplCopyWith<_$TypingStatusImpl> get copyWith =>
      __$$TypingStatusImplCopyWithImpl<_$TypingStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypingStatusImplToJson(
      this,
    );
  }
}

abstract class _TypingStatus implements TypingStatus {
  const factory _TypingStatus(
      {required final String conversationId,
      required final String userId,
      required final DateTime timestamp}) = _$TypingStatusImpl;

  factory _TypingStatus.fromJson(Map<String, dynamic> json) =
      _$TypingStatusImpl.fromJson;

  @override
  String get conversationId;
  @override
  String get userId;
  @override
  DateTime get timestamp;

  /// Create a copy of TypingStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypingStatusImplCopyWith<_$TypingStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageReaction _$MessageReactionFromJson(Map<String, dynamic> json) {
  return _MessageReaction.fromJson(json);
}

/// @nodoc
mixin _$MessageReaction {
  String get messageId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MessageReaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageReactionCopyWith<MessageReaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageReactionCopyWith<$Res> {
  factory $MessageReactionCopyWith(
          MessageReaction value, $Res Function(MessageReaction) then) =
      _$MessageReactionCopyWithImpl<$Res, MessageReaction>;
  @useResult
  $Res call(
      {String messageId, String userId, String emoji, DateTime createdAt});
}

/// @nodoc
class _$MessageReactionCopyWithImpl<$Res, $Val extends MessageReaction>
    implements $MessageReactionCopyWith<$Res> {
  _$MessageReactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? userId = null,
    Object? emoji = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageReactionImplCopyWith<$Res>
    implements $MessageReactionCopyWith<$Res> {
  factory _$$MessageReactionImplCopyWith(_$MessageReactionImpl value,
          $Res Function(_$MessageReactionImpl) then) =
      __$$MessageReactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String messageId, String userId, String emoji, DateTime createdAt});
}

/// @nodoc
class __$$MessageReactionImplCopyWithImpl<$Res>
    extends _$MessageReactionCopyWithImpl<$Res, _$MessageReactionImpl>
    implements _$$MessageReactionImplCopyWith<$Res> {
  __$$MessageReactionImplCopyWithImpl(
      _$MessageReactionImpl _value, $Res Function(_$MessageReactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? userId = null,
    Object? emoji = null,
    Object? createdAt = null,
  }) {
    return _then(_$MessageReactionImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageReactionImpl implements _MessageReaction {
  const _$MessageReactionImpl(
      {required this.messageId,
      required this.userId,
      required this.emoji,
      required this.createdAt});

  factory _$MessageReactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageReactionImplFromJson(json);

  @override
  final String messageId;
  @override
  final String userId;
  @override
  final String emoji;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'MessageReaction(messageId: $messageId, userId: $userId, emoji: $emoji, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageReactionImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, messageId, userId, emoji, createdAt);

  /// Create a copy of MessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageReactionImplCopyWith<_$MessageReactionImpl> get copyWith =>
      __$$MessageReactionImplCopyWithImpl<_$MessageReactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageReactionImplToJson(
      this,
    );
  }
}

abstract class _MessageReaction implements MessageReaction {
  const factory _MessageReaction(
      {required final String messageId,
      required final String userId,
      required final String emoji,
      required final DateTime createdAt}) = _$MessageReactionImpl;

  factory _MessageReaction.fromJson(Map<String, dynamic> json) =
      _$MessageReactionImpl.fromJson;

  @override
  String get messageId;
  @override
  String get userId;
  @override
  String get emoji;
  @override
  DateTime get createdAt;

  /// Create a copy of MessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageReactionImplCopyWith<_$MessageReactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

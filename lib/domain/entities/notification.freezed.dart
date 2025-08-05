// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return _Notification.fromJson(json);
}

/// @nodoc
mixin _$Notification {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  NotificationType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  NotificationPriority get priority => throw _privateConstructorUsedError;
  NotificationStatus get status => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get actionUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  String? get relatedId =>
      throw _privateConstructorUsedError; // 관련 엔티티 ID (결제 ID, 콘텐츠 ID 등)
  String? get senderUserId =>
      throw _privateConstructorUsedError; // 발신자 ID (메시지 알림 등)
  String? get senderUserName => throw _privateConstructorUsedError; // 발신자 이름
  DateTime? get scheduledAt => throw _privateConstructorUsedError; // 예약 전송 시간
  DateTime? get expiresAt => throw _privateConstructorUsedError; // 만료 시간
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError; // 읽은 시간
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Notification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationCopyWith<Notification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCopyWith<$Res> {
  factory $NotificationCopyWith(
          Notification value, $Res Function(Notification) then) =
      _$NotificationCopyWithImpl<$Res, Notification>;
  @useResult
  $Res call(
      {String id,
      String userId,
      NotificationType type,
      String title,
      String message,
      NotificationPriority priority,
      NotificationStatus status,
      String? imageUrl,
      String? actionUrl,
      Map<String, dynamic>? metadata,
      String? relatedId,
      String? senderUserId,
      String? senderUserName,
      DateTime? scheduledAt,
      DateTime? expiresAt,
      DateTime createdAt,
      DateTime? readAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$NotificationCopyWithImpl<$Res, $Val extends Notification>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? priority = null,
    Object? status = null,
    Object? imageUrl = freezed,
    Object? actionUrl = freezed,
    Object? metadata = freezed,
    Object? relatedId = freezed,
    Object? senderUserId = freezed,
    Object? senderUserName = freezed,
    Object? scheduledAt = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NotificationPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NotificationStatus,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      relatedId: freezed == relatedId
          ? _value.relatedId
          : relatedId // ignore: cast_nullable_to_non_nullable
              as String?,
      senderUserId: freezed == senderUserId
          ? _value.senderUserId
          : senderUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      senderUserName: freezed == senderUserName
          ? _value.senderUserName
          : senderUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationImplCopyWith<$Res>
    implements $NotificationCopyWith<$Res> {
  factory _$$NotificationImplCopyWith(
          _$NotificationImpl value, $Res Function(_$NotificationImpl) then) =
      __$$NotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      NotificationType type,
      String title,
      String message,
      NotificationPriority priority,
      NotificationStatus status,
      String? imageUrl,
      String? actionUrl,
      Map<String, dynamic>? metadata,
      String? relatedId,
      String? senderUserId,
      String? senderUserName,
      DateTime? scheduledAt,
      DateTime? expiresAt,
      DateTime createdAt,
      DateTime? readAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$NotificationImplCopyWithImpl<$Res>
    extends _$NotificationCopyWithImpl<$Res, _$NotificationImpl>
    implements _$$NotificationImplCopyWith<$Res> {
  __$$NotificationImplCopyWithImpl(
      _$NotificationImpl _value, $Res Function(_$NotificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? priority = null,
    Object? status = null,
    Object? imageUrl = freezed,
    Object? actionUrl = freezed,
    Object? metadata = freezed,
    Object? relatedId = freezed,
    Object? senderUserId = freezed,
    Object? senderUserName = freezed,
    Object? scheduledAt = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NotificationPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NotificationStatus,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      relatedId: freezed == relatedId
          ? _value.relatedId
          : relatedId // ignore: cast_nullable_to_non_nullable
              as String?,
      senderUserId: freezed == senderUserId
          ? _value.senderUserId
          : senderUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      senderUserName: freezed == senderUserName
          ? _value.senderUserName
          : senderUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationImpl implements _Notification {
  const _$NotificationImpl(
      {required this.id,
      required this.userId,
      required this.type,
      required this.title,
      required this.message,
      this.priority = NotificationPriority.normal,
      this.status = NotificationStatus.unread,
      this.imageUrl,
      this.actionUrl,
      final Map<String, dynamic>? metadata,
      this.relatedId,
      this.senderUserId,
      this.senderUserName,
      this.scheduledAt,
      this.expiresAt,
      required this.createdAt,
      this.readAt,
      this.updatedAt})
      : _metadata = metadata;

  factory _$NotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final NotificationType type;
  @override
  final String title;
  @override
  final String message;
  @override
  @JsonKey()
  final NotificationPriority priority;
  @override
  @JsonKey()
  final NotificationStatus status;
  @override
  final String? imageUrl;
  @override
  final String? actionUrl;
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
  final String? relatedId;
// 관련 엔티티 ID (결제 ID, 콘텐츠 ID 등)
  @override
  final String? senderUserId;
// 발신자 ID (메시지 알림 등)
  @override
  final String? senderUserName;
// 발신자 이름
  @override
  final DateTime? scheduledAt;
// 예약 전송 시간
  @override
  final DateTime? expiresAt;
// 만료 시간
  @override
  final DateTime createdAt;
  @override
  final DateTime? readAt;
// 읽은 시간
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Notification(id: $id, userId: $userId, type: $type, title: $title, message: $message, priority: $priority, status: $status, imageUrl: $imageUrl, actionUrl: $actionUrl, metadata: $metadata, relatedId: $relatedId, senderUserId: $senderUserId, senderUserName: $senderUserName, scheduledAt: $scheduledAt, expiresAt: $expiresAt, createdAt: $createdAt, readAt: $readAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.actionUrl, actionUrl) ||
                other.actionUrl == actionUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.relatedId, relatedId) ||
                other.relatedId == relatedId) &&
            (identical(other.senderUserId, senderUserId) ||
                other.senderUserId == senderUserId) &&
            (identical(other.senderUserName, senderUserName) ||
                other.senderUserName == senderUserName) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      type,
      title,
      message,
      priority,
      status,
      imageUrl,
      actionUrl,
      const DeepCollectionEquality().hash(_metadata),
      relatedId,
      senderUserId,
      senderUserName,
      scheduledAt,
      expiresAt,
      createdAt,
      readAt,
      updatedAt);

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      __$$NotificationImplCopyWithImpl<_$NotificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationImplToJson(
      this,
    );
  }
}

abstract class _Notification implements Notification {
  const factory _Notification(
      {required final String id,
      required final String userId,
      required final NotificationType type,
      required final String title,
      required final String message,
      final NotificationPriority priority,
      final NotificationStatus status,
      final String? imageUrl,
      final String? actionUrl,
      final Map<String, dynamic>? metadata,
      final String? relatedId,
      final String? senderUserId,
      final String? senderUserName,
      final DateTime? scheduledAt,
      final DateTime? expiresAt,
      required final DateTime createdAt,
      final DateTime? readAt,
      final DateTime? updatedAt}) = _$NotificationImpl;

  factory _Notification.fromJson(Map<String, dynamic> json) =
      _$NotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  NotificationType get type;
  @override
  String get title;
  @override
  String get message;
  @override
  NotificationPriority get priority;
  @override
  NotificationStatus get status;
  @override
  String? get imageUrl;
  @override
  String? get actionUrl;
  @override
  Map<String, dynamic>? get metadata;
  @override
  String? get relatedId; // 관련 엔티티 ID (결제 ID, 콘텐츠 ID 등)
  @override
  String? get senderUserId; // 발신자 ID (메시지 알림 등)
  @override
  String? get senderUserName; // 발신자 이름
  @override
  DateTime? get scheduledAt; // 예약 전송 시간
  @override
  DateTime? get expiresAt; // 만료 시간
  @override
  DateTime get createdAt;
  @override
  DateTime? get readAt; // 읽은 시간
  @override
  DateTime? get updatedAt;

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationStatistics _$NotificationStatisticsFromJson(
    Map<String, dynamic> json) {
  return _NotificationStatistics.fromJson(json);
}

/// @nodoc
mixin _$NotificationStatistics {
  int get totalCount => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  int get readCount => throw _privateConstructorUsedError;
  int get archivedCount => throw _privateConstructorUsedError;
  Map<NotificationType, int> get countByType =>
      throw _privateConstructorUsedError;
  Map<NotificationPriority, int> get countByPriority =>
      throw _privateConstructorUsedError;
  DateTime get lastNotificationAt => throw _privateConstructorUsedError;
  double get averageReadTime => throw _privateConstructorUsedError;

  /// Serializes this NotificationStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationStatisticsCopyWith<NotificationStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationStatisticsCopyWith<$Res> {
  factory $NotificationStatisticsCopyWith(NotificationStatistics value,
          $Res Function(NotificationStatistics) then) =
      _$NotificationStatisticsCopyWithImpl<$Res, NotificationStatistics>;
  @useResult
  $Res call(
      {int totalCount,
      int unreadCount,
      int readCount,
      int archivedCount,
      Map<NotificationType, int> countByType,
      Map<NotificationPriority, int> countByPriority,
      DateTime lastNotificationAt,
      double averageReadTime});
}

/// @nodoc
class _$NotificationStatisticsCopyWithImpl<$Res,
        $Val extends NotificationStatistics>
    implements $NotificationStatisticsCopyWith<$Res> {
  _$NotificationStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? unreadCount = null,
    Object? readCount = null,
    Object? archivedCount = null,
    Object? countByType = null,
    Object? countByPriority = null,
    Object? lastNotificationAt = null,
    Object? averageReadTime = null,
  }) {
    return _then(_value.copyWith(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      readCount: null == readCount
          ? _value.readCount
          : readCount // ignore: cast_nullable_to_non_nullable
              as int,
      archivedCount: null == archivedCount
          ? _value.archivedCount
          : archivedCount // ignore: cast_nullable_to_non_nullable
              as int,
      countByType: null == countByType
          ? _value.countByType
          : countByType // ignore: cast_nullable_to_non_nullable
              as Map<NotificationType, int>,
      countByPriority: null == countByPriority
          ? _value.countByPriority
          : countByPriority // ignore: cast_nullable_to_non_nullable
              as Map<NotificationPriority, int>,
      lastNotificationAt: null == lastNotificationAt
          ? _value.lastNotificationAt
          : lastNotificationAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      averageReadTime: null == averageReadTime
          ? _value.averageReadTime
          : averageReadTime // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationStatisticsImplCopyWith<$Res>
    implements $NotificationStatisticsCopyWith<$Res> {
  factory _$$NotificationStatisticsImplCopyWith(
          _$NotificationStatisticsImpl value,
          $Res Function(_$NotificationStatisticsImpl) then) =
      __$$NotificationStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalCount,
      int unreadCount,
      int readCount,
      int archivedCount,
      Map<NotificationType, int> countByType,
      Map<NotificationPriority, int> countByPriority,
      DateTime lastNotificationAt,
      double averageReadTime});
}

/// @nodoc
class __$$NotificationStatisticsImplCopyWithImpl<$Res>
    extends _$NotificationStatisticsCopyWithImpl<$Res,
        _$NotificationStatisticsImpl>
    implements _$$NotificationStatisticsImplCopyWith<$Res> {
  __$$NotificationStatisticsImplCopyWithImpl(
      _$NotificationStatisticsImpl _value,
      $Res Function(_$NotificationStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? unreadCount = null,
    Object? readCount = null,
    Object? archivedCount = null,
    Object? countByType = null,
    Object? countByPriority = null,
    Object? lastNotificationAt = null,
    Object? averageReadTime = null,
  }) {
    return _then(_$NotificationStatisticsImpl(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      readCount: null == readCount
          ? _value.readCount
          : readCount // ignore: cast_nullable_to_non_nullable
              as int,
      archivedCount: null == archivedCount
          ? _value.archivedCount
          : archivedCount // ignore: cast_nullable_to_non_nullable
              as int,
      countByType: null == countByType
          ? _value._countByType
          : countByType // ignore: cast_nullable_to_non_nullable
              as Map<NotificationType, int>,
      countByPriority: null == countByPriority
          ? _value._countByPriority
          : countByPriority // ignore: cast_nullable_to_non_nullable
              as Map<NotificationPriority, int>,
      lastNotificationAt: null == lastNotificationAt
          ? _value.lastNotificationAt
          : lastNotificationAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      averageReadTime: null == averageReadTime
          ? _value.averageReadTime
          : averageReadTime // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationStatisticsImpl implements _NotificationStatistics {
  const _$NotificationStatisticsImpl(
      {required this.totalCount,
      required this.unreadCount,
      required this.readCount,
      required this.archivedCount,
      required final Map<NotificationType, int> countByType,
      required final Map<NotificationPriority, int> countByPriority,
      required this.lastNotificationAt,
      this.averageReadTime = 0.0})
      : _countByType = countByType,
        _countByPriority = countByPriority;

  factory _$NotificationStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationStatisticsImplFromJson(json);

  @override
  final int totalCount;
  @override
  final int unreadCount;
  @override
  final int readCount;
  @override
  final int archivedCount;
  final Map<NotificationType, int> _countByType;
  @override
  Map<NotificationType, int> get countByType {
    if (_countByType is EqualUnmodifiableMapView) return _countByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_countByType);
  }

  final Map<NotificationPriority, int> _countByPriority;
  @override
  Map<NotificationPriority, int> get countByPriority {
    if (_countByPriority is EqualUnmodifiableMapView) return _countByPriority;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_countByPriority);
  }

  @override
  final DateTime lastNotificationAt;
  @override
  @JsonKey()
  final double averageReadTime;

  @override
  String toString() {
    return 'NotificationStatistics(totalCount: $totalCount, unreadCount: $unreadCount, readCount: $readCount, archivedCount: $archivedCount, countByType: $countByType, countByPriority: $countByPriority, lastNotificationAt: $lastNotificationAt, averageReadTime: $averageReadTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationStatisticsImpl &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.readCount, readCount) ||
                other.readCount == readCount) &&
            (identical(other.archivedCount, archivedCount) ||
                other.archivedCount == archivedCount) &&
            const DeepCollectionEquality()
                .equals(other._countByType, _countByType) &&
            const DeepCollectionEquality()
                .equals(other._countByPriority, _countByPriority) &&
            (identical(other.lastNotificationAt, lastNotificationAt) ||
                other.lastNotificationAt == lastNotificationAt) &&
            (identical(other.averageReadTime, averageReadTime) ||
                other.averageReadTime == averageReadTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalCount,
      unreadCount,
      readCount,
      archivedCount,
      const DeepCollectionEquality().hash(_countByType),
      const DeepCollectionEquality().hash(_countByPriority),
      lastNotificationAt,
      averageReadTime);

  /// Create a copy of NotificationStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationStatisticsImplCopyWith<_$NotificationStatisticsImpl>
      get copyWith => __$$NotificationStatisticsImplCopyWithImpl<
          _$NotificationStatisticsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationStatisticsImplToJson(
      this,
    );
  }
}

abstract class _NotificationStatistics implements NotificationStatistics {
  const factory _NotificationStatistics(
      {required final int totalCount,
      required final int unreadCount,
      required final int readCount,
      required final int archivedCount,
      required final Map<NotificationType, int> countByType,
      required final Map<NotificationPriority, int> countByPriority,
      required final DateTime lastNotificationAt,
      final double averageReadTime}) = _$NotificationStatisticsImpl;

  factory _NotificationStatistics.fromJson(Map<String, dynamic> json) =
      _$NotificationStatisticsImpl.fromJson;

  @override
  int get totalCount;
  @override
  int get unreadCount;
  @override
  int get readCount;
  @override
  int get archivedCount;
  @override
  Map<NotificationType, int> get countByType;
  @override
  Map<NotificationPriority, int> get countByPriority;
  @override
  DateTime get lastNotificationAt;
  @override
  double get averageReadTime;

  /// Create a copy of NotificationStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationStatisticsImplCopyWith<_$NotificationStatisticsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationSettings _$NotificationSettingsFromJson(Map<String, dynamic> json) {
  return _NotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettings {
  String get userId => throw _privateConstructorUsedError;
  bool get pushEnabled => throw _privateConstructorUsedError; // 푸시 알림 허용
  bool get emailEnabled => throw _privateConstructorUsedError; // 이메일 알림 허용
  bool get inAppEnabled => throw _privateConstructorUsedError; // 인앱 알림 허용
  bool get paymentEnabled => throw _privateConstructorUsedError; // 결제 알림
  bool get subscriptionEnabled => throw _privateConstructorUsedError; // 구독 알림
  bool get contentEnabled => throw _privateConstructorUsedError; // 콘텐츠 알림
  bool get messageEnabled => throw _privateConstructorUsedError; // 메시지 알림
  bool get systemEnabled => throw _privateConstructorUsedError; // 시스템 알림
  bool get creatorEnabled => throw _privateConstructorUsedError; // 크리에이터 알림
  bool get promotionEnabled => throw _privateConstructorUsedError; // 프로모션 알림
  String get quietHoursStart => throw _privateConstructorUsedError; // 무음 시간 시작
  String get quietHoursEnd => throw _privateConstructorUsedError; // 무음 시간 종료
  bool get quietHoursEnabled => throw _privateConstructorUsedError; // 무음 시간 활성화
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsCopyWith<NotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsCopyWith<$Res> {
  factory $NotificationSettingsCopyWith(NotificationSettings value,
          $Res Function(NotificationSettings) then) =
      _$NotificationSettingsCopyWithImpl<$Res, NotificationSettings>;
  @useResult
  $Res call(
      {String userId,
      bool pushEnabled,
      bool emailEnabled,
      bool inAppEnabled,
      bool paymentEnabled,
      bool subscriptionEnabled,
      bool contentEnabled,
      bool messageEnabled,
      bool systemEnabled,
      bool creatorEnabled,
      bool promotionEnabled,
      String quietHoursStart,
      String quietHoursEnd,
      bool quietHoursEnabled,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res,
        $Val extends NotificationSettings>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? pushEnabled = null,
    Object? emailEnabled = null,
    Object? inAppEnabled = null,
    Object? paymentEnabled = null,
    Object? subscriptionEnabled = null,
    Object? contentEnabled = null,
    Object? messageEnabled = null,
    Object? systemEnabled = null,
    Object? creatorEnabled = null,
    Object? promotionEnabled = null,
    Object? quietHoursStart = null,
    Object? quietHoursEnd = null,
    Object? quietHoursEnabled = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      pushEnabled: null == pushEnabled
          ? _value.pushEnabled
          : pushEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailEnabled: null == emailEnabled
          ? _value.emailEnabled
          : emailEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      inAppEnabled: null == inAppEnabled
          ? _value.inAppEnabled
          : inAppEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      paymentEnabled: null == paymentEnabled
          ? _value.paymentEnabled
          : paymentEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptionEnabled: null == subscriptionEnabled
          ? _value.subscriptionEnabled
          : subscriptionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      contentEnabled: null == contentEnabled
          ? _value.contentEnabled
          : contentEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      messageEnabled: null == messageEnabled
          ? _value.messageEnabled
          : messageEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      systemEnabled: null == systemEnabled
          ? _value.systemEnabled
          : systemEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      creatorEnabled: null == creatorEnabled
          ? _value.creatorEnabled
          : creatorEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      promotionEnabled: null == promotionEnabled
          ? _value.promotionEnabled
          : promotionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      quietHoursStart: null == quietHoursStart
          ? _value.quietHoursStart
          : quietHoursStart // ignore: cast_nullable_to_non_nullable
              as String,
      quietHoursEnd: null == quietHoursEnd
          ? _value.quietHoursEnd
          : quietHoursEnd // ignore: cast_nullable_to_non_nullable
              as String,
      quietHoursEnabled: null == quietHoursEnabled
          ? _value.quietHoursEnabled
          : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsImplCopyWith<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  factory _$$NotificationSettingsImplCopyWith(_$NotificationSettingsImpl value,
          $Res Function(_$NotificationSettingsImpl) then) =
      __$$NotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      bool pushEnabled,
      bool emailEnabled,
      bool inAppEnabled,
      bool paymentEnabled,
      bool subscriptionEnabled,
      bool contentEnabled,
      bool messageEnabled,
      bool systemEnabled,
      bool creatorEnabled,
      bool promotionEnabled,
      String quietHoursStart,
      String quietHoursEnd,
      bool quietHoursEnabled,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$NotificationSettingsImplCopyWithImpl<$Res>
    extends _$NotificationSettingsCopyWithImpl<$Res, _$NotificationSettingsImpl>
    implements _$$NotificationSettingsImplCopyWith<$Res> {
  __$$NotificationSettingsImplCopyWithImpl(_$NotificationSettingsImpl _value,
      $Res Function(_$NotificationSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? pushEnabled = null,
    Object? emailEnabled = null,
    Object? inAppEnabled = null,
    Object? paymentEnabled = null,
    Object? subscriptionEnabled = null,
    Object? contentEnabled = null,
    Object? messageEnabled = null,
    Object? systemEnabled = null,
    Object? creatorEnabled = null,
    Object? promotionEnabled = null,
    Object? quietHoursStart = null,
    Object? quietHoursEnd = null,
    Object? quietHoursEnabled = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$NotificationSettingsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      pushEnabled: null == pushEnabled
          ? _value.pushEnabled
          : pushEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailEnabled: null == emailEnabled
          ? _value.emailEnabled
          : emailEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      inAppEnabled: null == inAppEnabled
          ? _value.inAppEnabled
          : inAppEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      paymentEnabled: null == paymentEnabled
          ? _value.paymentEnabled
          : paymentEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptionEnabled: null == subscriptionEnabled
          ? _value.subscriptionEnabled
          : subscriptionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      contentEnabled: null == contentEnabled
          ? _value.contentEnabled
          : contentEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      messageEnabled: null == messageEnabled
          ? _value.messageEnabled
          : messageEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      systemEnabled: null == systemEnabled
          ? _value.systemEnabled
          : systemEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      creatorEnabled: null == creatorEnabled
          ? _value.creatorEnabled
          : creatorEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      promotionEnabled: null == promotionEnabled
          ? _value.promotionEnabled
          : promotionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      quietHoursStart: null == quietHoursStart
          ? _value.quietHoursStart
          : quietHoursStart // ignore: cast_nullable_to_non_nullable
              as String,
      quietHoursEnd: null == quietHoursEnd
          ? _value.quietHoursEnd
          : quietHoursEnd // ignore: cast_nullable_to_non_nullable
              as String,
      quietHoursEnabled: null == quietHoursEnabled
          ? _value.quietHoursEnabled
          : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsImpl implements _NotificationSettings {
  const _$NotificationSettingsImpl(
      {required this.userId,
      this.pushEnabled = true,
      this.emailEnabled = true,
      this.inAppEnabled = true,
      this.paymentEnabled = true,
      this.subscriptionEnabled = true,
      this.contentEnabled = true,
      this.messageEnabled = true,
      this.systemEnabled = true,
      this.creatorEnabled = true,
      this.promotionEnabled = false,
      this.quietHoursStart = '09:00',
      this.quietHoursEnd = '22:00',
      this.quietHoursEnabled = true,
      required this.createdAt,
      required this.updatedAt});

  factory _$NotificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsImplFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey()
  final bool pushEnabled;
// 푸시 알림 허용
  @override
  @JsonKey()
  final bool emailEnabled;
// 이메일 알림 허용
  @override
  @JsonKey()
  final bool inAppEnabled;
// 인앱 알림 허용
  @override
  @JsonKey()
  final bool paymentEnabled;
// 결제 알림
  @override
  @JsonKey()
  final bool subscriptionEnabled;
// 구독 알림
  @override
  @JsonKey()
  final bool contentEnabled;
// 콘텐츠 알림
  @override
  @JsonKey()
  final bool messageEnabled;
// 메시지 알림
  @override
  @JsonKey()
  final bool systemEnabled;
// 시스템 알림
  @override
  @JsonKey()
  final bool creatorEnabled;
// 크리에이터 알림
  @override
  @JsonKey()
  final bool promotionEnabled;
// 프로모션 알림
  @override
  @JsonKey()
  final String quietHoursStart;
// 무음 시간 시작
  @override
  @JsonKey()
  final String quietHoursEnd;
// 무음 시간 종료
  @override
  @JsonKey()
  final bool quietHoursEnabled;
// 무음 시간 활성화
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'NotificationSettings(userId: $userId, pushEnabled: $pushEnabled, emailEnabled: $emailEnabled, inAppEnabled: $inAppEnabled, paymentEnabled: $paymentEnabled, subscriptionEnabled: $subscriptionEnabled, contentEnabled: $contentEnabled, messageEnabled: $messageEnabled, systemEnabled: $systemEnabled, creatorEnabled: $creatorEnabled, promotionEnabled: $promotionEnabled, quietHoursStart: $quietHoursStart, quietHoursEnd: $quietHoursEnd, quietHoursEnabled: $quietHoursEnabled, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.pushEnabled, pushEnabled) ||
                other.pushEnabled == pushEnabled) &&
            (identical(other.emailEnabled, emailEnabled) ||
                other.emailEnabled == emailEnabled) &&
            (identical(other.inAppEnabled, inAppEnabled) ||
                other.inAppEnabled == inAppEnabled) &&
            (identical(other.paymentEnabled, paymentEnabled) ||
                other.paymentEnabled == paymentEnabled) &&
            (identical(other.subscriptionEnabled, subscriptionEnabled) ||
                other.subscriptionEnabled == subscriptionEnabled) &&
            (identical(other.contentEnabled, contentEnabled) ||
                other.contentEnabled == contentEnabled) &&
            (identical(other.messageEnabled, messageEnabled) ||
                other.messageEnabled == messageEnabled) &&
            (identical(other.systemEnabled, systemEnabled) ||
                other.systemEnabled == systemEnabled) &&
            (identical(other.creatorEnabled, creatorEnabled) ||
                other.creatorEnabled == creatorEnabled) &&
            (identical(other.promotionEnabled, promotionEnabled) ||
                other.promotionEnabled == promotionEnabled) &&
            (identical(other.quietHoursStart, quietHoursStart) ||
                other.quietHoursStart == quietHoursStart) &&
            (identical(other.quietHoursEnd, quietHoursEnd) ||
                other.quietHoursEnd == quietHoursEnd) &&
            (identical(other.quietHoursEnabled, quietHoursEnabled) ||
                other.quietHoursEnabled == quietHoursEnabled) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      pushEnabled,
      emailEnabled,
      inAppEnabled,
      paymentEnabled,
      subscriptionEnabled,
      contentEnabled,
      messageEnabled,
      systemEnabled,
      creatorEnabled,
      promotionEnabled,
      quietHoursStart,
      quietHoursEnd,
      quietHoursEnabled,
      createdAt,
      updatedAt);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith =>
          __$$NotificationSettingsImplCopyWithImpl<_$NotificationSettingsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettings implements NotificationSettings {
  const factory _NotificationSettings(
      {required final String userId,
      final bool pushEnabled,
      final bool emailEnabled,
      final bool inAppEnabled,
      final bool paymentEnabled,
      final bool subscriptionEnabled,
      final bool contentEnabled,
      final bool messageEnabled,
      final bool systemEnabled,
      final bool creatorEnabled,
      final bool promotionEnabled,
      final String quietHoursStart,
      final String quietHoursEnd,
      final bool quietHoursEnabled,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$NotificationSettingsImpl;

  factory _NotificationSettings.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsImpl.fromJson;

  @override
  String get userId;
  @override
  bool get pushEnabled; // 푸시 알림 허용
  @override
  bool get emailEnabled; // 이메일 알림 허용
  @override
  bool get inAppEnabled; // 인앱 알림 허용
  @override
  bool get paymentEnabled; // 결제 알림
  @override
  bool get subscriptionEnabled; // 구독 알림
  @override
  bool get contentEnabled; // 콘텐츠 알림
  @override
  bool get messageEnabled; // 메시지 알림
  @override
  bool get systemEnabled; // 시스템 알림
  @override
  bool get creatorEnabled; // 크리에이터 알림
  @override
  bool get promotionEnabled; // 프로모션 알림
  @override
  String get quietHoursStart; // 무음 시간 시작
  @override
  String get quietHoursEnd; // 무음 시간 종료
  @override
  bool get quietHoursEnabled; // 무음 시간 활성화
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentHistory _$PaymentHistoryFromJson(Map<String, dynamic> json) {
  return _PaymentHistory.fromJson(json);
}

/// @nodoc
mixin _$PaymentHistory {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get creatorId => throw _privateConstructorUsedError;
  String? get subscriptionId => throw _privateConstructorUsedError;
  String? get contentId => throw _privateConstructorUsedError;
  PaymentType get type => throw _privateConstructorUsedError;
  PaymentMethod get method => throw _privateConstructorUsedError;
  PaymentStatus get status => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError; // 원 단위 (KRW)
  String get currency => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  String? get receiptUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  DateTime? get refundedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PaymentHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentHistoryCopyWith<PaymentHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentHistoryCopyWith<$Res> {
  factory $PaymentHistoryCopyWith(
          PaymentHistory value, $Res Function(PaymentHistory) then) =
      _$PaymentHistoryCopyWithImpl<$Res, PaymentHistory>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String? creatorId,
      String? subscriptionId,
      String? contentId,
      PaymentType type,
      PaymentMethod method,
      PaymentStatus status,
      int amount,
      String currency,
      String title,
      String description,
      String? transactionId,
      String? receiptUrl,
      Map<String, dynamic>? metadata,
      String? failureReason,
      DateTime? refundedAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$PaymentHistoryCopyWithImpl<$Res, $Val extends PaymentHistory>
    implements $PaymentHistoryCopyWith<$Res> {
  _$PaymentHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? creatorId = freezed,
    Object? subscriptionId = freezed,
    Object? contentId = freezed,
    Object? type = null,
    Object? method = null,
    Object? status = null,
    Object? amount = null,
    Object? currency = null,
    Object? title = null,
    Object? description = null,
    Object? transactionId = freezed,
    Object? receiptUrl = freezed,
    Object? metadata = freezed,
    Object? failureReason = freezed,
    Object? refundedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      creatorId: freezed == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionId: freezed == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      contentId: freezed == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PaymentType,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      refundedAt: freezed == refundedAt
          ? _value.refundedAt
          : refundedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
abstract class _$$PaymentHistoryImplCopyWith<$Res>
    implements $PaymentHistoryCopyWith<$Res> {
  factory _$$PaymentHistoryImplCopyWith(_$PaymentHistoryImpl value,
          $Res Function(_$PaymentHistoryImpl) then) =
      __$$PaymentHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String? creatorId,
      String? subscriptionId,
      String? contentId,
      PaymentType type,
      PaymentMethod method,
      PaymentStatus status,
      int amount,
      String currency,
      String title,
      String description,
      String? transactionId,
      String? receiptUrl,
      Map<String, dynamic>? metadata,
      String? failureReason,
      DateTime? refundedAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$PaymentHistoryImplCopyWithImpl<$Res>
    extends _$PaymentHistoryCopyWithImpl<$Res, _$PaymentHistoryImpl>
    implements _$$PaymentHistoryImplCopyWith<$Res> {
  __$$PaymentHistoryImplCopyWithImpl(
      _$PaymentHistoryImpl _value, $Res Function(_$PaymentHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? creatorId = freezed,
    Object? subscriptionId = freezed,
    Object? contentId = freezed,
    Object? type = null,
    Object? method = null,
    Object? status = null,
    Object? amount = null,
    Object? currency = null,
    Object? title = null,
    Object? description = null,
    Object? transactionId = freezed,
    Object? receiptUrl = freezed,
    Object? metadata = freezed,
    Object? failureReason = freezed,
    Object? refundedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$PaymentHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: freezed == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionId: freezed == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      contentId: freezed == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PaymentType,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      refundedAt: freezed == refundedAt
          ? _value.refundedAt
          : refundedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$PaymentHistoryImpl implements _PaymentHistory {
  const _$PaymentHistoryImpl(
      {required this.id,
      required this.userId,
      required this.creatorId,
      required this.subscriptionId,
      required this.contentId,
      required this.type,
      required this.method,
      required this.status,
      required this.amount,
      required this.currency,
      required this.title,
      required this.description,
      this.transactionId,
      this.receiptUrl,
      final Map<String, dynamic>? metadata,
      this.failureReason,
      this.refundedAt,
      required this.createdAt,
      required this.updatedAt})
      : _metadata = metadata;

  factory _$PaymentHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String? creatorId;
  @override
  final String? subscriptionId;
  @override
  final String? contentId;
  @override
  final PaymentType type;
  @override
  final PaymentMethod method;
  @override
  final PaymentStatus status;
  @override
  final int amount;
// 원 단위 (KRW)
  @override
  final String currency;
  @override
  final String title;
  @override
  final String description;
  @override
  final String? transactionId;
  @override
  final String? receiptUrl;
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
  final String? failureReason;
  @override
  final DateTime? refundedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PaymentHistory(id: $id, userId: $userId, creatorId: $creatorId, subscriptionId: $subscriptionId, contentId: $contentId, type: $type, method: $method, status: $status, amount: $amount, currency: $currency, title: $title, description: $description, transactionId: $transactionId, receiptUrl: $receiptUrl, metadata: $metadata, failureReason: $failureReason, refundedAt: $refundedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            (identical(other.refundedAt, refundedAt) ||
                other.refundedAt == refundedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        creatorId,
        subscriptionId,
        contentId,
        type,
        method,
        status,
        amount,
        currency,
        title,
        description,
        transactionId,
        receiptUrl,
        const DeepCollectionEquality().hash(_metadata),
        failureReason,
        refundedAt,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentHistoryImplCopyWith<_$PaymentHistoryImpl> get copyWith =>
      __$$PaymentHistoryImplCopyWithImpl<_$PaymentHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentHistoryImplToJson(
      this,
    );
  }
}

abstract class _PaymentHistory implements PaymentHistory {
  const factory _PaymentHistory(
      {required final String id,
      required final String userId,
      required final String? creatorId,
      required final String? subscriptionId,
      required final String? contentId,
      required final PaymentType type,
      required final PaymentMethod method,
      required final PaymentStatus status,
      required final int amount,
      required final String currency,
      required final String title,
      required final String description,
      final String? transactionId,
      final String? receiptUrl,
      final Map<String, dynamic>? metadata,
      final String? failureReason,
      final DateTime? refundedAt,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$PaymentHistoryImpl;

  factory _PaymentHistory.fromJson(Map<String, dynamic> json) =
      _$PaymentHistoryImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String? get creatorId;
  @override
  String? get subscriptionId;
  @override
  String? get contentId;
  @override
  PaymentType get type;
  @override
  PaymentMethod get method;
  @override
  PaymentStatus get status;
  @override
  int get amount; // 원 단위 (KRW)
  @override
  String get currency;
  @override
  String get title;
  @override
  String get description;
  @override
  String? get transactionId;
  @override
  String? get receiptUrl;
  @override
  Map<String, dynamic>? get metadata;
  @override
  String? get failureReason;
  @override
  DateTime? get refundedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentHistoryImplCopyWith<_$PaymentHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

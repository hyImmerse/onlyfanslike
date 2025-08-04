// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'creator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Creator _$CreatorFromJson(Map<String, dynamic> json) {
  return _Creator.fromJson(json);
}

/// @nodoc
mixin _$Creator {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  int get subscriberCount => throw _privateConstructorUsedError;
  int get contentCount => throw _privateConstructorUsedError;
  List<SubscriptionTier> get tiers => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Creator to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Creator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatorCopyWith<Creator> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatorCopyWith<$Res> {
  factory $CreatorCopyWith(Creator value, $Res Function(Creator) then) =
      _$CreatorCopyWithImpl<$Res, Creator>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String displayName,
      String profileImageUrl,
      String? coverImageUrl,
      String bio,
      String category,
      int subscriberCount,
      int contentCount,
      List<SubscriptionTier> tiers,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$CreatorCopyWithImpl<$Res, $Val extends Creator>
    implements $CreatorCopyWith<$Res> {
  _$CreatorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Creator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? displayName = null,
    Object? profileImageUrl = null,
    Object? coverImageUrl = freezed,
    Object? bio = null,
    Object? category = null,
    Object? subscriberCount = null,
    Object? contentCount = null,
    Object? tiers = null,
    Object? createdAt = null,
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
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subscriberCount: null == subscriberCount
          ? _value.subscriberCount
          : subscriberCount // ignore: cast_nullable_to_non_nullable
              as int,
      contentCount: null == contentCount
          ? _value.contentCount
          : contentCount // ignore: cast_nullable_to_non_nullable
              as int,
      tiers: null == tiers
          ? _value.tiers
          : tiers // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionTier>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatorImplCopyWith<$Res> implements $CreatorCopyWith<$Res> {
  factory _$$CreatorImplCopyWith(
          _$CreatorImpl value, $Res Function(_$CreatorImpl) then) =
      __$$CreatorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String displayName,
      String profileImageUrl,
      String? coverImageUrl,
      String bio,
      String category,
      int subscriberCount,
      int contentCount,
      List<SubscriptionTier> tiers,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$CreatorImplCopyWithImpl<$Res>
    extends _$CreatorCopyWithImpl<$Res, _$CreatorImpl>
    implements _$$CreatorImplCopyWith<$Res> {
  __$$CreatorImplCopyWithImpl(
      _$CreatorImpl _value, $Res Function(_$CreatorImpl) _then)
      : super(_value, _then);

  /// Create a copy of Creator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? displayName = null,
    Object? profileImageUrl = null,
    Object? coverImageUrl = freezed,
    Object? bio = null,
    Object? category = null,
    Object? subscriberCount = null,
    Object? contentCount = null,
    Object? tiers = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$CreatorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subscriberCount: null == subscriberCount
          ? _value.subscriberCount
          : subscriberCount // ignore: cast_nullable_to_non_nullable
              as int,
      contentCount: null == contentCount
          ? _value.contentCount
          : contentCount // ignore: cast_nullable_to_non_nullable
              as int,
      tiers: null == tiers
          ? _value._tiers
          : tiers // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionTier>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatorImpl implements _Creator {
  const _$CreatorImpl(
      {required this.id,
      required this.userId,
      required this.displayName,
      required this.profileImageUrl,
      this.coverImageUrl,
      required this.bio,
      required this.category,
      required this.subscriberCount,
      required this.contentCount,
      required final List<SubscriptionTier> tiers,
      required this.createdAt,
      this.updatedAt})
      : _tiers = tiers;

  factory _$CreatorImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatorImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String profileImageUrl;
  @override
  final String? coverImageUrl;
  @override
  final String bio;
  @override
  final String category;
  @override
  final int subscriberCount;
  @override
  final int contentCount;
  final List<SubscriptionTier> _tiers;
  @override
  List<SubscriptionTier> get tiers {
    if (_tiers is EqualUnmodifiableListView) return _tiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tiers);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Creator(id: $id, userId: $userId, displayName: $displayName, profileImageUrl: $profileImageUrl, coverImageUrl: $coverImageUrl, bio: $bio, category: $category, subscriberCount: $subscriberCount, contentCount: $contentCount, tiers: $tiers, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subscriberCount, subscriberCount) ||
                other.subscriberCount == subscriberCount) &&
            (identical(other.contentCount, contentCount) ||
                other.contentCount == contentCount) &&
            const DeepCollectionEquality().equals(other._tiers, _tiers) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      displayName,
      profileImageUrl,
      coverImageUrl,
      bio,
      category,
      subscriberCount,
      contentCount,
      const DeepCollectionEquality().hash(_tiers),
      createdAt,
      updatedAt);

  /// Create a copy of Creator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatorImplCopyWith<_$CreatorImpl> get copyWith =>
      __$$CreatorImplCopyWithImpl<_$CreatorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatorImplToJson(
      this,
    );
  }
}

abstract class _Creator implements Creator {
  const factory _Creator(
      {required final String id,
      required final String userId,
      required final String displayName,
      required final String profileImageUrl,
      final String? coverImageUrl,
      required final String bio,
      required final String category,
      required final int subscriberCount,
      required final int contentCount,
      required final List<SubscriptionTier> tiers,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$CreatorImpl;

  factory _Creator.fromJson(Map<String, dynamic> json) = _$CreatorImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get displayName;
  @override
  String get profileImageUrl;
  @override
  String? get coverImageUrl;
  @override
  String get bio;
  @override
  String get category;
  @override
  int get subscriberCount;
  @override
  int get contentCount;
  @override
  List<SubscriptionTier> get tiers;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Creator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatorImplCopyWith<_$CreatorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionTier _$SubscriptionTierFromJson(Map<String, dynamic> json) {
  return _SubscriptionTier.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionTier {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  List<String> get benefits => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionTier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionTier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionTierCopyWith<SubscriptionTier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionTierCopyWith<$Res> {
  factory $SubscriptionTierCopyWith(
          SubscriptionTier value, $Res Function(SubscriptionTier) then) =
      _$SubscriptionTierCopyWithImpl<$Res, SubscriptionTier>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int price,
      List<String> benefits,
      bool isActive});
}

/// @nodoc
class _$SubscriptionTierCopyWithImpl<$Res, $Val extends SubscriptionTier>
    implements $SubscriptionTierCopyWith<$Res> {
  _$SubscriptionTierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionTier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? benefits = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      benefits: null == benefits
          ? _value.benefits
          : benefits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionTierImplCopyWith<$Res>
    implements $SubscriptionTierCopyWith<$Res> {
  factory _$$SubscriptionTierImplCopyWith(_$SubscriptionTierImpl value,
          $Res Function(_$SubscriptionTierImpl) then) =
      __$$SubscriptionTierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int price,
      List<String> benefits,
      bool isActive});
}

/// @nodoc
class __$$SubscriptionTierImplCopyWithImpl<$Res>
    extends _$SubscriptionTierCopyWithImpl<$Res, _$SubscriptionTierImpl>
    implements _$$SubscriptionTierImplCopyWith<$Res> {
  __$$SubscriptionTierImplCopyWithImpl(_$SubscriptionTierImpl _value,
      $Res Function(_$SubscriptionTierImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionTier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? benefits = null,
    Object? isActive = null,
  }) {
    return _then(_$SubscriptionTierImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      benefits: null == benefits
          ? _value._benefits
          : benefits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionTierImpl implements _SubscriptionTier {
  const _$SubscriptionTierImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required final List<String> benefits,
      required this.isActive})
      : _benefits = benefits;

  factory _$SubscriptionTierImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionTierImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final int price;
  final List<String> _benefits;
  @override
  List<String> get benefits {
    if (_benefits is EqualUnmodifiableListView) return _benefits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_benefits);
  }

  @override
  final bool isActive;

  @override
  String toString() {
    return 'SubscriptionTier(id: $id, name: $name, description: $description, price: $price, benefits: $benefits, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionTierImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(other._benefits, _benefits) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, price,
      const DeepCollectionEquality().hash(_benefits), isActive);

  /// Create a copy of SubscriptionTier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionTierImplCopyWith<_$SubscriptionTierImpl> get copyWith =>
      __$$SubscriptionTierImplCopyWithImpl<_$SubscriptionTierImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionTierImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionTier implements SubscriptionTier {
  const factory _SubscriptionTier(
      {required final String id,
      required final String name,
      required final String description,
      required final int price,
      required final List<String> benefits,
      required final bool isActive}) = _$SubscriptionTierImpl;

  factory _SubscriptionTier.fromJson(Map<String, dynamic> json) =
      _$SubscriptionTierImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  int get price;
  @override
  List<String> get benefits;
  @override
  bool get isActive;

  /// Create a copy of SubscriptionTier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionTierImplCopyWith<_$SubscriptionTierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

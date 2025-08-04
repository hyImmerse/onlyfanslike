// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Content _$ContentFromJson(Map<String, dynamic> json) {
  return _Content.fromJson(json);
}

/// @nodoc
mixin _$Content {
  String get id => throw _privateConstructorUsedError;
  String get creatorId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  ContentType get type => throw _privateConstructorUsedError;
  String get contentUrl => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  ContentVisibility get visibility => throw _privateConstructorUsedError;
  List<String>? get allowedTierIds => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Content to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentCopyWith<Content> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentCopyWith<$Res> {
  factory $ContentCopyWith(Content value, $Res Function(Content) then) =
      _$ContentCopyWithImpl<$Res, Content>;
  @useResult
  $Res call(
      {String id,
      String creatorId,
      String title,
      String? description,
      ContentType type,
      String contentUrl,
      String? thumbnailUrl,
      ContentVisibility visibility,
      List<String>? allowedTierIds,
      int likeCount,
      int viewCount,
      int commentCount,
      DateTime publishedAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ContentCopyWithImpl<$Res, $Val extends Content>
    implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorId = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? contentUrl = null,
    Object? thumbnailUrl = freezed,
    Object? visibility = null,
    Object? allowedTierIds = freezed,
    Object? likeCount = null,
    Object? viewCount = null,
    Object? commentCount = null,
    Object? publishedAt = null,
    Object? updatedAt = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType,
      contentUrl: null == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as ContentVisibility,
      allowedTierIds: freezed == allowedTierIds
          ? _value.allowedTierIds
          : allowedTierIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String creatorId,
      String title,
      String? description,
      ContentType type,
      String contentUrl,
      String? thumbnailUrl,
      ContentVisibility visibility,
      List<String>? allowedTierIds,
      int likeCount,
      int viewCount,
      int commentCount,
      DateTime publishedAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$ContentCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorId = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? contentUrl = null,
    Object? thumbnailUrl = freezed,
    Object? visibility = null,
    Object? allowedTierIds = freezed,
    Object? likeCount = null,
    Object? viewCount = null,
    Object? commentCount = null,
    Object? publishedAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ContentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType,
      contentUrl: null == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as ContentVisibility,
      allowedTierIds: freezed == allowedTierIds
          ? _value._allowedTierIds
          : allowedTierIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
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
class _$ContentImpl implements _Content {
  const _$ContentImpl(
      {required this.id,
      required this.creatorId,
      required this.title,
      this.description,
      required this.type,
      required this.contentUrl,
      this.thumbnailUrl,
      required this.visibility,
      final List<String>? allowedTierIds,
      required this.likeCount,
      required this.viewCount,
      required this.commentCount,
      required this.publishedAt,
      this.updatedAt})
      : _allowedTierIds = allowedTierIds;

  factory _$ContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentImplFromJson(json);

  @override
  final String id;
  @override
  final String creatorId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final ContentType type;
  @override
  final String contentUrl;
  @override
  final String? thumbnailUrl;
  @override
  final ContentVisibility visibility;
  final List<String>? _allowedTierIds;
  @override
  List<String>? get allowedTierIds {
    final value = _allowedTierIds;
    if (value == null) return null;
    if (_allowedTierIds is EqualUnmodifiableListView) return _allowedTierIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int likeCount;
  @override
  final int viewCount;
  @override
  final int commentCount;
  @override
  final DateTime publishedAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Content(id: $id, creatorId: $creatorId, title: $title, description: $description, type: $type, contentUrl: $contentUrl, thumbnailUrl: $thumbnailUrl, visibility: $visibility, allowedTierIds: $allowedTierIds, likeCount: $likeCount, viewCount: $viewCount, commentCount: $commentCount, publishedAt: $publishedAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.contentUrl, contentUrl) ||
                other.contentUrl == contentUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            const DeepCollectionEquality()
                .equals(other._allowedTierIds, _allowedTierIds) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      creatorId,
      title,
      description,
      type,
      contentUrl,
      thumbnailUrl,
      visibility,
      const DeepCollectionEquality().hash(_allowedTierIds),
      likeCount,
      viewCount,
      commentCount,
      publishedAt,
      updatedAt);

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentImplToJson(
      this,
    );
  }
}

abstract class _Content implements Content {
  const factory _Content(
      {required final String id,
      required final String creatorId,
      required final String title,
      final String? description,
      required final ContentType type,
      required final String contentUrl,
      final String? thumbnailUrl,
      required final ContentVisibility visibility,
      final List<String>? allowedTierIds,
      required final int likeCount,
      required final int viewCount,
      required final int commentCount,
      required final DateTime publishedAt,
      final DateTime? updatedAt}) = _$ContentImpl;

  factory _Content.fromJson(Map<String, dynamic> json) = _$ContentImpl.fromJson;

  @override
  String get id;
  @override
  String get creatorId;
  @override
  String get title;
  @override
  String? get description;
  @override
  ContentType get type;
  @override
  String get contentUrl;
  @override
  String? get thumbnailUrl;
  @override
  ContentVisibility get visibility;
  @override
  List<String>? get allowedTierIds;
  @override
  int get likeCount;
  @override
  int get viewCount;
  @override
  int get commentCount;
  @override
  DateTime get publishedAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

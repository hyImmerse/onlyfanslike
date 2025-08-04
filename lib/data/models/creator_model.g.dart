// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreatorModelImpl _$$CreatorModelImplFromJson(Map<String, dynamic> json) =>
    _$CreatorModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      bio: json['bio'] as String,
      category: json['category'] as String,
      subscriptionPrice: (json['subscriptionPrice'] as num).toDouble(),
      profileImageUrl: json['profileImageUrl'] as String?,
      bannerImageUrl: json['bannerImageUrl'] as String?,
      subscriberCount: (json['subscriberCount'] as num?)?.toInt() ?? 0,
      contentCount: (json['contentCount'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CreatorModelImplToJson(_$CreatorModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'bio': instance.bio,
      'category': instance.category,
      'subscriptionPrice': instance.subscriptionPrice,
      'profileImageUrl': instance.profileImageUrl,
      'bannerImageUrl': instance.bannerImageUrl,
      'subscriberCount': instance.subscriberCount,
      'contentCount': instance.contentCount,
      'rating': instance.rating,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreatorImpl _$$CreatorImplFromJson(Map<String, dynamic> json) =>
    _$CreatorImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      coverImageUrl: json['coverImageUrl'] as String?,
      bannerImageUrl: json['bannerImageUrl'] as String?,
      bio: json['bio'] as String,
      category: json['category'] as String,
      subscriberCount: (json['subscriberCount'] as num).toInt(),
      contentCount: (json['contentCount'] as num).toInt(),
      tiers: (json['tiers'] as List<dynamic>)
          .map((e) => SubscriptionTier.fromJson(e as Map<String, dynamic>))
          .toList(),
      subscriptionPrice: (json['subscriptionPrice'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CreatorImplToJson(_$CreatorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'profileImageUrl': instance.profileImageUrl,
      'coverImageUrl': instance.coverImageUrl,
      'bannerImageUrl': instance.bannerImageUrl,
      'bio': instance.bio,
      'category': instance.category,
      'subscriberCount': instance.subscriberCount,
      'contentCount': instance.contentCount,
      'tiers': instance.tiers,
      'subscriptionPrice': instance.subscriptionPrice,
      'rating': instance.rating,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$SubscriptionTierImpl _$$SubscriptionTierImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionTierImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
      benefits:
          (json['benefits'] as List<dynamic>).map((e) => e as String).toList(),
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$$SubscriptionTierImplToJson(
        _$SubscriptionTierImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'benefits': instance.benefits,
      'isActive': instance.isActive,
    };

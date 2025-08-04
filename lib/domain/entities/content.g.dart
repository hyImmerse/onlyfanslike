// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentImpl _$$ContentImplFromJson(Map<String, dynamic> json) =>
    _$ContentImpl(
      id: json['id'] as String,
      creatorId: json['creatorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: $enumDecode(_$ContentTypeEnumMap, json['type']),
      contentUrl: json['contentUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      visibility: $enumDecode(_$ContentVisibilityEnumMap, json['visibility']),
      allowedTierIds: (json['allowedTierIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      likeCount: (json['likeCount'] as num).toInt(),
      viewCount: (json['viewCount'] as num).toInt(),
      commentCount: (json['commentCount'] as num).toInt(),
      isPublic: json['isPublic'] as bool,
      likes: (json['likes'] as num).toInt(),
      views: (json['views'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ContentImplToJson(_$ContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creatorId': instance.creatorId,
      'title': instance.title,
      'description': instance.description,
      'type': _$ContentTypeEnumMap[instance.type]!,
      'contentUrl': instance.contentUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'visibility': _$ContentVisibilityEnumMap[instance.visibility]!,
      'allowedTierIds': instance.allowedTierIds,
      'likeCount': instance.likeCount,
      'viewCount': instance.viewCount,
      'commentCount': instance.commentCount,
      'isPublic': instance.isPublic,
      'likes': instance.likes,
      'views': instance.views,
      'createdAt': instance.createdAt.toIso8601String(),
      'publishedAt': instance.publishedAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ContentTypeEnumMap = {
  ContentType.image: 'image',
  ContentType.video: 'video',
  ContentType.text: 'text',
  ContentType.audio: 'audio',
  ContentType.article: 'article',
};

const _$ContentVisibilityEnumMap = {
  ContentVisibility.public: 'public',
  ContentVisibility.subscribersOnly: 'subscribersOnly',
  ContentVisibility.tierSpecific: 'tierSpecific',
};

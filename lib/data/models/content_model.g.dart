// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentModelImpl _$$ContentModelImplFromJson(Map<String, dynamic> json) =>
    _$ContentModelImpl(
      id: json['id'] as String,
      creatorId: json['creatorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      contentUrl: json['contentUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      type: $enumDecode(_$ContentTypeEnumMap, json['type']),
      visibility:
          $enumDecodeNullable(_$ContentVisibilityEnumMap, json['visibility']) ??
              ContentVisibility.public,
      allowedTierIds: (json['allowedTierIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      isPublic: json['isPublic'] as bool? ?? true,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      views: (json['views'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ContentModelImplToJson(_$ContentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creatorId': instance.creatorId,
      'title': instance.title,
      'description': instance.description,
      'contentUrl': instance.contentUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'type': _$ContentTypeEnumMap[instance.type]!,
      'visibility': _$ContentVisibilityEnumMap[instance.visibility]!,
      'allowedTierIds': instance.allowedTierIds,
      'likeCount': instance.likeCount,
      'viewCount': instance.viewCount,
      'commentCount': instance.commentCount,
      'isPublic': instance.isPublic,
      'likes': instance.likes,
      'views': instance.views,
      'createdAt': instance.createdAt?.toIso8601String(),
      'publishedAt': instance.publishedAt?.toIso8601String(),
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

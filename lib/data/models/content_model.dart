import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:creator_platform_demo/domain/entities/content.dart';

part 'content_model.freezed.dart';
part 'content_model.g.dart';

@freezed
class ContentModel with _$ContentModel {
  const factory ContentModel({
    required String id,
    required String creatorId,
    required String title,
    required String description,
    required String contentUrl,
    required String thumbnailUrl,
    required ContentType type,
    @Default(ContentVisibility.public) ContentVisibility visibility,
    @Default([]) List<String> allowedTierIds,
    @Default(0) int likeCount,
    @Default(0) int viewCount,
    @Default(0) int commentCount,
    @Default(true) bool isPublic,
    @Default(0) int likes,
    @Default(0) int views,
    DateTime? createdAt,
    DateTime? publishedAt,
    DateTime? updatedAt,
  }) = _ContentModel;

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    // Handle Firebase Timestamp conversion
    final Map<String, dynamic> processedJson = Map<String, dynamic>.from(json);
    
    // Convert Timestamps to DateTime
    if (processedJson['createdAt'] is Timestamp) {
      processedJson['createdAt'] = (processedJson['createdAt'] as Timestamp).toDate().toIso8601String();
    }
    if (processedJson['publishedAt'] is Timestamp) {
      processedJson['publishedAt'] = (processedJson['publishedAt'] as Timestamp).toDate().toIso8601String();
    }
    if (processedJson['updatedAt'] is Timestamp) {
      processedJson['updatedAt'] = (processedJson['updatedAt'] as Timestamp).toDate().toIso8601String();
    }
    
    // Convert ContentType string to enum
    if (processedJson['type'] is String) {
      processedJson['type'] = _stringToContentType(processedJson['type'] as String).name;
    }
    
    // Convert visibility string to enum
    if (processedJson['visibility'] is String) {
      processedJson['visibility'] = _stringToContentVisibility(processedJson['visibility'] as String).name;
    }
    
    return _$ContentModelFromJson(processedJson);
  }

  factory ContentModel.fromEntity(Content content) => ContentModel(
    id: content.id,
    creatorId: content.creatorId,
    title: content.title,
    description: content.description ?? '',
    contentUrl: content.contentUrl,
    thumbnailUrl: content.thumbnailUrl ?? '',
    type: content.type,
    visibility: content.visibility,
    allowedTierIds: content.allowedTierIds ?? [],
    likeCount: content.likeCount,
    viewCount: content.viewCount,
    commentCount: content.commentCount,
    isPublic: content.isPublic,
    likes: content.likes,
    views: content.views,
    createdAt: content.createdAt,
    publishedAt: content.publishedAt,
    updatedAt: content.updatedAt,
  );
}

extension ContentModelX on ContentModel {
  Content toEntity() => Content(
    id: id,
    creatorId: creatorId,
    title: title,
    description: description,
    contentUrl: contentUrl,
    thumbnailUrl: thumbnailUrl,
    type: type,
    visibility: visibility,
    allowedTierIds: allowedTierIds,
    likeCount: likeCount,
    viewCount: viewCount,
    commentCount: commentCount,
    isPublic: isPublic,
    likes: likes,
    views: views,
    createdAt: createdAt ?? DateTime.now(),
    publishedAt: publishedAt ?? DateTime.now(),
    updatedAt: updatedAt,
  );
}

// Helper functions for Firebase conversion
ContentType _stringToContentType(String type) {
  switch (type.toLowerCase()) {
    case 'video':
      return ContentType.video;
    case 'image':
      return ContentType.image;
    case 'article':
      return ContentType.article;
    case 'audio':
      return ContentType.audio;
    case 'stream':
      return ContentType.stream;
    default:
      return ContentType.video;
  }
}

ContentVisibility _stringToContentVisibility(String visibility) {
  switch (visibility.toLowerCase()) {
    case 'public':
      return ContentVisibility.public;
    case 'subscribersonly':
    case 'subscribers_only':
      return ContentVisibility.subscribersOnly;
    case 'tieronly':
    case 'tier_only':
      return ContentVisibility.tierOnly;
    default:
      return ContentVisibility.public;
  }
}
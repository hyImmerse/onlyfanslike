// import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase 패키지 설치 후 주석 해제
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:creator_platform_demo/domain/entities/content.dart';

part 'content_model.freezed.dart';
// part 'content_model.g.dart'; // Temporarily disabled until Firebase setup

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
    // Temporarily use manual parsing until Firebase setup is complete
    return ContentModel(
      id: json['id'] as String,
      creatorId: json['creatorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      contentUrl: json['contentUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      type: _stringToContentType(json['type'] as String),
      visibility: _stringToContentVisibility(json['visibility'] as String? ?? 'public'),
      allowedTierIds: List<String>.from(json['allowedTierIds'] ?? []),
      likeCount: json['likeCount'] as int? ?? 0,
      viewCount: json['viewCount'] as int? ?? 0,
      commentCount: json['commentCount'] as int? ?? 0,
      isPublic: json['isPublic'] as bool? ?? true,
      likes: json['likes'] as int? ?? 0,
      views: json['views'] as int? ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      publishedAt: json['publishedAt'] != null ? DateTime.parse(json['publishedAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
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
    case 'text':
      return ContentType.text;
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
    case 'tierspecific':
    case 'tier_specific':
      return ContentVisibility.tierSpecific;
    default:
      return ContentVisibility.public;
  }
}
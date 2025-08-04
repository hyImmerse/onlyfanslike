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
    @Default(false) bool isPublic,
    @Default(0) int likes,
    @Default(0) int views,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ContentModel;

  factory ContentModel.fromJson(Map<String, dynamic> json) => _$ContentModelFromJson(json);

  factory ContentModel.fromEntity(Content content) => ContentModel(
    id: content.id,
    creatorId: content.creatorId,
    title: content.title,
    description: content.description,
    contentUrl: content.contentUrl,
    thumbnailUrl: content.thumbnailUrl,
    type: content.type,
    isPublic: content.isPublic,
    likes: content.likes,
    views: content.views,
    createdAt: content.createdAt,
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
    isPublic: isPublic,
    likes: likes,
    views: views,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
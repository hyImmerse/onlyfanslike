import 'package:creator_platform_demo/domain/entities/content.dart';

abstract class ContentRepository {
  Future<List<Content>> getCreatorContents(String creatorId, {int page = 1, int limit = 20});
  Future<List<Content>> getSubscribedContents({int page = 1, int limit = 20});
  Future<Content> getContentById(String contentId);
  Future<List<Content>> getFreePreviewContents(String creatorId);
  Future<Content> uploadContent({
    required String creatorId,
    required String title,
    required String description,
    required String contentUrl,
    required String thumbnailUrl,
    required ContentType type,
    required bool isPublic,
  });
  Future<void> deleteContent(String contentId);
  Future<Content> updateContent(Content content);
}
import 'package:creator_platform_demo/domain/entities/content.dart';
import 'package:creator_platform_demo/domain/repositories/content_repository.dart';
import 'package:creator_platform_demo/data/models/content_model.dart';

class MockContentRepository implements ContentRepository {
  static final List<ContentModel> _mockContents = [
    // TechGuru's contents (c1)
    ContentModel(
      id: 'content_1',
      creatorId: 'c1',
      title: 'Flutter State Management: Riverpod vs BLoC',
      description: 'A comprehensive comparison of Flutter state management solutions',
      contentUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      thumbnailUrl: 'https://images.unsplash.com/photo-1618761714954-0b8cd0026356?w=800&h=450&fit=crop',
      type: ContentType.video,
      visibility: ContentVisibility.public,
      isPublic: true,
      likes: 1240,
      views: 8750,
      likeCount: 1240,
      viewCount: 8750,
      commentCount: 45,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      publishedAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ContentModel(
      id: 'content_2',
      creatorId: 'c1',
      title: 'Advanced Dart Features You Should Know',
      description: 'Exploring advanced Dart language features for better code',
      contentUrl: 'https://example.com/articles/dart-advanced.html',
      thumbnailUrl: 'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=800&h=450&fit=crop',
      type: ContentType.article,
      visibility: ContentVisibility.public,
      isPublic: true,
      likes: 890,
      views: 3420,
      likeCount: 890,
      viewCount: 3420,
      commentCount: 67,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      publishedAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    ContentModel(
      id: 'content_3',
      creatorId: 'c1',
      title: 'Flutter Performance Optimization Tips',
      description: 'Learn how to make your Flutter apps blazingly fast',
      contentUrl: 'https://example.com/podcasts/flutter-performance.mp3',
      thumbnailUrl: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&h=450&fit=crop',
      type: ContentType.audio,
      visibility: ContentVisibility.public,
      isPublic: true,
      likes: 567,
      views: 2890,
      likeCount: 567,
      viewCount: 2890,
      commentCount: 23,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      publishedAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    
    // ArtMaster's contents (c2)
    ContentModel(
      id: 'content_4',
      creatorId: 'c2',
      title: 'Digital Painting Fundamentals',
      description: 'Master the basics of digital painting with this comprehensive guide',
      contentUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      thumbnailUrl: 'https://images.unsplash.com/photo-1596348158863-a43c93c7d56c?w=800&h=450&fit=crop',
      type: ContentType.video,
      visibility: ContentVisibility.public,
      isPublic: true,
      likes: 2340,
      views: 12560,
      likeCount: 2340,
      viewCount: 12560,
      commentCount: 156,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      publishedAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    ContentModel(
      id: 'content_5',
      creatorId: 'c2',
      title: 'Character Design Workshop',
      description: 'Step-by-step character design process from concept to completion',
      contentUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      thumbnailUrl: 'https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=800&h=450&fit=crop',
      type: ContentType.video,
      visibility: ContentVisibility.public,
      isPublic: true,
      likes: 1890,
      views: 7340,
      likeCount: 1890,
      viewCount: 7340,
      commentCount: 89,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      publishedAt: DateTime.now().subtract(const Duration(days: 8)),
      updatedAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  @override
  Future<List<Content>> getCreatorContents(String creatorId, {int page = 1, int limit = 20}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final creatorContents = _mockContents
        .where((content) => content.creatorId == creatorId)
        .map((model) => model.toEntity())
        .toList();
    
    // Sort by creation date (newest first)
    creatorContents.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    // Apply pagination
    final startIndex = (page - 1) * limit;
    final endIndex = (startIndex + limit).clamp(0, creatorContents.length);
    
    if (startIndex >= creatorContents.length) {
      return [];
    }
    
    return creatorContents.sublist(startIndex, endIndex);
  }

  @override
  Future<List<Content>> getSubscribedContents({int page = 1, int limit = 20}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    // For demo purposes, return public content
    final contents = _mockContents
        .where((content) => content.isPublic)
        .map((model) => model.toEntity())
        .toList();
    
    // Sort by creation date (newest first)
    contents.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    // Apply pagination
    final startIndex = (page - 1) * limit;
    final endIndex = (startIndex + limit).clamp(0, contents.length);
    
    if (startIndex >= contents.length) {
      return [];
    }
    
    return contents.sublist(startIndex, endIndex);
  }

  @override
  Future<Content> getContentById(String contentId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    
    final contentModel = _mockContents.firstWhere(
      (content) => content.id == contentId,
      orElse: () => throw Exception('Content not found'),
    );
    
    return contentModel.toEntity();
  }

  @override
  Future<List<Content>> getFreePreviewContents(String creatorId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    final previewContents = _mockContents
        .where((content) => content.creatorId == creatorId && content.isPublic)
        .take(3)
        .map((model) => model.toEntity())
        .toList();
    
    return previewContents;
  }

  @override
  Future<Content> uploadContent({
    required String creatorId,
    required String title,
    required String description,
    required String contentUrl,
    required String thumbnailUrl,
    required ContentType type,
    required bool isPublic,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    final newContent = ContentModel(
      id: 'content_${DateTime.now().millisecondsSinceEpoch}',
      creatorId: creatorId,
      title: title,
      description: description,
      contentUrl: contentUrl,
      thumbnailUrl: thumbnailUrl,
      type: type,
      visibility: isPublic ? ContentVisibility.public : ContentVisibility.subscribersOnly,
      isPublic: isPublic,
      likes: 0,
      views: 0,
      likeCount: 0,
      viewCount: 0,
      commentCount: 0,
      createdAt: DateTime.now(),
      publishedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _mockContents.add(newContent);
    return newContent.toEntity();
  }

  @override
  Future<void> deleteContent(String contentId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    final index = _mockContents.indexWhere((content) => content.id == contentId);
    
    if (index == -1) {
      throw Exception('Content not found');
    }
    
    _mockContents.removeAt(index);
  }

  @override
  Future<Content> updateContent(Content content) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    final index = _mockContents.indexWhere((c) => c.id == content.id);
    
    if (index == -1) {
      throw Exception('Content not found');
    }
    
    final updatedModel = ContentModel.fromEntity(content).copyWith(
      updatedAt: DateTime.now(),
    );
    
    _mockContents[index] = updatedModel;
    return updatedModel.toEntity();
  }
}
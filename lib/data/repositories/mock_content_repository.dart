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
      contentUrl: 'https://example.com/videos/flutter-state-mgmt.mp4',
      thumbnailUrl: 'https://example.com/thumbnails/flutter-state-mgmt.jpg',
      type: ContentType.video,
      isPublic: true,
      likes: 1240,
      views: 8750,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ContentModel(
      id: 'content_2',
      creatorId: 'c1',
      title: 'Advanced Dart Features You Should Know',
      description: 'Exploring advanced Dart language features for better code',
      contentUrl: 'https://example.com/articles/dart-advanced.html',
      thumbnailUrl: 'https://example.com/thumbnails/dart-advanced.jpg',
      type: ContentType.article,
      isPublic: false,
      likes: 890,
      views: 3420,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    ContentModel(
      id: 'content_3',
      creatorId: 'c1',
      title: 'Flutter Performance Optimization Tips',
      description: 'Learn how to make your Flutter apps blazingly fast',
      contentUrl: 'https://example.com/podcasts/flutter-performance.mp3',
      thumbnailUrl: 'https://example.com/thumbnails/flutter-performance.jpg',
      type: ContentType.audio,
      isPublic: true,
      likes: 567,
      views: 2890,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    
    // ArtMaster's contents (c2)
    ContentModel(
      id: 'content_4',
      creatorId: 'c2',
      title: 'Digital Painting Fundamentals',
      description: 'Master the basics of digital painting with this comprehensive guide',
      contentUrl: 'https://example.com/videos/digital-painting-basics.mp4',
      thumbnailUrl: 'https://example.com/thumbnails/digital-painting.jpg',
      type: ContentType.video,
      isPublic: true,
      likes: 2340,
      views: 12560,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    ContentModel(
      id: 'content_5',
      creatorId: 'c2',
      title: 'Character Design Workshop',
      description: 'Step-by-step character design process from concept to completion',
      contentUrl: 'https://example.com/videos/character-design.mp4',
      thumbnailUrl: 'https://example.com/thumbnails/character-design.jpg',
      type: ContentType.video,
      isPublic: false,
      likes: 1890,
      views: 7650,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      updatedAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
    
    // FitnessCoach's contents (c3)
    ContentModel(
      id: 'content_6',
      creatorId: 'c3',
      title: 'HIIT Workout for Beginners',
      description: '20-minute high-intensity interval training for beginners',
      contentUrl: 'https://example.com/videos/hiit-beginners.mp4',
      thumbnailUrl: 'https://example.com/thumbnails/hiit-workout.jpg',
      type: ContentType.video,
      isPublic: true,
      likes: 3450,
      views: 18920,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ContentModel(
      id: 'content_7',
      creatorId: 'c3',
      title: 'Nutrition Guide for Weight Loss',
      description: 'Complete nutrition guide with meal plans and tips',
      contentUrl: 'https://example.com/articles/nutrition-guide.html',
      thumbnailUrl: 'https://example.com/thumbnails/nutrition.jpg',
      type: ContentType.article,
      isPublic: false,
      likes: 1560,
      views: 8430,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      updatedAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    
    // MusicProducer's contents (c4)
    ContentModel(
      id: 'content_8',
      creatorId: 'c4',
      title: 'Beat Making with FL Studio',
      description: 'Learn to create professional beats using FL Studio',
      contentUrl: 'https://example.com/videos/fl-studio-beats.mp4',
      thumbnailUrl: 'https://example.com/thumbnails/fl-studio.jpg',
      type: ContentType.video,
      isPublic: true,
      likes: 890,
      views: 4560,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      updatedAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    
    // CookingChef's contents (c5)
    ContentModel(
      id: 'content_9',
      creatorId: 'c5',
      title: 'Perfect Pasta Carbonara Recipe',
      description: 'Traditional Italian carbonara recipe with step-by-step instructions',
      contentUrl: 'https://example.com/videos/carbonara-recipe.mp4',
      thumbnailUrl: 'https://example.com/thumbnails/carbonara.jpg',
      type: ContentType.video,
      isPublic: true,
      likes: 2780,
      views: 15640,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ContentModel(
      id: 'content_10',
      creatorId: 'c5',
      title: 'Knife Skills Masterclass',
      description: 'Professional knife techniques every home cook should know',
      contentUrl: 'https://example.com/videos/knife-skills.mp4',
      thumbnailUrl: 'https://example.com/thumbnails/knife-skills.jpg',
      type: ContentType.video,
      isPublic: false,
      likes: 1920,
      views: 9340,
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
      updatedAt: DateTime.now().subtract(const Duration(days: 14)),
    ),
  ];

  @override
  Future<List<Content>> getCreatorContents(String creatorId, {int page = 1, int limit = 20}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final creatorContents = _mockContents
        .where((content) => content.creatorId == creatorId)
        .toList();
    
    // Sort by creation date (most recent first)
    creatorContents.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    
    final startIndex = (page - 1) * limit;
    final endIndex = (startIndex + limit).clamp(0, creatorContents.length);
    
    if (startIndex >= creatorContents.length) {
      return [];
    }
    
    return creatorContents
        .sublist(startIndex, endIndex)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<List<Content>> getSubscribedContents({int page = 1, int limit = 20}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    // For demo purposes, return all contents from subscribed creators
    // In a real app, this would filter based on user's subscriptions
    final subscribedContents = _mockContents.toList();
    
    // Sort by creation date (most recent first)
    subscribedContents.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    
    final startIndex = (page - 1) * limit;
    final endIndex = (startIndex + limit).clamp(0, subscribedContents.length);
    
    if (startIndex >= subscribedContents.length) {
      return [];
    }
    
    return subscribedContents
        .sublist(startIndex, endIndex)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<Content> getContentById(String contentId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final contentModel = _mockContents.where((c) => c.id == contentId).firstOrNull;
    
    if (contentModel == null) {
      throw Exception('Content not found');
    }
    
    // Increment view count
    final index = _mockContents.indexWhere((c) => c.id == contentId);
    _mockContents[index] = contentModel.copyWith(views: contentModel.views + 1);
    
    return _mockContents[index].toEntity();
  }

  @override
  Future<List<Content>> getFreePreviewContents(String creatorId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final freeContents = _mockContents
        .where((content) => content.creatorId == creatorId && content.isPublic)
        .toList();
    
    // Sort by views (most popular first)
    freeContents.sort((a, b) => b.views.compareTo(a.views));
    
    // Limit to 3 preview contents
    return freeContents
        .take(3)
        .map((model) => model.toEntity())
        .toList();
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
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Validate input
    if (title.trim().isEmpty) {
      throw Exception('Title is required');
    }
    
    if (description.trim().isEmpty) {
      throw Exception('Description is required');
    }
    
    if (contentUrl.trim().isEmpty) {
      throw Exception('Content URL is required');
    }
    
    // Create new content
    final newContentModel = ContentModel(
      id: 'content_${DateTime.now().millisecondsSinceEpoch}',
      creatorId: creatorId,
      title: title,
      description: description,
      contentUrl: contentUrl,
      thumbnailUrl: thumbnailUrl,
      type: type,
      isPublic: isPublic,
      likes: 0,
      views: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _mockContents.add(newContentModel);
    
    return newContentModel.toEntity();
  }

  @override
  Future<void> deleteContent(String contentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final index = _mockContents.indexWhere((c) => c.id == contentId);
    if (index == -1) {
      throw Exception('Content not found');
    }
    
    _mockContents.removeAt(index);
  }

  @override
  Future<Content> updateContent(Content content) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final index = _mockContents.indexWhere((c) => c.id == content.id);
    if (index == -1) {
      throw Exception('Content not found');
    }
    
    final updatedContentModel = ContentModel.fromEntity(content).copyWith(
      updatedAt: DateTime.now(),
    );
    
    _mockContents[index] = updatedContentModel;
    
    return updatedContentModel.toEntity();
  }
}
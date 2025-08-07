import 'package:creator_platform_demo/domain/entities/creator.dart';
import 'package:creator_platform_demo/domain/repositories/creator_repository.dart';
import 'package:creator_platform_demo/data/models/creator_model.dart';

class MockCreatorRepository implements CreatorRepository {
  static final List<CreatorModel> _mockCreators = [
    CreatorModel(
      id: 'c1',
      userId: '1',
      displayName: 'TechGuru',
      bio: 'Sharing the latest in technology and programming tips',
      category: 'Technology',
      subscriptionPrice: 9.99,
      profileImageUrl: 'assets/images/코딩강사.png',
      bannerImageUrl: 'https://images.unsplash.com/photo-1517077304055-6e89abbf09b0?w=1200&h=400&fit=crop',
      subscriberCount: 15420,
      contentCount: 84,
      rating: 4.8,
      createdAt: DateTime.now().subtract(const Duration(days: 180)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    CreatorModel(
      id: 'c2',
      userId: '3',
      displayName: 'ArtMaster',
      bio: 'Digital art tutorials and creative inspiration',
      category: 'Art',
      subscriptionPrice: 12.99,
      profileImageUrl: 'assets/images/미술가.png',
      bannerImageUrl: 'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=1200&h=400&fit=crop',
      subscriberCount: 8750,
      contentCount: 156,
      rating: 4.9,
      createdAt: DateTime.now().subtract(const Duration(days: 120)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    CreatorModel(
      id: 'c3',
      userId: '4',
      displayName: 'FitnessCoach',
      bio: 'Professional fitness training and nutrition guidance',
      category: 'Fitness',
      subscriptionPrice: 14.99,
      profileImageUrl: 'assets/images/트레이너.png',
      bannerImageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=1200&h=400&fit=crop',
      subscriberCount: 22340,
      contentCount: 205,
      rating: 4.7,
      createdAt: DateTime.now().subtract(const Duration(days: 240)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    CreatorModel(
      id: 'c4',
      userId: '5',
      displayName: 'MusicProducer',
      bio: 'Music production tutorials and beat making',
      category: 'Music',
      subscriptionPrice: 11.99,
      profileImageUrl: 'assets/images/가수.png',
      bannerImageUrl: 'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?w=1200&h=400&fit=crop',
      subscriberCount: 5680,
      contentCount: 94,
      rating: 4.6,
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    CreatorModel(
      id: 'c5',
      userId: '6',
      displayName: 'CookingChef',
      bio: 'Delicious recipes and cooking techniques',
      category: 'Cooking',
      subscriptionPrice: 8.99,
      profileImageUrl: 'assets/images/요리사.png',
      bannerImageUrl: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=1200&h=400&fit=crop',
      subscriberCount: 18920,
      contentCount: 269,
      rating: 4.9,
      createdAt: DateTime.now().subtract(const Duration(days: 300)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
  ];

  @override
  Future<List<Creator>> getPopularCreators({int page = 1, int limit = 20}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Sort by subscriber count (descending)
    final sortedCreators = List<CreatorModel>.from(_mockCreators)
      ..sort((a, b) => b.subscriberCount.compareTo(a.subscriberCount));
    
    final startIndex = (page - 1) * limit;
    final endIndex = (startIndex + limit).clamp(0, sortedCreators.length);
    
    if (startIndex >= sortedCreators.length) {
      return [];
    }
    
    return sortedCreators
        .sublist(startIndex, endIndex)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<List<Creator>> searchCreators(String query) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    if (query.trim().isEmpty) {
      return [];
    }
    
    final lowercaseQuery = query.toLowerCase();
    final filteredCreators = _mockCreators.where((creator) {
      return creator.displayName.toLowerCase().contains(lowercaseQuery) ||
          creator.bio.toLowerCase().contains(lowercaseQuery) ||
          creator.category.toLowerCase().contains(lowercaseQuery);
    }).toList();
    
    return filteredCreators.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Creator>> getCreatorsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final filteredCreators = _mockCreators.where((creator) {
      return creator.category.toLowerCase() == category.toLowerCase();
    }).toList();
    
    // Sort by rating (descending)
    filteredCreators.sort((a, b) => b.rating.compareTo(a.rating));
    
    return filteredCreators.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Creator> getCreatorById(String creatorId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final creatorModel = _mockCreators.where((c) => c.id == creatorId).firstOrNull;
    
    if (creatorModel == null) {
      throw Exception('Creator not found');
    }
    
    return creatorModel.toEntity();
  }

  @override
  Future<Creator> updateCreatorProfile(Creator creator) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    final index = _mockCreators.indexWhere((c) => c.id == creator.id);
    if (index == -1) {
      throw Exception('Creator not found');
    }
    
    final updatedCreatorModel = CreatorModel.fromEntity(creator).copyWith(
      updatedAt: DateTime.now(),
    );
    
    _mockCreators[index] = updatedCreatorModel;
    
    return updatedCreatorModel.toEntity();
  }

  @override
  Future<bool> isCreator(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return _mockCreators.any((creator) => creator.userId == userId);
  }

  @override
  Future<Creator> becomeCreator({
    required String userId,
    required String bio,
    required String category,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    
    // Check if user is already a creator
    final existingCreator = _mockCreators.where((c) => c.userId == userId).firstOrNull;
    if (existingCreator != null) {
      throw Exception('User is already a creator');
    }
    
    // Validate input
    if (bio.trim().isEmpty) {
      throw Exception('Bio is required');
    }
    
    if (category.trim().isEmpty) {
      throw Exception('Category is required');
    }
    
    // Create new creator
    final newCreatorModel = CreatorModel(
      id: 'c${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      displayName: 'New Creator', // This would typically come from user input
      bio: bio,
      category: category,
      subscriptionPrice: 9.99, // Default subscription price
      profileImageUrl: null,
      bannerImageUrl: null,
      subscriberCount: 0,
      contentCount: 0,
      rating: 0.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _mockCreators.add(newCreatorModel);
    
    return newCreatorModel.toEntity();
  }
}
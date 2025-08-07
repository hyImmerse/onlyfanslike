import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/creator.dart';
import 'package:creator_platform_demo/presentation/providers/repository_providers.dart';

/// Creator List State Provider
/// Manages the list of creators and their loading state
final creatorListProvider = FutureProvider<List<Creator>>((ref) async {
  final creatorRepository = ref.watch(RepositoryProviders.creator);
  return await creatorRepository.getPopularCreators();
});

/// Single Creator Provider
/// Gets a specific creator by ID
final creatorProvider = FutureProvider.family<Creator, String>((ref, creatorId) async {
  final creatorRepository = ref.watch(RepositoryProviders.creator);
  return await creatorRepository.getCreatorById(creatorId);
});

/// Creator Search Provider
/// Manages creator search functionality
final creatorSearchProvider = StateNotifierProvider<CreatorSearchNotifier, CreatorSearchState>((ref) {
  final creatorRepository = ref.watch(RepositoryProviders.creator);
  return CreatorSearchNotifier(creatorRepository);
});

/// Creator Search State
class CreatorSearchState {
  const CreatorSearchState({
    this.query = '',
    this.results = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  final String query;
  final List<Creator> results;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  CreatorSearchState copyWith({
    String? query,
    List<Creator>? results,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return CreatorSearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Creator Search Notifier
class CreatorSearchNotifier extends StateNotifier<CreatorSearchState> {
  CreatorSearchNotifier(this._creatorRepository) : super(const CreatorSearchState());

  final dynamic _creatorRepository;

  /// Search creators by query
  Future<void> searchCreators(String query) async {
    if (query.trim().isEmpty) {
      state = const CreatorSearchState();
      return;
    }

    try {
      state = state.copyWith(isLoading: true, hasError: false);
      
      final results = await _creatorRepository.searchCreators(query.trim());
      
      state = state.copyWith(
        query: query.trim(),
        results: results,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// Clear search results
  void clearSearch() {
    state = const CreatorSearchState();
  }
}

/// Creator Categories Provider
/// Provides list of available creator categories
final creatorCategoriesProvider = Provider<List<String>>((ref) {
  return [
    '기술',
    '예술',
    '피트니스',
    '음악',
    '요리',
    '게임',
    '교육',
    '라이프스타일',
    '여행',
    '패션',
  ];
});

/// Selected Category Provider
/// Manages currently selected category filter
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Filtered Creators Provider
/// Provides creators filtered by selected category
final filteredCreatorsProvider = FutureProvider<List<Creator>>((ref) async {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final creatorRepository = ref.watch(RepositoryProviders.creator);
  
  if (selectedCategory == null) {
    return await creatorRepository.getPopularCreators();
  }
  
  return await creatorRepository.getCreatorsByCategory(selectedCategory);
});
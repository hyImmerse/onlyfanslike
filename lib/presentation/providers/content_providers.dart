import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/content.dart';
import 'package:creator_platform_demo/presentation/providers/repository_providers.dart';

/// Creator Contents Provider
/// Gets all contents for a specific creator
final creatorContentsProvider = FutureProvider.family<List<Content>, String>((ref, creatorId) async {
  final contentRepository = ref.watch(RepositoryProviders.content);
  return await contentRepository.getCreatorContents(creatorId);
});

/// Free Preview Contents Provider
/// Gets free preview contents for a specific creator
final freePreviewContentsProvider = FutureProvider.family<List<Content>, String>((ref, creatorId) async {
  final contentRepository = ref.watch(RepositoryProviders.content);
  return await contentRepository.getFreePreviewContents(creatorId);
});

/// Subscribed Contents Provider
/// Gets contents from subscribed creators
final subscribedContentsProvider = FutureProvider<List<Content>>((ref) async {
  final contentRepository = ref.watch(RepositoryProviders.content);
  return await contentRepository.getSubscribedContents();
});

/// Single Content Provider
/// Gets a specific content by ID
final contentProvider = FutureProvider.family<Content, String>((ref, contentId) async {
  final contentRepository = ref.watch(RepositoryProviders.content);
  return await contentRepository.getContentById(contentId);
});

/// Content Upload Notifier
/// Manages content upload functionality
final contentUploadProvider = StateNotifierProvider<ContentUploadNotifier, ContentUploadState>((ref) {
  final contentRepository = ref.watch(RepositoryProviders.content);
  return ContentUploadNotifier(contentRepository);
});

/// Content Upload State
class ContentUploadState {
  const ContentUploadState({
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.successMessage,
    this.uploadProgress = 0.0,
  });

  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final String? successMessage;
  final double uploadProgress;

  ContentUploadState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    String? successMessage,
    double? uploadProgress,
  }) {
    return ContentUploadState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      uploadProgress: uploadProgress ?? this.uploadProgress,
    );
  }
}

/// Content Upload Notifier
class ContentUploadNotifier extends StateNotifier<ContentUploadState> {
  ContentUploadNotifier(this._contentRepository) : super(const ContentUploadState());

  final dynamic _contentRepository;

  /// Upload new content
  Future<void> uploadContent({
    required String creatorId,
    required String title,
    required String description,
    required String contentUrl,
    required String thumbnailUrl,
    required ContentType type,
    required bool isPublic,
  }) async {
    try {
      state = state.copyWith(isLoading: true, hasError: false, uploadProgress: 0.0);
      
      // Simulate upload progress
      for (int i = 1; i <= 5; i++) {
        await Future.delayed(const Duration(milliseconds: 200));
        state = state.copyWith(uploadProgress: i * 0.2);
      }
      
      await _contentRepository.uploadContent(
        creatorId: creatorId,
        title: title,
        description: description,
        contentUrl: contentUrl,
        thumbnailUrl: thumbnailUrl,
        type: type,
        isPublic: isPublic,
      );
      
      state = state.copyWith(
        isLoading: false,
        uploadProgress: 1.0,
        successMessage: '콘텐츠가 성공적으로 업로드되었습니다!',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  /// Clear messages
  void clearMessages() {
    state = state.copyWith(
      hasError: false,
      errorMessage: null,
      successMessage: null,
      uploadProgress: 0.0,
    );
  }
}
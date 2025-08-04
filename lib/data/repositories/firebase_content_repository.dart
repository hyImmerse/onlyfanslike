import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creator_platform_demo/domain/entities/content.dart';
import 'package:creator_platform_demo/domain/repositories/content_repository.dart';
import 'package:creator_platform_demo/data/models/content_model.dart';

class FirebaseContentRepository implements ContentRepository {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'contents';

  FirebaseContentRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _contentCollection =>
      _firestore.collection(_collectionName);

  @override
  Future<List<Content>> getCreatorContents(String creatorId, {int page = 1, int limit = 20}) async {
    try {
      final query = _contentCollection
          .where('creatorId', isEqualTo: creatorId)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      final querySnapshot = page > 1
          ? await _getPaginatedQuery(query, creatorId, page, limit)
          : await query.get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return ContentModel.fromJson(data).toEntity();
      }).toList();
    } catch (e) {
      throw Exception('Failed to get creator contents: $e');
    }
  }

  @override
  Future<List<Content>> getSubscribedContents({int page = 1, int limit = 20}) async {
    try {
      // For subscribed contents, we would normally filter by user's subscriptions
      // For now, we'll return recent public contents
      final query = _contentCollection
          .where('isPublic', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      final querySnapshot = page > 1
          ? await _getPaginatedQueryForSubscribed(query, page, limit)
          : await query.get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return ContentModel.fromJson(data).toEntity();
      }).toList();
    } catch (e) {
      throw Exception('Failed to get subscribed contents: $e');
    }
  }

  @override
  Future<Content> getContentById(String contentId) async {
    try {
      final doc = await _contentCollection.doc(contentId).get();

      if (!doc.exists) {
        throw Exception('Content not found');
      }

      final data = doc.data()!;
      data['id'] = doc.id;

      // Increment view count
      await _contentCollection.doc(contentId).update({
        'views': FieldValue.increment(1),
        'viewCount': FieldValue.increment(1),
      });

      return ContentModel.fromJson(data).toEntity();
    } catch (e) {
      throw Exception('Failed to get content: $e');
    }
  }

  @override
  Future<List<Content>> getFreePreviewContents(String creatorId) async {
    try {
      final querySnapshot = await _contentCollection
          .where('creatorId', isEqualTo: creatorId)
          .where('isPublic', isEqualTo: true)
          .orderBy('views', descending: true)
          .limit(3)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return ContentModel.fromJson(data).toEntity();
      }).toList();
    } catch (e) {
      throw Exception('Failed to get free preview contents: $e');
    }
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
    try {
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

      final now = DateTime.now();
      final contentData = {
        'creatorId': creatorId,
        'title': title,
        'description': description,
        'contentUrl': contentUrl,
        'thumbnailUrl': thumbnailUrl,
        'type': _contentTypeToString(type),
        'visibility': isPublic ? 'public' : 'subscribersOnly',
        'isPublic': isPublic,
        'likes': 0,
        'views': 0,
        'likeCount': 0,
        'viewCount': 0,
        'commentCount': 0,
        'allowedTierIds': <String>[],
        'createdAt': now,
        'publishedAt': now,
        'updatedAt': now,
      };

      final docRef = await _contentCollection.add(contentData);
      final doc = await docRef.get();
      
      final data = doc.data()!;
      data['id'] = doc.id;

      return ContentModel.fromJson(data).toEntity();
    } catch (e) {
      throw Exception('Failed to upload content: $e');
    }
  }

  @override
  Future<void> deleteContent(String contentId) async {
    try {
      final doc = await _contentCollection.doc(contentId).get();
      
      if (!doc.exists) {
        throw Exception('Content not found');
      }

      await _contentCollection.doc(contentId).delete();
    } catch (e) {
      throw Exception('Failed to delete content: $e');
    }
  }

  @override
  Future<Content> updateContent(Content content) async {
    try {
      final contentData = {
        'title': content.title,
        'description': content.description,
        'contentUrl': content.contentUrl,
        'thumbnailUrl': content.thumbnailUrl,
        'type': _contentTypeToString(content.type),
        'visibility': content.visibility.name,
        'isPublic': content.isPublic,
        'allowedTierIds': content.allowedTierIds,
        'updatedAt': DateTime.now(),
      };

      await _contentCollection.doc(content.id).update(contentData);

      final doc = await _contentCollection.doc(content.id).get();
      final data = doc.data()!;
      data['id'] = doc.id;

      return ContentModel.fromJson(data).toEntity();
    } catch (e) {
      throw Exception('Failed to update content: $e');
    }
  }

  // Helper method to get paginated query for creator contents
  Future<QuerySnapshot<Map<String, dynamic>>> _getPaginatedQuery(
    Query<Map<String, dynamic>> baseQuery,
    String creatorId,
    int page,
    int limit,
  ) async {
    // Calculate skip count
    final skip = (page - 1) * limit;
    
    // Get the last document of the previous page
    final previousPageSnapshot = await _contentCollection
        .where('creatorId', isEqualTo: creatorId)
        .orderBy('createdAt', descending: true)
        .limit(skip)
        .get();

    if (previousPageSnapshot.docs.isEmpty) {
      return await baseQuery.get();
    }

    final lastDoc = previousPageSnapshot.docs.last;
    return await baseQuery.startAfterDocument(lastDoc).get();
  }

  // Helper method to get paginated query for subscribed contents
  Future<QuerySnapshot<Map<String, dynamic>>> _getPaginatedQueryForSubscribed(
    Query<Map<String, dynamic>> baseQuery,
    int page,
    int limit,
  ) async {
    // Calculate skip count
    final skip = (page - 1) * limit;
    
    // Get the last document of the previous page
    final previousPageSnapshot = await _contentCollection
        .where('isPublic', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(skip)
        .get();

    if (previousPageSnapshot.docs.isEmpty) {
      return await baseQuery.get();
    }

    final lastDoc = previousPageSnapshot.docs.last;
    return await baseQuery.startAfterDocument(lastDoc).get();
  }

  // Helper method to convert ContentType enum to string
  String _contentTypeToString(ContentType type) {
    switch (type) {
      case ContentType.video:
        return 'video';
      case ContentType.image:
        return 'image';
      case ContentType.article:
        return 'article';
      case ContentType.audio:
        return 'audio';
      case ContentType.stream:
        return 'stream';
    }
  }
}
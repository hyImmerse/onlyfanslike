import 'package:creator_platform_demo/domain/entities/creator.dart';

abstract class CreatorRepository {
  Future<List<Creator>> getPopularCreators({int page = 1, int limit = 20});
  Future<List<Creator>> searchCreators(String query);
  Future<List<Creator>> getCreatorsByCategory(String category);
  Future<Creator> getCreatorById(String creatorId);
  Future<Creator> updateCreatorProfile(Creator creator);
  Future<bool> isCreator(String userId);
  Future<Creator> becomeCreator({
    required String userId,
    required String bio,
    required String category,
  });
}
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:creator_platform_demo/domain/entities/creator.dart';

part 'creator_model.freezed.dart';
part 'creator_model.g.dart';

@freezed
class CreatorModel with _$CreatorModel {
  const factory CreatorModel({
    required String id,
    required String userId,
    required String displayName,
    required String bio,
    required String category,
    required double subscriptionPrice,
    String? profileImageUrl,
    String? bannerImageUrl,
    @Default(0) int subscriberCount,
    @Default(0) int contentCount,
    @Default(0.0) double rating,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CreatorModel;

  factory CreatorModel.fromJson(Map<String, dynamic> json) => _$CreatorModelFromJson(json);

  factory CreatorModel.fromEntity(Creator creator) => CreatorModel(
    id: creator.id,
    userId: creator.userId,
    displayName: creator.displayName,
    bio: creator.bio,
    category: creator.category,
    subscriptionPrice: creator.subscriptionPrice,
    profileImageUrl: creator.profileImageUrl,
    bannerImageUrl: creator.bannerImageUrl,
    subscriberCount: creator.subscriberCount,
    contentCount: creator.contentCount,
    rating: creator.rating,
    createdAt: creator.createdAt,
    updatedAt: creator.updatedAt,
  );
}

extension CreatorModelX on CreatorModel {
  Creator toEntity() => Creator(
    id: id,
    userId: userId,
    displayName: displayName,
    bio: bio,
    category: category,
    subscriptionPrice: subscriptionPrice,
    profileImageUrl: profileImageUrl,
    bannerImageUrl: bannerImageUrl,
    subscriberCount: subscriberCount,
    contentCount: contentCount,
    rating: rating,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
import 'package:freezed_annotation/freezed_annotation.dart';

part 'creator.freezed.dart';
part 'creator.g.dart';

@freezed
class Creator with _$Creator {
  const factory Creator({
    required String id,
    required String userId,
    required String displayName,
    required String profileImageUrl,
    String? coverImageUrl,
    required String bio,
    required String category,
    required int subscriberCount,
    required int contentCount,
    required List<SubscriptionTier> tiers,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Creator;
  
  factory Creator.fromJson(Map<String, dynamic> json) => _$CreatorFromJson(json);
}

@freezed
class SubscriptionTier with _$SubscriptionTier {
  const factory SubscriptionTier({
    required String id,
    required String name,
    required String description,
    required int price,
    required List<String> benefits,
    required bool isActive,
  }) = _SubscriptionTier;
  
  factory SubscriptionTier.fromJson(Map<String, dynamic> json) => _$SubscriptionTierFromJson(json);
}
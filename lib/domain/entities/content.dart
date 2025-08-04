import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

enum ContentType { image, video, text, audio, article }
enum ContentVisibility { public, subscribersOnly, tierSpecific }

@freezed
class Content with _$Content {
  const factory Content({
    required String id,
    required String creatorId,
    required String title,
    String? description,
    required ContentType type,
    required String contentUrl,
    String? thumbnailUrl,
    required ContentVisibility visibility,
    List<String>? allowedTierIds,
    required int likeCount,
    required int viewCount,
    required int commentCount,
    required bool isPublic,
    required int likes,
    required int views,
    required DateTime createdAt,
    required DateTime publishedAt,
    DateTime? updatedAt,
  }) = _Content;
  
  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
}
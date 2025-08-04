import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creator_platform_demo/domain/entities/content.dart';
import 'package:intl/intl.dart';

/// Content Card Widget
/// Displays content information in a card format
class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.content,
    this.onTap,
    this.showCreatorInfo = false,
    this.isLocked = false,
  });

  final Content content;
  final VoidCallback? onTap;
  final bool showCreatorInfo;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content Thumbnail
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                    child: content.thumbnailUrl?.isNotEmpty == true
                        ? CachedNetworkImage(
                            imageUrl: content.thumbnailUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                              child: Icon(
                                _getContentIcon(),
                                size: 48,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                        : Icon(
                            _getContentIcon(),
                            size: 48,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                  ),

                  // Content Type Badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getContentIcon(),
                            size: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getContentTypeText(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Lock Overlay
                  if (isLocked)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black54,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock,
                                size: 32,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '구독 전용',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Content Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Content Title
                    Text(
                      content.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Content Description
                    if (content.description?.isNotEmpty == true) ...[
                      Text(
                        content.description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                    ],

                    const Spacer(),

                    // Stats Row
                    Row(
                      children: [
                        // Views
                        Icon(
                          Icons.visibility_outlined,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatNumber(content.viewCount),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Likes
                        Icon(
                          Icons.favorite_outline,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatNumber(content.likeCount),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        
                        const Spacer(),
                        
                        // Date
                        Text(
                          _formatDate(content.publishedAt),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get icon based on content type
  IconData _getContentIcon() {
    switch (content.type) {
      case ContentType.video:
        return Icons.play_circle_outline;
      case ContentType.image:
        return Icons.image_outlined;
      case ContentType.audio:
        return Icons.audio_file_outlined;
      case ContentType.text:
      case ContentType.article:
        return Icons.article_outlined;
    }
  }

  /// Get content type text
  String _getContentTypeText() {
    switch (content.type) {
      case ContentType.video:
        return '영상';
      case ContentType.image:
        return '이미지';
      case ContentType.audio:
        return '오디오';
      case ContentType.text:
      case ContentType.article:
        return '글';
    }
  }

  /// Format number for display
  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  /// Format date for display
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 7) {
      return DateFormat('MM/dd').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}

/// Compact Content Card for lists
class CompactContentCard extends StatelessWidget {
  const CompactContentCard({
    super.key,
    required this.content,
    this.onTap,
    this.isLocked = false,
  });

  final Content content;
  final VoidCallback? onTap;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: content.thumbnailUrl?.isNotEmpty == true
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: content.thumbnailUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          _getContentIcon(),
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : Icon(
                      _getContentIcon(),
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
            ),
            if (isLocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          content.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (content.description?.isNotEmpty == true)
              Text(
                content.description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  _getContentIcon(),
                  size: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  _getContentTypeText(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.visibility_outlined,
                  size: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 2),
                Text(
                  _formatNumber(content.viewCount),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Text(
            _formatDate(content.publishedAt),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
      ),
    );
  }

  IconData _getContentIcon() {
    switch (content.type) {
      case ContentType.video:
        return Icons.play_circle_outline;
      case ContentType.image:
        return Icons.image_outlined;
      case ContentType.audio:
        return Icons.audio_file_outlined;
      case ContentType.text:
      case ContentType.article:
        return Icons.article_outlined;
    }
  }

  String _getContentTypeText() {
    switch (content.type) {
      case ContentType.video:
        return '영상';
      case ContentType.image:
        return '이미지';
      case ContentType.audio:
        return '오디오';
      case ContentType.text:
      case ContentType.article:
        return '글';
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 7) {
      return DateFormat('MM/dd').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creator_platform_demo/domain/entities/content.dart';
import 'package:creator_platform_demo/domain/entities/creator.dart';
import 'package:creator_platform_demo/presentation/providers/content_providers.dart';
import 'package:creator_platform_demo/presentation/providers/creator_providers.dart';
import 'package:creator_platform_demo/presentation/providers/subscription_providers.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';
import 'package:creator_platform_demo/presentation/widgets/video_player_widget.dart';
import 'package:creator_platform_demo/presentation/widgets/security/content_protection_widget.dart';
import 'package:creator_platform_demo/presentation/widgets/security/security_utils.dart';

class ContentViewerScreen extends ConsumerStatefulWidget {
  final String contentId;
  
  const ContentViewerScreen({super.key, required this.contentId});

  @override
  ConsumerState<ContentViewerScreen> createState() => _ContentViewerScreenState();
}

class _ContentViewerScreenState extends ConsumerState<ContentViewerScreen> {
  bool isLiked = false;
  int likeCount = 0;
  bool showComments = false;

  @override
  void initState() {
    super.initState();
    // 보안 기능 초기화
    SecurityUtils.initialize();
  }

  @override
  void dispose() {
    // 보안 기능 정리
    SecurityUtils.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentAsyncValue = ref.watch(contentProvider(widget.contentId));
    
    return Scaffold(
      body: contentAsyncValue.when(
        data: (content) => _buildContentViewer(content),
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const Text('오류')),
          body: _buildErrorState(error),
        ),
      ),
    );
  }

  Widget _buildContentViewer(Content content) {
    final creatorAsyncValue = ref.watch(creatorProvider(content.creatorId));
    final subscriptionStatusAsyncValue = ref.watch(subscriptionStatusProvider(content.creatorId));
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () => _showShareOptions(),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => _showMoreOptions(),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              // Media Player
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: _buildMediaPlayer(content, subscriptionStatusAsyncValue),
                ),
              ),
              
              // Content Info and Controls
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  children: [
                    // Creator Info and Actions
                    creatorAsyncValue.when(
                      data: (creator) => _buildCreatorInfo(creator, content, subscriptionStatusAsyncValue),
                      loading: () => const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    
                    // Content Details
                    _buildContentDetails(content),
                    
                    // Action Buttons
                    _buildActionButtons(),
                    
                    // Comments Section
                    if (showComments) _buildCommentsSection(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMediaPlayer(Content content, AsyncValue<bool> subscriptionStatus) {
    final isSubscribed = subscriptionStatus.value ?? false;
    final hasAccess = content.visibility == ContentVisibility.public || isSubscribed;
    
    if (!hasAccess) {
      return _buildLockedContentOverlay(content);
    }
    
    // 보호된 콘텐츠로 감싸기
    return _buildProtectedContent(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: content.type == ContentType.image
            ? _buildImagePlayer(content)
            : content.type == ContentType.video
                ? _buildVideoPlayer(content)
                : _buildUnsupportedContent(),
      ),
      content: content,
    );
  }

  /// 보호된 콘텐츠 위젯 생성
  Widget _buildProtectedContent({required Widget child, required Content content}) {
    final currentUser = ref.watch(currentUserProvider);
    final watermarkText = SecurityUtils.generateWatermarkText(
      currentUser?.id,
      currentUser?.name,
    );

    return ContentProtectionWidget(
      watermarkText: watermarkText,
      enableRightClickPrevention: true,
      enableTextSelectionPrevention: true,
      enableDragPrevention: true,
      enableDevToolsDetection: true,
      enableScreenshotPrevention: true,
      enableWatermark: true,
      watermarkOpacity: 0.12,
      watermarkFontSize: 12.0,
      watermarkColor: Colors.white,
      onSecurityViolation: () {
        SecurityUtils.logSecurityEvent('content_protection_violation', {
          'contentId': content.id,
          'contentTitle': content.title,
          'creatorId': content.creatorId,
          'userId': currentUser?.id,
          'username': currentUser?.name,
          'timestamp': DateTime.now().toIso8601String(),
          'userAgent': 'Flutter Web App',
        });
        
        // 추가 보안 조치 - 의심스러운 활동 시 알림
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              icon: const Icon(Icons.security, color: Colors.red, size: 48),
              title: const Text('보안 경고'),
              content: const Text(
                '비정상적인 활동이 감지되었습니다.\n콘텐츠 보호를 위해 모니터링됩니다.',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('확인'),
                ),
              ],
            ),
          );
        }
      },
      child: child,
    );
  }

  Widget _buildImagePlayer(Content content) {
    return InteractiveViewer(
      child: CachedNetworkImage(
        imageUrl: content.contentUrl,
        fit: BoxFit.contain,
        placeholder: (context, url) => Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image,
                size: 64,
                color: Colors.white.withOpacity(0.7),
              ),
              const SizedBox(height: 16),
              Text(
                '이미지를 불러올 수 없습니다',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(Content content) {
    return VideoPlayerWidget(
      videoUrl: content.contentUrl,
      thumbnailUrl: content.thumbnailUrl,
    );
  }

  Widget _buildUnsupportedContent() {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.file_present,
            size: 64,
            color: Colors.white.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            '지원하지 않는 콘텐츠 형식입니다',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedContentOverlay(Content content) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Blurred Thumbnail
          if (content.thumbnailUrl != null)
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: content.thumbnailUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          const SizedBox(height: 24),
          
          // Lock Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock,
              color: Colors.white,
              size: 30,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Message
          Text(
            '구독자 전용 콘텐츠',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            '이 콘텐츠를 보려면 구독이 필요합니다',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Subscribe Button
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(), // Go back to subscribe
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              '구독하기',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreatorInfo(Creator creator, Content content, AsyncValue<bool> subscriptionStatus) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Creator Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            backgroundImage: creator.profileImageUrl.isNotEmpty 
                ? NetworkImage(creator.profileImageUrl)
                : null,
            child: creator.profileImageUrl.isEmpty
                ? Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                : null,
          ),
          
          const SizedBox(width: 12),
          
          // Creator Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creator.displayName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      _formatDateTime(content.publishedAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (subscriptionStatus.value == true) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '구독중',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          
          // Subscribe Button
          subscriptionStatus.when(
            data: (isSubscribed) => !isSubscribed
                ? TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('구독'),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildContentDetails(Content content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            content.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          if (content.description != null && content.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              content.description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          
          const SizedBox(height: 12),
          
          // Stats
          Row(
            children: [
              _buildStatChip(Icons.visibility, '${_formatNumber(content.viewCount)} 조회'),
              const SizedBox(width: 8),
              _buildStatChip(Icons.thumb_up_outlined, '${_formatNumber(content.likeCount)}'),
              const SizedBox(width: 8),
              _buildStatChip(Icons.comment_outlined, '${_formatNumber(content.commentCount)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Like Button
          _buildActionButton(
            icon: isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
            label: '좋아요',
            isActive: isLiked,
            onTap: _toggleLike,
          ),
          
          // Comment Button
          _buildActionButton(
            icon: showComments ? Icons.comment : Icons.comment_outlined,
            label: '댓글',
            isActive: showComments,
            onTap: _toggleComments,
          ),
          
          // Share Button
          _buildActionButton(
            icon: Icons.share_outlined,
            label: '공유',
            onTap: _showShareOptions,
          ),
          
          // Download Button (for subscribers)
          _buildActionButton(
            icon: Icons.download_outlined,
            label: '저장',
            onTap: _downloadContent,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    final color = isActive 
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Comments Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '댓글',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => showComments = false),
                ),
              ],
            ),
          ),
          
          // Comments List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCommentItem(
                  'user123',
                  '정말 멋진 콘텐츠네요! 👍',
                  '2시간 전',
                ),
                _buildCommentItem(
                  'creator_fan',
                  '다음 작품도 기대하고 있어요~',
                  '1일 전',
                ),
                _buildCommentItem(
                  'art_lover',
                  '이런 스타일 정말 좋아해요',
                  '3일 전',
                ),
              ],
            ),
          ),
          
          // Comment Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(String username, String comment, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              username[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              '콘텐츠를 불러올 수 없습니다',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('돌아가기'),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      // In real app, would update through provider
    });
  }

  void _toggleComments() {
    setState(() {
      showComments = !showComments;
    });
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '공유하기',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(Icons.link, '링크 복사'),
                _buildShareOption(Icons.message, '메시지'),
                _buildShareOption(Icons.email, '이메일'),
                _buildShareOption(Icons.more_horiz, '더보기'),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.report_outlined),
              title: const Text('신고하기'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: const Icon(Icons.block_outlined),
              title: const Text('차단하기'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('정보'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadContent() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('다운로드 기능은 구독자에게만 제공됩니다'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
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
}
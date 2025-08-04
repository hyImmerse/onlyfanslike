import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:creator_platform_demo/domain/entities/creator.dart';
import 'package:creator_platform_demo/domain/entities/content.dart';
import 'package:creator_platform_demo/presentation/providers/creator_providers.dart';
import 'package:creator_platform_demo/presentation/providers/content_providers.dart';
import 'package:creator_platform_demo/presentation/providers/subscription_providers.dart';
import 'package:creator_platform_demo/presentation/widgets/content_card.dart';

class CreatorProfileScreen extends ConsumerStatefulWidget {
  final String creatorId;
  
  const CreatorProfileScreen({super.key, required this.creatorId});

  @override
  ConsumerState<CreatorProfileScreen> createState() => _CreatorProfileScreenState();
}

class _CreatorProfileScreenState extends ConsumerState<CreatorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final creatorAsyncValue = ref.watch(creatorProvider(widget.creatorId));
    final contentsAsyncValue = ref.watch(creatorContentsProvider(widget.creatorId));
    final subscriptionStatusAsyncValue = ref.watch(subscriptionStatusProvider(widget.creatorId));
    final subscriberCountAsyncValue = ref.watch(creatorSubscriberCountProvider(widget.creatorId));

    return Scaffold(
      body: creatorAsyncValue.when(
        data: (creator) => CustomScrollView(
          slivers: [
            // App Bar with Creator Header
            SliverAppBar(
              expandedHeight: 320.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildCreatorHeader(
                  creator, 
                  subscriptionStatusAsyncValue, 
                  subscriberCountAsyncValue
                ),
              ),
            ),
            
            // Content Grid
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: contentsAsyncValue.when(
                data: (contents) => _buildContentGrid(contents, subscriptionStatusAsyncValue),
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => SliverFillRemaining(
                  child: Center(
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const Text('오류')),
          body: Center(
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
                  '크리에이터 정보를 불러올 수 없습니다',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreatorHeader(
    Creator creator, 
    AsyncValue<bool> subscriptionStatus,
    AsyncValue<int> subscriberCount,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.surface,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Profile Image
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: creator.profileImageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: creator.profileImageUrl,
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
                              Icons.person,
                              size: 48,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        )
                      : Container(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.person,
                            size: 48,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Creator Name
              Text(
                creator.displayName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Category
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  creator.category,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Bio/Description  
              if (creator.bio.isNotEmpty)
                Text(
                  creator.bio,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 16),

              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(
                    context,
                    '구독자',
                    subscriberCount.when(
                      data: (count) => _formatNumber(count),
                      loading: () => '-',
                      error: (_, __) => '-',
                    ),
                    Icons.people_outline,
                  ),
                  _buildStatItem(
                    context,
                    '콘텐츠',
                    _formatNumber(creator.contentCount),
                    Icons.video_library_outlined,
                  ),
                  _buildStatItem(
                    context,
                    '평점',
                    '4.5', // Placeholder
                    Icons.star_outline,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Subscribe Button
              _buildSubscribeButton(subscriptionStatus),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSubscribeButton(AsyncValue<bool> subscriptionStatus) {
    final subscriptionAction = ref.watch(subscriptionActionProvider);
    
    return subscriptionStatus.when(
      data: (isSubscribed) => SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton.icon(
          onPressed: subscriptionAction.isLoading ? null : () => _handleSubscribeAction(isSubscribed),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSubscribed 
                ? Theme.of(context).colorScheme.surfaceContainerHighest
                : Theme.of(context).colorScheme.primary,
            foregroundColor: isSubscribed
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: isSubscribed ? BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ) : BorderSide.none,
            ),
          ),
          icon: subscriptionAction.isLoading 
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: isSubscribed
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : Icon(isSubscribed ? Icons.check : Icons.add),
          label: Text(
            subscriptionAction.isLoading
                ? (isSubscribed ? '구독 해지 중...' : '구독 중...')
                : (isSubscribed ? '구독 중' : '구독하기'),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      loading: () => SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: null,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (_, __) => SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: null,
          child: const Text('오류 발생'),
        ),
      ),
    );
  }

  Widget _buildContentGrid(List<Content> contents, AsyncValue<bool> subscriptionStatus) {
    if (contents.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.video_library_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                '아직 업로드된 콘텐츠가 없습니다',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final isSubscribed = subscriptionStatus.value ?? false;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final content = contents[index];
          final isLocked = content.visibility != ContentVisibility.public && !isSubscribed;
          
          return ContentCard(
            content: content,
            isLocked: isLocked,
            onTap: isLocked ? null : () {
              // Navigate to content detail screen
              _showContentDetail(content);
            },
          );
        },
        childCount: contents.length,
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }

  void _handleSubscribeAction(bool isCurrentlySubscribed) async {
    if (isCurrentlySubscribed) {
      // Show unsubscribe confirmation
      final shouldUnsubscribe = await _showUnsubscribeDialog();
      if (shouldUnsubscribe == true) {
        await ref.read(subscriptionActionProvider.notifier).unsubscribe('mock-subscription-id');
        // Refresh subscription status
        ref.invalidate(subscriptionStatusProvider(widget.creatorId));
        ref.invalidate(creatorSubscriberCountProvider(widget.creatorId));
        
        final actionState = ref.read(subscriptionActionProvider);
        if (actionState.hasError && actionState.errorMessage != null) {
          _showSnackBar(actionState.errorMessage!, isError: true);
        } else if (actionState.successMessage != null) {
          _showSnackBar(actionState.successMessage!);
        }
      }
    } else {
      // Navigate to subscription screen
      context.push('/home/subscription/${widget.creatorId}');
    }
  }

  Future<bool?> _showUnsubscribeDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('구독 해지'),
        content: const Text('정말로 구독을 해지하시겠습니까?\n전용 콘텐츠에 더 이상 접근할 수 없게 됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('해지하기'),
          ),
        ],
      ),
    );
  }

  void _showContentDetail(Content content) {
    // Navigate to content viewer screen
    context.push('/home/content/${content.id}');
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError 
            ? Theme.of(context).colorScheme.error 
            : Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
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
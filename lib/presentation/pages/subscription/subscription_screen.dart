import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/creator.dart';
import 'package:creator_platform_demo/presentation/providers/creator_providers.dart';
import 'package:creator_platform_demo/presentation/providers/subscription_providers.dart';
import 'package:creator_platform_demo/presentation/widgets/subscription_plan_card.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  final String creatorId;
  
  const SubscriptionScreen({super.key, required this.creatorId});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  String? selectedTierId;
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final creatorAsyncValue = ref.watch(creatorProvider(widget.creatorId));
    final subscriptionStatusAsyncValue = ref.watch(subscriptionStatusProvider(widget.creatorId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('구독하기'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: creatorAsyncValue.when(
        data: (creator) => _buildSubscriptionContent(creator, subscriptionStatusAsyncValue),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(error),
      ),
    );
  }

  Widget _buildSubscriptionContent(Creator creator, AsyncValue<bool> subscriptionStatus) {
    return CustomScrollView(
      slivers: [
        // Header Section
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  Theme.of(context).colorScheme.surface,
                ],
              ),
            ),
            child: Column(
              children: [
                // Creator Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      backgroundImage: creator.profileImageUrl.isNotEmpty 
                          ? NetworkImage(creator.profileImageUrl)
                          : null,
                      child: creator.profileImageUrl.isEmpty
                          ? Icon(
                              Icons.person,
                              size: 32,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            creator.displayName,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              creator.category,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Header Text
                Text(
                  '${creator.displayName}님의\n구독 플랜을 선택하세요',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '전용 콘텐츠와 특별한 혜택을 누리세요',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        // Current Subscription Status
        if (subscriptionStatus.value == true)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '현재 구독 중',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          '이미 이 크리에이터를 구독하고 있습니다',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Subscription Plans
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: _buildSubscriptionPlans(creator.tiers),
        ),

        // Benefits Summary
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '구독 시 공통 혜택',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildBenefitItem('📱', '모바일 앱 전용 콘텐츠 접근'),
                _buildBenefitItem('💬', '크리에이터와 직접 소통'),
                _buildBenefitItem('🎯', '광고 없는 콘텐츠 시청'),
                _buildBenefitItem('⏰', '신규 콘텐츠 우선 공개'),
                _buildBenefitItem('🎁', '월별 특별 이벤트 참여'),
              ],
            ),
          ),
        ),

        // Payment Info
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '결제 안내',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildPaymentInfoItem('• 매월 자동 결제됩니다'),
                _buildPaymentInfoItem('• 언제든지 구독을 취소할 수 있습니다'),
                _buildPaymentInfoItem('• 첫 7일은 무료 체험이 제공됩니다'),
                _buildPaymentInfoItem('• 이 데모에서는 실제 결제가 진행되지 않습니다'),
              ],
            ),
          ),
        ),

        // Bottom Spacing
        const SliverToBoxAdapter(
          child: SizedBox(height: 32),
        ),
      ],
    );
  }

  Widget _buildSubscriptionPlans(List<SubscriptionTier> tiers) {
    if (tiers.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Icon(
                  Icons.subscriptions_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  '구독 플랜이 없습니다',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Sort tiers by price for display
    final sortedTiers = List<SubscriptionTier>.from(tiers)
      ..sort((a, b) => a.price.compareTo(b.price));

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final tier = sortedTiers[index];
          final isPopular = index == (sortedTiers.length ~/ 2); // Middle tier as popular
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SubscriptionPlanCard(
              tier: tier,
              isSelected: selectedTierId == tier.id,
              isLoading: isProcessing && selectedTierId == tier.id,
              showPopularBadge: isPopular,
              onTap: () => _handlePlanSelection(tier),
            ),
          );
        },
        childCount: sortedTiers.length,
      ),
    );
  }

  Widget _buildBenefitItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
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
              '정보를 불러올 수 없습니다',
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

  void _handlePlanSelection(SubscriptionTier tier) async {
    if (isProcessing) return;

    setState(() {
      selectedTierId = tier.id;
      isProcessing = true;
    });

    // Show payment simulation dialog
    final shouldProceed = await _showPaymentDialog(tier);
    
    if (shouldProceed == true) {
      await _processSubscription(tier);
    }

    if (mounted) {
      setState(() {
        isProcessing = false;
      });
    }
  }

  Future<bool?> _showPaymentDialog(SubscriptionTier tier) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.payment,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('결제 확인'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('선택한 플랜: ${tier.name}'),
            const SizedBox(height: 8),
            Text(
              '월 결제 금액: ₩${_formatPrice(tier.price)}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      '이것은 데모입니다. 실제 결제가 진행되지 않습니다.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('구독하기'),
          ),
        ],
      ),
    );
  }

  Future<void> _processSubscription(SubscriptionTier tier) async {
    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));
      
      // Process subscription through provider
      await ref.read(subscriptionActionProvider.notifier).subscribe(
        widget.creatorId, 
        tier.id,
      );

      // Refresh subscription status
      ref.invalidate(subscriptionStatusProvider(widget.creatorId));

      // Show success message
      if (mounted) {
        _showSuccessDialog(tier);
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        _showErrorSnackBar('구독 처리 중 오류가 발생했습니다: ${e.toString()}');
      }
    }
  }

  void _showSuccessDialog(SubscriptionTier tier) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('구독 완료!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${tier.name} 플랜 구독이 완료되었습니다.'),
            const SizedBox(height: 8),
            const Text('이제 전용 콘텐츠를 즐기세요!'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}K';
    } else {
      return price.toString();
    }
  }
}
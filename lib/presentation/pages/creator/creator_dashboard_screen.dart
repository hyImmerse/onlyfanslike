import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';
import 'package:creator_platform_demo/presentation/providers/subscription_providers.dart';
import 'package:creator_platform_demo/presentation/providers/content_providers.dart';
import 'package:creator_platform_demo/presentation/providers/revenue_analytics_provider.dart';
import 'package:creator_platform_demo/domain/entities/content.dart';
import 'package:creator_platform_demo/domain/entities/revenue_analytics.dart';
import 'package:creator_platform_demo/presentation/widgets/dashboard/revenue_summary_widget.dart';
import 'package:creator_platform_demo/presentation/widgets/dashboard/revenue_chart_widget.dart';
import 'package:creator_platform_demo/presentation/widgets/dashboard/subscriber_analytics_widget.dart';

class CreatorDashboardScreen extends ConsumerWidget {
  const CreatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final creatorId = currentUser?.id ?? '';
    final analyticsAsync = ref.watch(dashboardAnalyticsProvider(creatorId));
    final AsyncValue<List<Content>> creatorContents = ref.watch(creatorContentsProvider(creatorId));
    
    if (currentUser == null) {
      // 로그인하지 않은 경우 로그인 화면으로 리다이렉트
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('크리에이터 대시보드'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              context.push('/notifications');
            },
            tooltip: '알림',
          ),
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              // 콘텐츠 업로드 화면으로 이동
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('콘텐츠 업로드 기능은 준비 중입니다'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            tooltip: '콘텐츠 업로드',
          ),
        ],
      ),
      body: analyticsAsync.when(
        data: (analytics) => _buildEnhancedDashboard(
          context, 
          ref, 
          creatorId,
          analytics,
          creatorContents,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('오류가 발생했습니다: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(dashboardAnalyticsProvider);
                  ref.invalidate(creatorContentsProvider);
                },
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedDashboard(
    BuildContext context,
    WidgetRef ref,
    String creatorId,
    DashboardAnalytics analytics,
    AsyncValue<List<Content>> contentsAsync,
  ) {
    final theme = Theme.of(context);
    
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(dashboardAnalyticsProvider);
        ref.invalidate(creatorContentsProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 향상된 수익 요약 위젯
            RevenueSummaryWidget(creatorId: creatorId),
            const SizedBox(height: 24),
            
            // 수익 차트
            RevenueChartWidget(creatorId: creatorId),
            const SizedBox(height: 24),
            
            // 구독자 분석
            SubscriberAnalyticsWidget(creatorId: creatorId),
            const SizedBox(height: 24),
            
            // 콘텐츠 관리 섹션 (기존 유지)
            _buildContentSection(context, ref, contentsAsync),
            const SizedBox(height: 24),
            
            // 빠른 액션 섹션 (기존 유지)
            _buildQuickActionsSection(context),
          ],
        ),
      ),
    );
  }


  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<Content>> contentsAsync,
  ) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.video_library,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '콘텐츠 관리',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    // 콘텐츠 관리 화면으로 이동
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('콘텐츠 관리 화면은 준비 중입니다'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('전체 보기'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            contentsAsync.when(
              data: (contents) {
                if (contents.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.video_call,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '아직 업로드한 콘텐츠가 없습니다',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FilledButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('콘텐츠 업로드 기능은 준비 중입니다'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('첫 콘텐츠 업로드'),
                        ),
                      ],
                    ),
                  );
                }
                
                return Column(
                  children: [
                    _buildStatRow(
                      context,
                      '전체 콘텐츠',
                      '${contents.length}개',
                      Icons.video_library,
                      theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    _buildStatRow(
                      context,
                      '공개 콘텐츠',
                      '${contents.where((c) => c.isPublic).length}개',
                      Icons.public,
                      theme.colorScheme.secondary,
                    ),
                    const SizedBox(height: 12),
                    _buildStatRow(
                      context,
                      '구독자 전용',
                      '${contents.where((c) => !c.isPublic).length}개',
                      Icons.lock,
                      theme.colorScheme.tertiary,
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('콘텐츠를 불러올 수 없습니다'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '빠른 액션',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.5,
          children: [
            _buildActionCard(
              context,
              '콘텐츠 업로드',
              Icons.cloud_upload,
              theme.colorScheme.primary,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('콘텐츠 업로드 기능은 준비 중입니다'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            _buildActionCard(
              context,
              '공지사항 작성',
              Icons.announcement,
              theme.colorScheme.secondary,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('공지사항 기능은 준비 중입니다'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            _buildActionCard(
              context,
              '구독자 메시지',
              Icons.message,
              theme.colorScheme.tertiary,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('메시지 기능은 준비 중입니다'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            _buildActionCard(
              context,
              '수익 정산',
              Icons.account_balance_wallet,
              theme.colorScheme.error,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('정산 기능은 준비 중입니다'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
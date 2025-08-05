import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/revenue_analytics.dart';
import 'package:creator_platform_demo/presentation/providers/revenue_analytics_provider.dart';
import 'package:creator_platform_demo/presentation/widgets/dashboard/statistics_card_widget.dart';

/// 수익 요약 위젯 - 주요 수익 지표를 카드 형태로 표시
class RevenueSummaryWidget extends ConsumerWidget {
  final String creatorId;
  
  const RevenueSummaryWidget({
    super.key,
    required this.creatorId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final analyticsAsync = ref.watch(dashboardAnalyticsProvider(creatorId));
    
    return analyticsAsync.when(
      data: (analytics) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main revenue cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              StatisticsCard(
                title: '총 수익',
                value: analytics.totalRevenue.toKRW(),
                icon: Icons.account_balance_wallet,
                iconColor: theme.colorScheme.primary,
                subtitle: '전체 기간',
              ),
              StatisticsCard(
                title: '이번 달 수익',
                value: analytics.monthlyRevenue.toKRW(),
                icon: Icons.calendar_today,
                iconColor: theme.colorScheme.secondary,
                growthRate: analytics.revenueGrowthRate,
                growthPeriod: '전월 대비',
              ),
              StatisticsCard(
                title: '정산 대기',
                value: analytics.pendingRevenue.toKRW(),
                icon: Icons.schedule,
                iconColor: theme.colorScheme.tertiary,
                subtitle: '다음 정산일: ${_getNextSettlementDate()}',
              ),
              StatisticsCard(
                title: 'ARPU',
                value: analytics.avgRevenuePerUser.toKRW(),
                icon: Icons.person,
                iconColor: Colors.purple,
                subtitle: '구독자당 평균 수익',
                growthRate: 0.12, // Mock 12% growth
                growthPeriod: '전월 대비',
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Additional metrics
          Card(
            elevation: 0,
            color: theme.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.insights,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '핵심 지표',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: MiniStatCard(
                          label: '활성 구독자',
                          value: '${analytics.activeSubscribers}명',
                          icon: Icons.check_circle,
                          color: Colors.green,
                          isHighlighted: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MiniStatCard(
                          label: 'LTV',
                          value: analytics.lifetimeValue.toCompactKRW(),
                          icon: Icons.trending_up,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MiniStatCard(
                          label: '예상 수익',
                          value: (analytics.monthlyRevenue * 1.08).toCompactKRW(),
                          icon: Icons.auto_graph,
                          color: Colors.orange,
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
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('수익 데이터를 불러올 수 없습니다'),
            ],
          ),
        ),
      ),
    );
  }
  
  String _getNextSettlementDate() {
    final now = DateTime.now();
    final nextMonth = DateTime(now.year, now.month + 1, 10); // 매월 10일 정산
    return '${nextMonth.month}월 ${nextMonth.day}일';
  }
}
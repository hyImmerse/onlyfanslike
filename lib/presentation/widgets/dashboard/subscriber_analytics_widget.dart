import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/revenue_analytics.dart';
import 'package:creator_platform_demo/presentation/providers/revenue_analytics_provider.dart';

/// 구독자 분석 위젯 - 구독자 분포 및 트렌드
class SubscriberAnalyticsWidget extends ConsumerWidget {
  final String creatorId;
  
  const SubscriberAnalyticsWidget({
    super.key,
    required this.creatorId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final analyticsAsync = ref.watch(dashboardAnalyticsProvider(creatorId));
    
    return analyticsAsync.when(
      data: (analytics) => Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.people_alt,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '구독자 분석',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Subscriber metrics
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      context,
                      '전체 구독자',
                      analytics.subscriberAnalytics.totalSubscribers.toString(),
                      Icons.group,
                      theme.colorScheme.primary,
                      growthRate: analytics.subscriberGrowthRate,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      context,
                      '신규 구독',
                      '+${analytics.subscriberAnalytics.newSubscribers}',
                      Icons.person_add,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      context,
                      '해지',
                      '-${analytics.subscriberAnalytics.canceledSubscriptions}',
                      Icons.person_remove,
                      Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Pie chart for plan distribution
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pie chart
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            // Handle touch
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: _createPieSections(
                          analytics.subscriberAnalytics.subscribersByPlan,
                          theme,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  
                  // Legend and stats
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '플랜별 분포',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...analytics.subscriberAnalytics.subscribersByPlan.entries.map((entry) {
                          final percentage = (entry.value / analytics.subscriberAnalytics.totalSubscribers * 100).toStringAsFixed(1);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: _getPlanColor(entry.key, theme),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  entry.key,
                                  style: theme.textTheme.bodySmall,
                                ),
                                const Spacer(),
                                Text(
                                  '${entry.value}명',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '($percentage%)',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              
              // Retention metrics
              Row(
                children: [
                  Expanded(
                    child: _buildRetentionMetric(
                      context,
                      '이탈률',
                      '${(analytics.subscriberAnalytics.churnRate * 100).toStringAsFixed(1)}%',
                      analytics.subscriberAnalytics.churnRate < 0.1,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildRetentionMetric(
                      context,
                      '유지율',
                      '${(analytics.subscriberAnalytics.retentionRate * 100).toStringAsFixed(1)}%',
                      analytics.subscriberAnalytics.retentionRate > 0.9,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      loading: () => const Card(
        elevation: 0,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stack) => Card(
        elevation: 0,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Text('구독자 분석을 불러올 수 없습니다'),
          ),
        ),
      ),
    );
  }
  
  Widget _buildMetricCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color, {
    double? growthRate,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          if (growthRate != null) ...[
            const SizedBox(height: 4),
            Text(
              growthRate.toPercentage(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: growthRate >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildRetentionMetric(
    BuildContext context,
    String label,
    String value,
    bool isGood,
  ) {
    final theme = Theme.of(context);
    final color = isGood ? Colors.green : Colors.orange;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium,
          ),
          Row(
            children: [
              Icon(
                isGood ? Icons.check_circle : Icons.warning,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  List<PieChartSectionData> _createPieSections(
    Map<String, int> subscribersByPlan,
    ThemeData theme,
  ) {
    final total = subscribersByPlan.values.fold<int>(0, (sum, count) => sum + count);
    
    return subscribersByPlan.entries.map((entry) {
      final percentage = entry.value / total * 100;
      final color = _getPlanColor(entry.key, theme);
      
      return PieChartSectionData(
        color: color,
        value: entry.value.toDouble(),
        title: percentage > 10 ? '${percentage.toStringAsFixed(0)}%' : '',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
  
  Color _getPlanColor(String plan, ThemeData theme) {
    switch (plan) {
      case 'Basic':
        return theme.colorScheme.primary;
      case 'Premium':
        return theme.colorScheme.secondary;
      case 'VIP':
        return theme.colorScheme.tertiary;
      default:
        return theme.colorScheme.surfaceVariant;
    }
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/revenue_analytics.dart';
import 'dart:math' as math;

/// Enhanced Revenue Analytics Provider
/// Provides comprehensive revenue data with charts and trends
final dashboardAnalyticsProvider = FutureProvider.family<DashboardAnalytics, String>((ref, creatorId) async {
  // Simulate API delay
  await Future.delayed(const Duration(milliseconds: 800));
  
  // Generate mock data for demonstration
  final now = DateTime.now();
  final random = math.Random(creatorId.hashCode);
  
  // Base metrics
  final baseSubscribers = 150 + random.nextInt(350);
  final baseMonthlyRevenue = baseSubscribers * (10000 + random.nextInt(20000));
  
  // Generate daily revenue data (last 30 days)
  final dailyRevenue = List.generate(30, (index) {
    final date = now.subtract(Duration(days: 29 - index));
    final dayVariation = 0.7 + random.nextDouble() * 0.6; // 70% to 130% variation
    final revenue = (baseMonthlyRevenue / 30) * dayVariation;
    
    return DailyRevenue(
      date: date,
      revenue: revenue,
      transactions: (revenue / 15000).round(),
    );
  });
  
  // Generate monthly revenue data (last 12 months)
  final monthlyRevenue = List.generate(12, (index) {
    final date = DateTime(now.year, now.month - (11 - index), 1);
    final growthFactor = 1 + (index * 0.08); // 8% average monthly growth
    final monthVariation = 0.9 + random.nextDouble() * 0.2; // 90% to 110% variation
    final revenue = baseMonthlyRevenue * growthFactor * monthVariation;
    final previousRevenue = index > 0 
        ? baseMonthlyRevenue * (1 + ((index - 1) * 0.08)) * monthVariation 
        : baseMonthlyRevenue * 0.9;
    
    return MonthlyRevenue(
      year: date.year,
      month: date.month,
      revenue: revenue,
      subscriberCount: (baseSubscribers * growthFactor).round(),
      growthRate: (revenue - previousRevenue) / previousRevenue,
    );
  });
  
  // Calculate trend data
  final trendData = dailyRevenue.map((d) => TrendPoint(
    date: d.date,
    value: d.revenue,
    label: '${d.date.month}/${d.date.day}',
  )).toList();
  
  final totalDailyRevenue = dailyRevenue.fold<double>(0, (sum, d) => sum + d.revenue);
  final avgDailyRevenue = totalDailyRevenue / dailyRevenue.length;
  
  // Calculate growth rates
  final lastMonthRevenue = monthlyRevenue[monthlyRevenue.length - 2].revenue;
  final currentMonthRevenue = monthlyRevenue.last.revenue;
  final revenueGrowthRate = (currentMonthRevenue - lastMonthRevenue) / lastMonthRevenue;
  
  final lastMonthSubscribers = monthlyRevenue[monthlyRevenue.length - 2].subscriberCount;
  final currentSubscribers = monthlyRevenue.last.subscriberCount;
  final subscriberGrowthRate = (currentSubscribers - lastMonthSubscribers) / lastMonthSubscribers.toDouble();
  
  // Subscriber analytics
  final subscriberAnalytics = SubscriberAnalytics(
    totalSubscribers: currentSubscribers,
    newSubscribers: (currentSubscribers * 0.15).round(), // 15% new this month
    canceledSubscriptions: (currentSubscribers * 0.05).round(), // 5% churn
    churnRate: 0.05,
    retentionRate: 0.95,
    subscribersByPlan: {
      'Basic': (currentSubscribers * 0.5).round(),
      'Premium': (currentSubscribers * 0.35).round(),
      'VIP': (currentSubscribers * 0.15).round(),
    },
    revenueByPlan: {
      'Basic': currentMonthRevenue * 0.3,
      'Premium': currentMonthRevenue * 0.45,
      'VIP': currentMonthRevenue * 0.25,
    },
  );
  
  // Revenue trend
  final revenueTrend = RevenueTrend(
    period: 'daily',
    data: trendData,
    totalRevenue: totalDailyRevenue,
    averageRevenue: avgDailyRevenue,
    growthRate: revenueGrowthRate,
    projectedRevenue: currentMonthRevenue * 1.08, // 8% projected growth
  );
  
  // Calculate totals
  final totalRevenue = monthlyRevenue.fold<double>(0, (sum, m) => sum + m.revenue);
  final pendingRevenue = currentMonthRevenue * 0.3; // 30% pending settlement
  
  return DashboardAnalytics(
    // Current state
    totalRevenue: totalRevenue,
    monthlyRevenue: currentMonthRevenue,
    pendingRevenue: pendingRevenue,
    totalSubscribers: currentSubscribers,
    activeSubscribers: (currentSubscribers * 0.92).round(), // 92% active
    
    // Growth metrics
    revenueGrowthRate: revenueGrowthRate,
    subscriberGrowthRate: subscriberGrowthRate,
    avgRevenuePerUser: currentMonthRevenue / currentSubscribers,
    lifetimeValue: (currentMonthRevenue / currentSubscribers) * 12, // 12 month LTV
    
    // Chart data
    dailyRevenue: dailyRevenue,
    monthlyRevenueHistory: monthlyRevenue,
    revenueTrend: revenueTrend,
    subscriberAnalytics: subscriberAnalytics,
    
    // Content stats
    totalContents: 42 + random.nextInt(58),
    publishedThisMonth: 3 + random.nextInt(7),
    avgViewsPerContent: 150.0 + random.nextDouble() * 350,
    
    updatedAt: now,
  );
});

/// Period selector for revenue charts
enum ChartPeriod {
  daily('일간'),
  weekly('주간'),
  monthly('월간'),
  yearly('연간');
  
  const ChartPeriod(this.label);
  final String label;
}

/// Selected chart period provider
final selectedChartPeriodProvider = StateProvider<ChartPeriod>((ref) {
  return ChartPeriod.daily;
});

/// Filtered revenue data based on selected period
final filteredRevenueDataProvider = Provider.family<List<TrendPoint>, String>((ref, creatorId) {
  final analytics = ref.watch(dashboardAnalyticsProvider(creatorId));
  final period = ref.watch(selectedChartPeriodProvider);
  
  return analytics.maybeWhen(
    data: (data) {
      switch (period) {
        case ChartPeriod.daily:
          return data.dailyRevenue.map((d) => TrendPoint(
            date: d.date,
            value: d.revenue,
            label: '${d.date.day}일',
          )).toList();
          
        case ChartPeriod.weekly:
          // Group daily data by week
          final weeklyData = <TrendPoint>[];
          for (int i = 0; i < data.dailyRevenue.length; i += 7) {
            final weekRevenue = data.dailyRevenue
                .skip(i)
                .take(7)
                .fold<double>(0, (sum, d) => sum + d.revenue);
            weeklyData.add(TrendPoint(
              date: data.dailyRevenue[i].date,
              value: weekRevenue,
              label: '${(i ~/ 7) + 1}주차',
            ));
          }
          return weeklyData;
          
        case ChartPeriod.monthly:
          return data.monthlyRevenueHistory.map((m) => TrendPoint(
            date: DateTime(m.year, m.month),
            value: m.revenue,
            label: '${m.month}월',
          )).toList();
          
        case ChartPeriod.yearly:
          // Group monthly data by year
          final yearlyData = <int, double>{};
          for (final month in data.monthlyRevenueHistory) {
            yearlyData[month.year] = (yearlyData[month.year] ?? 0) + month.revenue;
          }
          return yearlyData.entries.map((e) => TrendPoint(
            date: DateTime(e.key),
            value: e.value,
            label: '${e.key}년',
          )).toList();
      }
    },
    orElse: () => [],
  );
});
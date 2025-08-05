import 'package:freezed_annotation/freezed_annotation.dart';

part 'revenue_analytics.freezed.dart';
part 'revenue_analytics.g.dart';

/// 수익 분석을 위한 데이터 모델
@freezed
class RevenueAnalytics with _$RevenueAnalytics {
  const factory RevenueAnalytics({
    required String creatorId,
    required DateTime date,
    required double revenue,
    required int subscriberCount,
    required int newSubscribers,
    required int canceledSubscriptions,
    @Default(0) int viewCount,
    @Default(0) int contentCount,
  }) = _RevenueAnalytics;

  factory RevenueAnalytics.fromJson(Map<String, dynamic> json) =>
      _$RevenueAnalyticsFromJson(json);
}

/// 일별 수익 데이터
@freezed
class DailyRevenue with _$DailyRevenue {
  const factory DailyRevenue({
    required DateTime date,
    required double revenue,
    required int transactions,
  }) = _DailyRevenue;

  factory DailyRevenue.fromJson(Map<String, dynamic> json) =>
      _$DailyRevenueFromJson(json);
}

/// 월별 수익 데이터
@freezed
class MonthlyRevenue with _$MonthlyRevenue {
  const factory MonthlyRevenue({
    required int year,
    required int month,
    required double revenue,
    required int subscriberCount,
    required double growthRate, // 전월 대비 성장률
  }) = _MonthlyRevenue;

  factory MonthlyRevenue.fromJson(Map<String, dynamic> json) =>
      _$MonthlyRevenueFromJson(json);
}

/// 수익 트렌드 데이터
@freezed
class RevenueTrend with _$RevenueTrend {
  const factory RevenueTrend({
    required String period, // "daily", "weekly", "monthly", "yearly"
    required List<TrendPoint> data,
    required double totalRevenue,
    required double averageRevenue,
    required double growthRate,
    required double projectedRevenue, // 예상 수익
  }) = _RevenueTrend;

  factory RevenueTrend.fromJson(Map<String, dynamic> json) =>
      _$RevenueTrendFromJson(json);
}

/// 트렌드 차트용 데이터 포인트
@freezed
class TrendPoint with _$TrendPoint {
  const factory TrendPoint({
    required DateTime date,
    required double value,
    String? label,
  }) = _TrendPoint;

  factory TrendPoint.fromJson(Map<String, dynamic> json) =>
      _$TrendPointFromJson(json);
}

/// 구독자 분석 데이터
@freezed
class SubscriberAnalytics with _$SubscriberAnalytics {
  const factory SubscriberAnalytics({
    required int totalSubscribers,
    required int newSubscribers,
    required int canceledSubscriptions,
    required double churnRate,
    required double retentionRate,
    required Map<String, int> subscribersByPlan, // 플랜별 구독자 수
    required Map<String, double> revenueByPlan, // 플랜별 수익
  }) = _SubscriberAnalytics;

  factory SubscriberAnalytics.fromJson(Map<String, dynamic> json) =>
      _$SubscriberAnalyticsFromJson(json);
}

/// 종합 대시보드 데이터
@freezed
class DashboardAnalytics with _$DashboardAnalytics {
  const factory DashboardAnalytics({
    // 현재 상태
    required double totalRevenue,
    required double monthlyRevenue,
    required double pendingRevenue,
    required int totalSubscribers,
    required int activeSubscribers,
    
    // 성장 지표
    required double revenueGrowthRate, // 전월 대비
    required double subscriberGrowthRate, // 전월 대비
    required double avgRevenuePerUser, // ARPU
    required double lifetimeValue, // LTV
    
    // 차트 데이터
    required List<DailyRevenue> dailyRevenue, // 최근 30일
    required List<MonthlyRevenue> monthlyRevenueHistory, // 최근 12개월
    required RevenueTrend revenueTrend,
    required SubscriberAnalytics subscriberAnalytics,
    
    // 컨텐츠 통계
    required int totalContents,
    required int publishedThisMonth,
    required double avgViewsPerContent,
    
    DateTime? updatedAt,
  }) = _DashboardAnalytics;

  factory DashboardAnalytics.fromJson(Map<String, dynamic> json) =>
      _$DashboardAnalyticsFromJson(json);
}

// Extension methods for display formatting
extension RevenueFormatting on double {
  String toKRW() {
    if (this >= 1000000000) {
      return '₩${(this / 1000000000).toStringAsFixed(1)}B';
    } else if (this >= 1000000) {
      return '₩${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '₩${(this / 1000).toStringAsFixed(0)}K';
    }
    return '₩${toStringAsFixed(0)}';
  }
  
  String toCompactKRW() {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M원';
    } else if (this >= 10000) {
      return '${(this / 10000).toStringAsFixed(1)}만원';
    }
    return '${toStringAsFixed(0)}원';
  }
}

extension GrowthFormatting on double {
  String toPercentage() {
    final sign = this >= 0 ? '+' : '';
    return '$sign${(this * 100).toStringAsFixed(1)}%';
  }
  
  bool get isPositive => this >= 0;
}
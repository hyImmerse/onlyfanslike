// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revenue_analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RevenueAnalyticsImpl _$$RevenueAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$RevenueAnalyticsImpl(
      creatorId: json['creatorId'] as String,
      date: DateTime.parse(json['date'] as String),
      revenue: (json['revenue'] as num).toDouble(),
      subscriberCount: (json['subscriberCount'] as num).toInt(),
      newSubscribers: (json['newSubscribers'] as num).toInt(),
      canceledSubscriptions: (json['canceledSubscriptions'] as num).toInt(),
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      contentCount: (json['contentCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$RevenueAnalyticsImplToJson(
        _$RevenueAnalyticsImpl instance) =>
    <String, dynamic>{
      'creatorId': instance.creatorId,
      'date': instance.date.toIso8601String(),
      'revenue': instance.revenue,
      'subscriberCount': instance.subscriberCount,
      'newSubscribers': instance.newSubscribers,
      'canceledSubscriptions': instance.canceledSubscriptions,
      'viewCount': instance.viewCount,
      'contentCount': instance.contentCount,
    };

_$DailyRevenueImpl _$$DailyRevenueImplFromJson(Map<String, dynamic> json) =>
    _$DailyRevenueImpl(
      date: DateTime.parse(json['date'] as String),
      revenue: (json['revenue'] as num).toDouble(),
      transactions: (json['transactions'] as num).toInt(),
    );

Map<String, dynamic> _$$DailyRevenueImplToJson(_$DailyRevenueImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'revenue': instance.revenue,
      'transactions': instance.transactions,
    };

_$MonthlyRevenueImpl _$$MonthlyRevenueImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyRevenueImpl(
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      revenue: (json['revenue'] as num).toDouble(),
      subscriberCount: (json['subscriberCount'] as num).toInt(),
      growthRate: (json['growthRate'] as num).toDouble(),
    );

Map<String, dynamic> _$$MonthlyRevenueImplToJson(
        _$MonthlyRevenueImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'revenue': instance.revenue,
      'subscriberCount': instance.subscriberCount,
      'growthRate': instance.growthRate,
    };

_$RevenueTrendImpl _$$RevenueTrendImplFromJson(Map<String, dynamic> json) =>
    _$RevenueTrendImpl(
      period: json['period'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => TrendPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      averageRevenue: (json['averageRevenue'] as num).toDouble(),
      growthRate: (json['growthRate'] as num).toDouble(),
      projectedRevenue: (json['projectedRevenue'] as num).toDouble(),
    );

Map<String, dynamic> _$$RevenueTrendImplToJson(_$RevenueTrendImpl instance) =>
    <String, dynamic>{
      'period': instance.period,
      'data': instance.data,
      'totalRevenue': instance.totalRevenue,
      'averageRevenue': instance.averageRevenue,
      'growthRate': instance.growthRate,
      'projectedRevenue': instance.projectedRevenue,
    };

_$TrendPointImpl _$$TrendPointImplFromJson(Map<String, dynamic> json) =>
    _$TrendPointImpl(
      date: DateTime.parse(json['date'] as String),
      value: (json['value'] as num).toDouble(),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$$TrendPointImplToJson(_$TrendPointImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'value': instance.value,
      'label': instance.label,
    };

_$SubscriberAnalyticsImpl _$$SubscriberAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriberAnalyticsImpl(
      totalSubscribers: (json['totalSubscribers'] as num).toInt(),
      newSubscribers: (json['newSubscribers'] as num).toInt(),
      canceledSubscriptions: (json['canceledSubscriptions'] as num).toInt(),
      churnRate: (json['churnRate'] as num).toDouble(),
      retentionRate: (json['retentionRate'] as num).toDouble(),
      subscribersByPlan:
          Map<String, int>.from(json['subscribersByPlan'] as Map),
      revenueByPlan: (json['revenueByPlan'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$$SubscriberAnalyticsImplToJson(
        _$SubscriberAnalyticsImpl instance) =>
    <String, dynamic>{
      'totalSubscribers': instance.totalSubscribers,
      'newSubscribers': instance.newSubscribers,
      'canceledSubscriptions': instance.canceledSubscriptions,
      'churnRate': instance.churnRate,
      'retentionRate': instance.retentionRate,
      'subscribersByPlan': instance.subscribersByPlan,
      'revenueByPlan': instance.revenueByPlan,
    };

_$DashboardAnalyticsImpl _$$DashboardAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardAnalyticsImpl(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      monthlyRevenue: (json['monthlyRevenue'] as num).toDouble(),
      pendingRevenue: (json['pendingRevenue'] as num).toDouble(),
      totalSubscribers: (json['totalSubscribers'] as num).toInt(),
      activeSubscribers: (json['activeSubscribers'] as num).toInt(),
      revenueGrowthRate: (json['revenueGrowthRate'] as num).toDouble(),
      subscriberGrowthRate: (json['subscriberGrowthRate'] as num).toDouble(),
      avgRevenuePerUser: (json['avgRevenuePerUser'] as num).toDouble(),
      lifetimeValue: (json['lifetimeValue'] as num).toDouble(),
      dailyRevenue: (json['dailyRevenue'] as List<dynamic>)
          .map((e) => DailyRevenue.fromJson(e as Map<String, dynamic>))
          .toList(),
      monthlyRevenueHistory: (json['monthlyRevenueHistory'] as List<dynamic>)
          .map((e) => MonthlyRevenue.fromJson(e as Map<String, dynamic>))
          .toList(),
      revenueTrend:
          RevenueTrend.fromJson(json['revenueTrend'] as Map<String, dynamic>),
      subscriberAnalytics: SubscriberAnalytics.fromJson(
          json['subscriberAnalytics'] as Map<String, dynamic>),
      totalContents: (json['totalContents'] as num).toInt(),
      publishedThisMonth: (json['publishedThisMonth'] as num).toInt(),
      avgViewsPerContent: (json['avgViewsPerContent'] as num).toDouble(),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DashboardAnalyticsImplToJson(
        _$DashboardAnalyticsImpl instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'monthlyRevenue': instance.monthlyRevenue,
      'pendingRevenue': instance.pendingRevenue,
      'totalSubscribers': instance.totalSubscribers,
      'activeSubscribers': instance.activeSubscribers,
      'revenueGrowthRate': instance.revenueGrowthRate,
      'subscriberGrowthRate': instance.subscriberGrowthRate,
      'avgRevenuePerUser': instance.avgRevenuePerUser,
      'lifetimeValue': instance.lifetimeValue,
      'dailyRevenue': instance.dailyRevenue,
      'monthlyRevenueHistory': instance.monthlyRevenueHistory,
      'revenueTrend': instance.revenueTrend,
      'subscriberAnalytics': instance.subscriberAnalytics,
      'totalContents': instance.totalContents,
      'publishedThisMonth': instance.publishedThisMonth,
      'avgViewsPerContent': instance.avgViewsPerContent,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

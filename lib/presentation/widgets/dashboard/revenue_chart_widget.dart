import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/revenue_analytics.dart';
import 'package:creator_platform_demo/presentation/providers/revenue_analytics_provider.dart';
import 'package:intl/intl.dart';

/// 수익 차트 위젯 - 일간/주간/월간/연간 수익 트렌드를 표시
class RevenueChartWidget extends ConsumerWidget {
  final String creatorId;
  
  const RevenueChartWidget({
    super.key,
    required this.creatorId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedPeriod = ref.watch(selectedChartPeriodProvider);
    final chartData = ref.watch(filteredRevenueDataProvider(creatorId));
    
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.show_chart,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '수익 트렌드',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Period selector
                SegmentedButton<ChartPeriod>(
                  segments: ChartPeriod.values.map((period) {
                    return ButtonSegment(
                      value: period,
                      label: Text(period.label),
                    );
                  }).toList(),
                  selected: {selectedPeriod},
                  onSelectionChanged: (Set<ChartPeriod> newSelection) {
                    ref.read(selectedChartPeriodProvider.notifier).state = newSelection.first;
                  },
                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    textStyle: MaterialStateProperty.all(
                      theme.textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Chart
            if (chartData.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: CircularProgressIndicator(),
                ),
              )
            else
              SizedBox(
                height: 250,
                child: LineChart(
                  _mainChartData(context, chartData, selectedPeriod),
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                ),
              ),
          ],
        ),
      ),
    );
  }

  LineChartData _mainChartData(
    BuildContext context,
    List<TrendPoint> data,
    ChartPeriod period,
  ) {
    final theme = Theme.of(context);
    final maxY = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final minY = data.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final padding = (maxY - minY) * 0.1;
    
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: theme.colorScheme.surface,
          tooltipBorder: BorderSide(color: theme.colorScheme.outline),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                '${data[spot.spotIndex].label}\n${spot.y.toCompactKRW()}',
                TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: (maxY - minY) / 4,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: theme.colorScheme.outline.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: _getXInterval(data.length, period),
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= data.length) return const SizedBox();
              
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  data[index].label ?? '',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            interval: (maxY - minY) / 4,
            getTitlesWidget: (value, meta) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  value.toCompactKRW(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.outline, width: 1),
          left: BorderSide(color: theme.colorScheme.outline, width: 1),
        ),
      ),
      minX: 0,
      maxX: (data.length - 1).toDouble(),
      minY: minY - padding,
      maxY: maxY + padding,
      lineBarsData: [
        LineChartBarData(
          spots: data.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value.value);
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.8),
            ],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: data.length <= 10,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: theme.colorScheme.primary,
                strokeWidth: 2,
                strokeColor: theme.colorScheme.onPrimary,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(0.2),
                theme.colorScheme.primary.withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
  
  double _getXInterval(int dataLength, ChartPeriod period) {
    switch (period) {
      case ChartPeriod.daily:
        return dataLength > 15 ? 5 : 1;
      case ChartPeriod.weekly:
        return 1;
      case ChartPeriod.monthly:
        return dataLength > 6 ? 2 : 1;
      case ChartPeriod.yearly:
        return 1;
    }
  }
}
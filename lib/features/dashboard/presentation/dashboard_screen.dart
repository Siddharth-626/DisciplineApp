import 'package:discipline_app/core/providers.dart';
import 'package:discipline_app/widgets/state_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(logsProvider);
    final tasks = ref.watch(tasksProvider);
    final metrics = ref.watch(dashboardMetricsProvider);

    if (logs.isLoading || tasks.isLoading) return const Scaffold(body: AppLoading());
    if (logs.hasError) return Scaffold(body: AppError(message: logs.error.toString()));
    if (tasks.hasError) return Scaffold(body: AppError(message: tasks.error.toString()));

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 220,
            child: Card(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: metrics.completed.toDouble(),
                      title: 'Completed',
                      color: Colors.green,
                    ),
                    PieChartSectionData(
                      value: metrics.skipped.toDouble(),
                      title: 'Skipped',
                      color: Colors.amber,
                    ),
                    PieChartSectionData(
                      value: metrics.missed.toDouble(),
                      title: 'Missed',
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 260,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: BarChart(
                  BarChartData(
                    barGroups: metrics.categoryPerformance.entries
                        .toList()
                        .asMap()
                        .entries
                        .map(
                          (entry) => BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(toY: entry.value.value * 100, width: 18),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              title: const Text('Weekly streak counter'),
              trailing: Text('${metrics.currentStreak} days'),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Longest streak'),
              trailing: Text('${metrics.longestStreak} days'),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Productivity score'),
              trailing: Text('${metrics.productivityScore.toStringAsFixed(1)}%'),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Monthly summary'),
              subtitle: Text(metrics.monthlySummary),
            ),
          ),
        ],
      ),
    );
  }
}

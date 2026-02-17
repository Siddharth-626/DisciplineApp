import 'package:discipline_app/features/tasks/domain/task_log_model.dart';
import 'package:discipline_app/features/tasks/domain/task_model.dart';

class DashboardMetrics {
  DashboardMetrics({
    required this.completed,
    required this.skipped,
    required this.missed,
    required this.categoryPerformance,
    required this.currentStreak,
    required this.longestStreak,
    required this.productivityScore,
    required this.monthlySummary,
  });

  final int completed;
  final int skipped;
  final int missed;
  final Map<String, double> categoryPerformance;
  final int currentStreak;
  final int longestStreak;
  final double productivityScore;
  final String monthlySummary;

  factory DashboardMetrics.fromData({
    required List<TaskModel> tasks,
    required List<TaskLogModel> logs,
  }) {
    var completed = 0;
    var skipped = 0;
    var missed = 0;
    final categoryPerformance = <String, double>{};

    for (final log in logs) {
      switch (log.status) {
        case TaskStatus.completed:
          completed++;
        case TaskStatus.skipped:
          skipped++;
        case TaskStatus.missed:
          missed++;
      }
    }

    for (final task in tasks) {
      final taskLogs = logs.where((log) => log.taskId == task.id);
      final hits = taskLogs.where((log) => log.status == TaskStatus.completed).length;
      final total = taskLogs.length;
      categoryPerformance[task.category] =
          ((categoryPerformance[task.category] ?? 0) + (total == 0 ? 0 : hits / total));
    }

    final streakStats = _calculateStreaks(logs);
    final total = completed + skipped + missed;
    final productivity = total == 0 ? 0 : (completed / total) * 100;

    return DashboardMetrics(
      completed: completed,
      skipped: skipped,
      missed: missed,
      categoryPerformance: categoryPerformance,
      currentStreak: streakStats.$1,
      longestStreak: streakStats.$2,
      productivityScore: productivity,
      monthlySummary:
          'Completed $completed tasks this month, skipped $skipped and missed $missed.',
    );
  }

  static (int, int) _calculateStreaks(List<TaskLogModel> logs) {
    final completedDates = logs
        .where((log) => log.status == TaskStatus.completed)
        .map((log) => DateTime(log.date.year, log.date.month, log.date.day))
        .toSet()
        .toList()
      ..sort();

    var longest = 0;
    var current = 0;
    DateTime? prev;
    for (final date in completedDates) {
      if (prev == null || date.difference(prev).inDays == 1) {
        current++;
      } else {
        current = 1;
      }
      if (current > longest) longest = current;
      prev = date;
    }

    return (current, longest);
  }
}

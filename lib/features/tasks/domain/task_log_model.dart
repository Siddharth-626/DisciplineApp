import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus { completed, skipped, missed }

class TaskLogModel {
  const TaskLogModel({
    required this.id,
    required this.taskId,
    required this.date,
    required this.status,
  });

  final String id;
  final String taskId;
  final DateTime date;
  final TaskStatus status;

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'date': Timestamp.fromDate(date),
      'status': status.name,
    };
  }

  factory TaskLogModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskLogModel(
      id: id,
      taskId: map['taskId'] as String? ?? '',
      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: TaskStatus.values.byName(map['status'] as String? ?? 'missed'),
    );
  }
}

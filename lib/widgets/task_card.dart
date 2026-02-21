import 'package:discipline_app/features/tasks/domain/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    required this.onTap,
    required this.onDelete,
    super.key,
  });

  final TaskModel task;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(backgroundColor: task.displayColor),
        title: Text(task.title),
        subtitle: Text(
          '${task.category} • ${DateFormat.Hm().format(task.startTime)} - ${DateFormat.Hm().format(task.endTime)}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          tooltip: 'Delete Task',
          onPressed: onDelete,
        ),
      ),
    );
  }
}

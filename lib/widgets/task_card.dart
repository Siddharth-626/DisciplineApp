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

  void _showDeleteConfirmation(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task?'),
        content: const Text(
          'Are you sure you want to delete this task? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        onDelete();
      }
    });
  }

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
          tooltip: 'Delete task',
          icon: const Icon(Icons.delete_outline),
          onPressed: () => _showDeleteConfirmation(context),
        ),
      ),
    );
  }
}

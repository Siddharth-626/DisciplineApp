import 'package:discipline_app/core/providers.dart';
import 'package:discipline_app/features/auth/presentation/auth_controller.dart';
import 'package:discipline_app/features/tasks/domain/task_log_model.dart';
import 'package:discipline_app/features/tasks/presentation/task_controller.dart';
import 'package:discipline_app/features/tasks/presentation/task_form_screen.dart';
import 'package:discipline_app/widgets/state_widgets.dart';
import 'package:discipline_app/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Tasks'),
        actions: [
          IconButton(
            onPressed: () => context.push('/dashboard'),
            icon: const Icon(Icons.analytics_outlined),
            tooltip: 'View Dashboard',
          ),
          IconButton(
            onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: tasksAsync.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return const AppEmpty(message: 'No tasks yet. Tap + to create your first recurring task.');
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Column(
                children: [
                  TaskCard(
                    task: task,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TaskFormScreen(task: task)),
                    ),
                    onDelete: () async {
                      final confirmed = await showDialog<bool>(
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
                              child: const Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true && context.mounted) {
                        ref.read(taskControllerProvider.notifier).deleteTask(task.id);
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => ref.read(taskControllerProvider.notifier).logTaskStatus(
                              taskId: task.id,
                              status: TaskStatus.completed,
                            ),
                        child: const Text('Completed'),
                      ),
                      TextButton(
                        onPressed: () => ref.read(taskControllerProvider.notifier).logTaskStatus(
                              taskId: task.id,
                              status: TaskStatus.skipped,
                            ),
                        child: const Text('Skipped'),
                      ),
                      TextButton(
                        onPressed: () => ref.read(taskControllerProvider.notifier).logTaskStatus(
                              taskId: task.id,
                              status: TaskStatus.missed,
                            ),
                        child: const Text('Missed'),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        error: (error, _) => AppError(message: error.toString()),
        loading: AppLoading.new,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TaskFormScreen()),
        ),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

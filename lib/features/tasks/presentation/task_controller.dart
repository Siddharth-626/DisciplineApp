import 'package:discipline_app/core/providers.dart';
import 'package:discipline_app/features/tasks/domain/task_log_model.dart';
import 'package:discipline_app/features/tasks/domain/task_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final taskControllerProvider = StateNotifierProvider<TaskController, AsyncValue<void>>(
  (ref) => TaskController(ref),
);

class TaskController extends StateNotifier<AsyncValue<void>> {
  TaskController(this._ref) : super(const AsyncData(null));

  final Ref _ref;
  final _uuid = const Uuid();

  Future<void> saveTask(TaskModel task) async {
    final user = _ref.read(authStateProvider).value;
    if (user == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _ref.read(firestoreServiceProvider).upsertTask(user.uid, task);
      if (task.reminderEnabled) {
        await _ref.read(notificationServiceProvider).showReminder(
              id: task.id.hashCode,
              title: task.title,
              body: 'Reminder for ${task.category}',
            );
      }
    });
  }

  Future<void> deleteTask(String taskId) async {
    final user = _ref.read(authStateProvider).value;
    if (user == null) return;
    await _ref.read(firestoreServiceProvider).deleteTask(user.uid, taskId);
  }

  Future<void> logTaskStatus({required String taskId, required TaskStatus status}) async {
    final user = _ref.read(authStateProvider).value;
    if (user == null) return;
    final log = TaskLogModel(
      id: _uuid.v4(),
      taskId: taskId,
      date: DateTime.now(),
      status: status,
    );
    await _ref.read(firestoreServiceProvider).addLog(user.uid, log);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discipline_app/features/dashboard/domain/dashboard_metrics.dart';
import 'package:discipline_app/features/tasks/domain/task_log_model.dart';
import 'package:discipline_app/features/tasks/domain/task_model.dart';
import 'package:discipline_app/services/auth_service.dart';
import 'package:discipline_app/services/firestore_service.dart';
import 'package:discipline_app/services/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final messagingProvider = Provider<FirebaseMessaging>((ref) => FirebaseMessaging.instance);
final localNotificationsProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) => FlutterLocalNotificationsPlugin());

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(firebaseAuthProvider));
});

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(ref.watch(firestoreProvider));
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(
    ref.watch(messagingProvider),
    ref.watch(localNotificationsProvider),
  );
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges();
});

final tasksProvider = StreamProvider<List<TaskModel>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) {
    return Stream.value(<TaskModel>[]);
  }
  return ref.watch(firestoreServiceProvider).watchTasks(user.uid);
});

final logsProvider = StreamProvider<List<TaskLogModel>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) {
    return Stream.value(<TaskLogModel>[]);
  }
  return ref.watch(firestoreServiceProvider).watchLogs(user.uid);
});

final dashboardMetricsProvider = Provider<DashboardMetrics>((ref) {
  final tasks = ref.watch(tasksProvider).value ?? <TaskModel>[];
  final logs = ref.watch(logsProvider).value ?? <TaskLogModel>[];
  return DashboardMetrics.fromData(tasks: tasks, logs: logs);
});

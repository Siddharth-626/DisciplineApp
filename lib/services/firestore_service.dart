import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discipline_app/features/tasks/domain/task_log_model.dart';
import 'package:discipline_app/features/tasks/domain/task_model.dart';

class FirestoreService {
  FirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  Future<void> enablePersistence() async {
    _firestore.settings = const Settings(persistenceEnabled: true);
  }

  CollectionReference<Map<String, dynamic>> _tasksRef(String uid) =>
      _firestore.collection('users').doc(uid).collection('tasks');

  CollectionReference<Map<String, dynamic>> _logsRef(String uid) =>
      _firestore.collection('users').doc(uid).collection('task_logs');

  Stream<List<TaskModel>> watchTasks(String uid) {
    return _tasksRef(uid).orderBy('createdAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => TaskModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> upsertTask(String uid, TaskModel task) async {
    await _tasksRef(uid).doc(task.id).set(task.toMap(), SetOptions(merge: true));
  }

  Future<void> deleteTask(String uid, String taskId) async {
    await _tasksRef(uid).doc(taskId).delete();
  }

  Stream<List<TaskLogModel>> watchLogs(String uid) {
    return _logsRef(uid).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => TaskLogModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> addLog(String uid, TaskLogModel log) async {
    await _logsRef(uid).doc(log.id).set(log.toMap());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskModel {
  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.recurringType,
    required this.category,
    required this.color,
    required this.reminderEnabled,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String recurringType;
  final String category;
  final int color;
  final bool reminderEnabled;
  final DateTime createdAt;

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? recurringType,
    String? category,
    int? color,
    bool? reminderEnabled,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      recurringType: recurringType ?? this.recurringType,
      category: category ?? this.category,
      color: color ?? this.color,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Color get displayColor => Color(color);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'recurringType': recurringType,
      'category': category,
      'color': color,
      'reminderEnabled': reminderEnabled,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
      id: id,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      startTime: (map['startTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endTime: (map['endTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      recurringType: map['recurringType'] as String? ?? 'daily',
      category: map['category'] as String? ?? 'Personal',
      color: map['color'] as int? ?? Colors.indigo.value,
      reminderEnabled: map['reminderEnabled'] as bool? ?? false,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

import 'package:discipline_app/core/constants/app_constants.dart';
import 'package:discipline_app/features/tasks/domain/task_model.dart';
import 'package:discipline_app/features/tasks/presentation/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  const TaskFormScreen({this.task, super.key});

  final TaskModel? task;

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  late String _category;
  late String _recurring;
  var _color = Colors.indigo.value;
  var _reminder = false;
  TimeOfDay _start = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _end = const TimeOfDay(hour: 9, minute: 0);

  @override
  void initState() {
    super.initState();
    final task = widget.task;
    _title.text = task?.title ?? '';
    _description.text = task?.description ?? '';
    _category = task?.category ?? AppConstants.taskCategories.first;
    _recurring = task?.recurringType ?? AppConstants.recurringTypes.first;
    _color = task?.color ?? Colors.indigo.value;
    _reminder = task?.reminderEnabled ?? false;
    if (task != null) {
      _start = TimeOfDay.fromDateTime(task.startTime);
      _end = TimeOfDay.fromDateTime(task.endTime);
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Create Task' : 'Edit Task')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _description,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _category,
              items: AppConstants.taskCategories
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) => setState(() => _category = value!),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _recurring,
              items: AppConstants.recurringTypes
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) => setState(() => _recurring = value!),
              decoration: const InputDecoration(labelText: 'Recurring Type'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final picked = await showTimePicker(context: context, initialTime: _start);
                      if (picked != null) setState(() => _start = picked);
                    },
                    child: Text('Start: ${_start.format(context)}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final picked = await showTimePicker(context: context, initialTime: _end);
                      if (picked != null) setState(() => _end = picked);
                    },
                    child: Text('End: ${_end.format(context)}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                for (final color in [
                  (Colors.indigo, 'Indigo'),
                  (Colors.teal, 'Teal'),
                  (Colors.orange, 'Orange'),
                  (Colors.pink, 'Pink'),
                ])
                  ChoiceChip(
                    label: const Text(''),
                    tooltip: 'Select ${color.$2} color',
                    selectedColor: color.$1,
                    selected: _color == color.$1.value,
                    onSelected: (_) => setState(() => _color = color.$1.value),
                    avatar: CircleAvatar(backgroundColor: color.$1),
                  ),
              ],
            ),
            SwitchListTile(
              value: _reminder,
              onChanged: (value) => setState(() => _reminder = value),
              title: const Text('Enable reminder'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                final now = DateTime.now();
                final startTime = DateTime(now.year, now.month, now.day, _start.hour, _start.minute);
                final endTime = DateTime(now.year, now.month, now.day, _end.hour, _end.minute);
                final task = TaskModel(
                  id: widget.task?.id ?? const Uuid().v4(),
                  title: _title.text.trim(),
                  description: _description.text.trim(),
                  startTime: startTime,
                  endTime: endTime,
                  recurringType: _recurring,
                  category: _category,
                  color: _color,
                  reminderEnabled: _reminder,
                  createdAt: widget.task?.createdAt ?? now,
                );
                await ref.read(taskControllerProvider.notifier).saveTask(task);
                if (mounted) context.pop();
              },
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}

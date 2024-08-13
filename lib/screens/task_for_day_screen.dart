import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskListForDateScreen extends StatelessWidget {
  final List<Task> tasks;
  final DateTime selectedDate;

  TaskListForDateScreen({required this.tasks, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks for ${selectedDate.toLocal().toString().split(' ')[0]}'),
      ),
      body: tasks.isEmpty
          ? Center(
        child: Text('No tasks for this day!'),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (ctx, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text(task.description),
            trailing: task.isCompleted
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.radio_button_unchecked, color: Colors.red),
          );
        },
      ),
    );
  }
}
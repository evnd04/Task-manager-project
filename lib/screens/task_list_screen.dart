import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import 'calendar_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];

  void _addTask(String name, String description, DateTime dueDate) {
    final newTask = Task(
      id: const Uuid().v4(),
      name: name,
      description: description,
      dueDate: dueDate,
    );
    setState(() {
      _tasks.add(newTask);
    });
  }

  void _editTask(String id, String name, String description, DateTime dueDate, bool isCompleted) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      setState(() {
        _tasks[taskIndex] = Task(
          id: id,
          name: name,
          description: description,
          dueDate: dueDate,
          isCompleted: isCompleted,
        );
      });
    }
  }

  void _deleteTask(String id) {
    setState(() {
      _tasks.removeWhere((task) => task.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => CalendarScreen(tasks: _tasks)));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (ctx, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text(task.description),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteTask(task.id),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => EditTaskScreen(
                    task: task,
                    editTask: _editTask,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AddTaskScreen(addTask: _addTask)));
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';
import 'task_for_day_screen.dart';

class CalendarScreen extends StatefulWidget {
  final List<Task> tasks;

  CalendarScreen({required this.tasks});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Task> _getTasksForDay(DateTime day) {
    return widget.tasks.where((task) =>
    task.dueDate.year == day.year &&
        task.dueDate.month == day.month &&
        task.dueDate.day == day.day).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              final tasksForSelectedDay = _getTasksForDay(selectedDay);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => TaskListForDateScreen(tasks: tasksForSelectedDay, selectedDate: selectedDay),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
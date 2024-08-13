class Task {
  String id;
  String name;
  String description;
  DateTime dueDate;
  bool isCompleted;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });
}
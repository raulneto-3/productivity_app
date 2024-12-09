class Task {
  String id;
  String title;
  String description;
  DateTime? dueDate;
  String priority;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });
}
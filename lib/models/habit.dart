class Habit {
  String id;
  String name;
  List<DateTime> completionDates;
  String frequency;
  DateTime reminderTime;
  int priority;

  Habit({
    required this.id,
    required this.name,
    this.completionDates = const [],
    required this.frequency,
    required this.reminderTime,
    required this.priority,
  });
}
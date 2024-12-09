import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'create_record_screen.dart';

class HabitScreen extends StatefulWidget {
  @override
  _HabitScreenState createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  List<Habit> habits = [];

  void _addHabit(Habit habit) {
    setState(() {
      habits.add(habit);
    });
  }

  void _deleteHabit(String id) {
    setState(() {
      habits.removeWhere((habit) => habit.id == id);
    });
  }

  void _toggleCompletion(Habit habit) {
    setState(() {
      if (habit.completionDates.contains(DateTime.now())) {
        habit.completionDates.remove(DateTime.now());
      } else {
        habit.completionDates.add(DateTime.now());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acompanhamento de Hábitos'),
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (ctx, index) {
          final habit = habits[index];
          return ListTile(
            title: Text(habit.name),
            subtitle: Text('Frequência: ${habit.frequency}, Prioridade: ${habit.priority}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () => _toggleCompletion(habit),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteHabit(habit.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newHabit = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRecordScreen(recordType: 'habit')),
          );
          if (newHabit != null) {
            _addHabit(newHabit);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
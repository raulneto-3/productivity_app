import 'package:flutter/material.dart';
import '../models/task.dart';
import 'create_record_screen.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void _deleteTask(String id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciamento de Tarefas'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (ctx, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteTask(task.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRecordScreen(recordType: 'task')),
          );
          if (newTask != null) {
            _addTask(newTask);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
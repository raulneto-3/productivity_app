import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/task.dart';
import '../models/habit.dart';

class CreateRecordScreen extends StatefulWidget {
  final String recordType;

  CreateRecordScreen({required this.recordType});

  @override
  _CreateRecordScreenState createState() => _CreateRecordScreenState();
}

class _CreateRecordScreenState extends State<CreateRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();
  TimeOfDay _reminderTime = TimeOfDay.now();
  DateTime? _dueDate;
  final _uuid = Uuid();
  String _selectedFrequency = 'Diária';
  String _selectedPriority = 'Média';
  double _priority = 3.0; // Definindo a variável _priority

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Novo ${widget.recordType == 'task' ? 'Tarefa' : 'Hábito'}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              if (widget.recordType == 'task') ...[
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Título'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um título';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                ),
                ListTile(
                  title: Text('Data e Hora: ${_dueDate != null ? _dueDate.toString() : 'Não definida'}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _dueDate = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      }
                    }
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedPriority,
                  decoration: InputDecoration(labelText: 'Prioridade'),
                  items: ['Alta', 'Média', 'Baixa']
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione a prioridade';
                    }
                    return null;
                  },
                ),
              ] else if (widget.recordType == 'habit') ...[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedFrequency,
                  decoration: InputDecoration(labelText: 'Frequência'),
                  items: ['Diária', 'Semanal', 'Mensal']
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFrequency = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione a frequência';
                    }
                    return null;
                  },
                ),
                ListTile(
                  title: Text('Lembrete: ${_reminderTime.format(context)}'),
                  trailing: Icon(Icons.alarm),
                  onTap: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: _reminderTime,
                    );
                    if (picked != null && picked != _reminderTime) {
                      setState(() {
                        _reminderTime = picked;
                      });
                    }
                  },
                ),
                Text('Prioridade'),
                RatingBar.builder(
                  initialRating: _priority,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _priority = rating;
                    });
                  },
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.recordType == 'task') {
                      final newTask = Task(
                        id: _uuid.v4(),
                        title: _titleController.text,
                        description: _descriptionController.text,
                        dueDate: _dueDate, // Ajuste conforme necessário
                        priority: _selectedPriority,
                      );
                      Navigator.pop(context, newTask);
                    } else if (widget.recordType == 'habit') {
                      final newHabit = Habit(
                        id: _uuid.v4(),
                        name: _nameController.text,
                        frequency: _selectedFrequency,
                        reminderTime: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          _reminderTime.hour,
                          _reminderTime.minute,
                        ),
                        priority: _priority.toInt(),
                      );
                      Navigator.pop(context, newHabit);
                    }
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
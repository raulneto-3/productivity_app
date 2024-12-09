import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/task_screen.dart';
import 'screens/habit_screen.dart';
import 'screens/pomodoro_timer.dart';
import 'theme_notifier.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: ProductivityApp(),
    ),
  );
}

class ProductivityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'App de Produtividade',
          theme: themeNotifier.currentTheme.copyWith(
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Aldrich',
                ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
            '/pomodoro': (context) => PomodoroTimer(),
            '/tasks': (context) => TaskScreen(),
            '/habits': (context) => HabitScreen(),
          },
        );
      },
    );
  }
}
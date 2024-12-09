import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_notifier.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Produtividade'),
        actions: [
          Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, child) {
              return Switch(
                value: themeNotifier.isDarkMode,
                onChanged: (value) {
                  themeNotifier.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.timer),
            title: Text('Pomodoro Timer'),
            onTap: () {
              Navigator.pushNamed(context, '/pomodoro');
            },
          ),
          ListTile(
            leading: Icon(Icons.task),
            title: Text('Gerenciamento de Tarefas'),
            onTap: () {
              Navigator.pushNamed(context, '/tasks');
            },
          ),
          ListTile(
            leading: Icon(Icons.perm_contact_calendar),
            title: Text('Acompanhamento de Hábitos'),
            onTap: () {
              Navigator.pushNamed(context, '/habits');
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:async';

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  static const int workTime = 25 * 60;
  static const int breakTime = 5 * 60;
  int remainingTime = workTime;
  bool isWorking = true;
  Timer? timer;

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          isWorking = !isWorking;
          remainingTime = isWorking ? workTime : breakTime;
        }
      });
    });
  }

  void _stopTimer() {
    timer?.cancel();
  }

  void _resetTimer() {
    timer?.cancel();
    setState(() {
      remainingTime = isWorking ? workTime : breakTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = remainingTime / (isWorking ? workTime : breakTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isWorking ? 'Hora de Trabalhar!' : 'Hora de Descansar!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Aldrich',
                ),
              ),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isWorking ? Colors.cyanAccent : Colors.greenAccent,
                      ),
                    ),
                  ),
                  Text(
                    '${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Aldrich',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _startTimer,
                    child: Text('Iniciar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _stopTimer,
                    child: Text('Parar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _resetTimer,
                    child: Text('Resetar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
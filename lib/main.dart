import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String titleText = 'Cycle 0 / 4';
  int cycleCount = 0;
  int countdown = 0;
  Timer? _timer;
  final player = AudioPlayer();
  String intensiu = 'musica/intensiu.mp3';
  String descans = 'musica/descans.mp3'; 

  void resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    player.stop();
    cycleCount = 1;
    titleText = 'Cycle $cycleCount / 4';
    countdown = 4;
    timerIntensiu();
  }
  Future<void> timerIntensiu() async {
    countdown = 4;
    await player.play(UrlSource(intensiu));
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (countdown < 1) {
          t.cancel();
          player.stop();
          timerDescans();
        } else {
          countdown--;
        }
      });
    });
  }

  Future<void> timerDescans() async {
    countdown = 3;
    await player.play(UrlSource(descans));
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (countdown < 1) {
          t.cancel();
          player.stop();
          handleTimeout();
        } else {
          countdown--;
        }
      });
    });
  }
  void handleTimeout() {
    setState(() {
      cycleCount++;
      titleText = 'Cycle $cycleCount / 4';
      if (cycleCount < 4) {
        timerIntensiu();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  titleText,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Center(
                child: Text(
                  'Countdown: $countdown',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    resetTimer();
                  },
                  child: Text('Start/Reset'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

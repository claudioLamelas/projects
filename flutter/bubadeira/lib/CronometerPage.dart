import 'dart:async';

import 'package:flutter/material.dart';

import 'Common/Constant.dart';

class CronometerPage extends StatefulWidget {
  const CronometerPage({Key? key}) : super(key: key);

  @override
  _CronometerPageState createState() => _CronometerPageState();
}

class _CronometerPageState extends State<CronometerPage> {
  Map data = {};
  double time = 0;
  Timer? _timer;
  int timerState = -1;

  @override
  Widget build(BuildContext context) {
    if (_timer == null) {
      data = ModalRoute.of(context)!.settings.arguments as Map;
      time = data['time'];
    }
    time = num.parse(time.toStringAsFixed(1)) as double;

    return Scaffold(
      backgroundColor: Constant.mainBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constant.mainBackgroundColor,
        leading: IconButton(
          iconSize: 35,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            if (_timer != null) {
              _timer!.cancel();
            }
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 60),
            alignment: Alignment.topCenter,
            child: Text(
              '$time',
              style: TextStyle(fontSize: 50),
            ),
          ),
          Padding(
            child: getRightButton(timerState),
            padding: EdgeInsets.only(top: 40),
          ),
          if (timerState == 1) finishedMessage('Congratulations Champ!!'),
          if (timerState == 2) finishedMessage('Oops! What a loser'),
        ],
      ),
    );
  }

  void _startTimer() {
    if (_timer != null) {
      setState(() {
        _timer!.cancel();
        timerState = 1;
      });
    } else {
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        setState(() {
          timerState = 0;
          if (time > 0) {
            time -= 0.1;
          } else {
            _timer!.cancel();
            time = 0;
            timerState = 2;
          }
        });
      });
    }
  }

  getRightButton(int timerState) {
    switch (timerState) {
      case -1:
        return FloatingActionButton.extended(
          backgroundColor: Constant.buttonColor,
          label: Text(
            'START',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          onPressed: () => _startTimer(),
        );
      case 0:
        return FloatingActionButton.extended(
          backgroundColor: Constant.buttonColor,
          label: Text(
            'DONE',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          onPressed: () => _startTimer(),
        );
      case 1:
        return FloatingActionButton.extended(
          backgroundColor: Constant.buttonColor,
          label: Text(
            'RETURN',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          onPressed: () => Navigator.of(context).pop(),
        );
      case 2:
        return FloatingActionButton.extended(
          backgroundColor: Constant.buttonColor,
          label: Text(
            'RETURN',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          onPressed: () => Navigator.of(context).pop(),
        );
      default:
    }
  }

  finishedMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Text(
        message,
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  double percent = 0;
  static int TimeInMinut = 25;
  int TimeInSec = TimeInMinut * 60;
  Timer timer;
  void _StartTimer() {
    TimeInMinut = 25;
    int Time = TimeInSec;
    double SecPercent = (Time / 100);
    print(SecPercent);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (Time > 0) {
          Time--;
          if (Time % 60 == 0) {
            TimeInMinut--;
          }
          if (Time % SecPercent == 0) {
            if (percent < 1) {
              percent += 0.01;
            } else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          TimeInMinut = 25;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF1542BF), Color(0xFF51A8FF)],
                  begin: FractionalOffset(0.5, 1))),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  "Pomodoro",
                  style: TextStyle(color: Colors.white, fontSize: 50.0),
                ),
              ),
              Expanded(
                child: CircularPercentIndicator(
                  percent: percent,
                  animation: true,
                  lineWidth: 20.0,
                  circularStrokeCap: CircularStrokeCap.round,
                  reverse: false,
                  animateFromLastPercent: true,
                  radius: 250.0,
                  progressColor: Colors.white,
                  center: Text(
                    "$TimeInMinut",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Study Time",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "25",
                                        style: TextStyle(fontSize: 80.0),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Break Time",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "5",
                                        style: TextStyle(fontSize: 80.0),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 28.0),
                            child: ElevatedButton(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  "Start Studying",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22.0),
                                ),
                              ),
                              onPressed: _StartTimer,
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

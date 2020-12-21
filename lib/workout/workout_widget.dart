import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainer/workout/charts/GaugeChart.dart';
import 'package:trainer/workout/charts/SparkBar.dart';


class WorkoutWidget extends StatefulWidget {
  WorkoutWidget({Key key}) : super(key: key);

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<WorkoutWidget> {
  _WorkoutState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Expanded(child: SparkBar.withSampleData()),
              height: 50,
            ),
            Expanded(child: gaugeChart()),
          ],
        ),
      ),
    );
  }

  Stack gaugeChart() {
    return Stack(
      children: <Widget>[
        GaugeChart.withSampleData(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(" More\nPower!",
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              Text("200",
                  style:
                      TextStyle(fontSize: 100.0, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("84     ",
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold)),
                  Text("140",
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

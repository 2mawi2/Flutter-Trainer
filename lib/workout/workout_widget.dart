import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainer/common/model/SensorData.dart';
import 'package:trainer/common/data/native/SensorChannel.dart';
import 'package:trainer/workout/charts/GaugeChart.dart';
import 'package:trainer/workout/charts/SparkBar.dart';

class WorkoutWidget extends StatefulWidget {
  WorkoutWidget({Key key}) : super(key: key);

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<WorkoutWidget> {
  _WorkoutState();

  var hearthRateData = <SensorData>[];

  @override
  Widget build(BuildContext context) {
    var sensorChannel = SensorChannel();
    sensorChannel.onNewSensorDataHandler = (SensorData sensorData) {
      switch (sensorData.dataPointType) {
        case "HEARTHRATE_BPM":
          hearthRateData.add(sensorData);
          break;
      }
      setState(() {});
    };

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
                  Text("80         ", //hearthRateData.last.dataPoint,
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold)),
                  Text(getLastHearthRate(),
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

  String getLastHearthRate() {
    return hearthRateData.isNotEmpty ? hearthRateData.last.dataPoint : "--";
  }
}

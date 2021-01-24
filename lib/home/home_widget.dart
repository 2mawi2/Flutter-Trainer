import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainer/common/model/Sensor.dart';
import 'package:trainer/common/model/SensorData.dart';
import 'package:trainer/data/local/preferences_repo.dart';
import 'package:trainer/data/native/SensorChannel.dart';
import 'package:trainer/home/sensor_widget.dart';
import 'package:trainer/workout/workout_widget.dart';
import 'package:trainer/zone/zone_widget.dart';

import '../common/styles.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key) {}

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> {
  var sensors = <Sensor>[];
  var isDiscoveryStarted = false;
  var sensorChannel = SensorChannel();
  var sensorDataMap = HashMap<String, List<SensorData>>();

  Future _onClickDiscoverButton() async {
    if (!isDiscoveryStarted) {
      isDiscoveryStarted = true;
      sensorChannel.onSensorConnectionStateChangedHandler = (Sensor sensor) {
        updateOrAddSensor(sensors, sensor);
        setState(() {});
      };
      sensorChannel.onNewSensorDataHandler = (SensorData sensorData) {
        updateSensorData(sensorData);
        setState(() {});
      };
      await sensorChannel.startService();
    }
  }

  void updateSensorData(SensorData sensorData) {
    if (!sensorDataMap.containsKey(sensorData.sensorId)) {
      sensorDataMap[sensorData.sensorId] = [sensorData];
    } else {
      sensorDataMap[sensorData.sensorId].add(sensorData);
    }
  }

  void updateOrAddSensor(List<Sensor> sensors, Sensor sensor) {
    var sensorExists = sensors.any((it) => it.id == sensor.id);
    if (sensorExists) {
      var indexToUpdate = sensors.indexWhere((it) => it.id == sensor.id);
      sensors[indexToUpdate] = sensor;
    } else {
      sensors.add(sensor);
    }
  }

  void _onClickSelectButton() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => WorkoutWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          HomeButtons(),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buttonFlatDefault(
                Key("btn_discover"),
                "Discover",
                _onClickDiscoverButton,
              ),
              SizedBox(width: 20),
              discoverProgressIndicator()
            ],
          ),
          Sensors(),
          Spacer(),
        ],
      ),
    );
  }

  Widget discoverProgressIndicator() {
    print("isDiscoveryStarted $isDiscoveryStarted");
    return Visibility(
      visible: isDiscoveryStarted,
      child: SizedBox(
        child: new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        height: 25,
        width: 25,
      ),
    );
  }

  Column HomeButtons() {
    return Column(
      children: <Widget>[
        buttonFlatDefault(
          Key("btn_select"),
          "Select Training Plan",
          _onClickSelectButton,
        ),
      ],
    );
  }

  String getLatestDataOrDefault(String sensorId) {
    if (!sensorDataMap.containsKey(sensorId) || sensorDataMap[sensorId].isEmpty) {
      return "";
    } else {
      var sensorData = sensorDataMap[sensorId].last;
      return sensorData.getDefaultLabel();
    }
  }

  Column Sensors() {
    return Column(
        children: sensors
            .map((sensor) => SensorWidget(
                  sensor: sensor,
                  sensorField: getLatestDataOrDefault(sensor.id),
                ))
            .toList());
  }
}

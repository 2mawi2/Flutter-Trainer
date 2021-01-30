import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainer/common/model/Sensor.dart';
import 'package:trainer/common/model/SensorData.dart';
import 'package:trainer/common/data/local/preferences_repo.dart';
import 'package:trainer/common/data/native/SensorChannel.dart';
import 'package:trainer/home/sensor_widget.dart';
import 'package:trainer/workout/workout_widget.dart';
import 'package:trainer/zone/zone_widget.dart';

import '../common/styles.dart';
import '../container.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key) {}

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> {
  var sensorChannel = getIt<SensorChannel>();

  var persistedSensors = <Sensor>[];
  var sensors = <Sensor>[];
  var sensorDataMap = HashMap<String, List<SensorData>>();
  var isDiscoveryStarted = false;

  @override
  void initState() {
    sensorChannel.onSensorConnectionStateChangedHandler = (Sensor sensor) {
      updateOrAddSensor(sensors, sensor);
      setState(() {});
    };
    sensorChannel.onNewSensorDataHandler = (SensorData sensorData) {
      updateSensorData(sensorData);
      setState(() {});
    };
  }

  @override
  void dispose() {
    sensorChannel.onNewSensorDataHandler = null;
    sensorChannel.onSensorConnectionStateChangedHandler = null;
  }

  Future _onClickDiscoverButton() async {
    if (!isDiscoveryStarted) {
      isDiscoveryStarted = true;
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
        children: <Widget>[
          Spacer(),
          HomeButtons(),
          Spacer(),
          Text("Linked Sensors:", style: TextStyle(color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buttonFlatDefault(
                Key("btn_discover"),
                "Edit Sensors",
                _onClickDiscoverButton,
              ),
              SizedBox(width: 20),
              discoverProgressIndicator()
            ],
          ),
          Sensors(persistedSensors, true),
          Sensors(sensors, false),
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

  Column Sensors(List<Sensor> sensors, bool isSavedByUser) {
    return Column(
        children: sensors
            .map(
              (sensor) => SensorWidget(
                sensor: sensor,
                sensorField: getLatestDataOrDefault(sensor.id),
                onClickSensorButton: onClickSensorButton,
                isSavedByUser: isSavedByUser,
              ),
            )
            .toList());
  }



  void onClickSensorButton(String sensorId, bool toBeRemoved) {
    if (toBeRemoved) {
      moveSensor(persistedSensors, sensors, sensorId);
    } else {
      moveSensor(sensors, persistedSensors, sensorId);
    }
    sortSensors();
    setState(() {});
  }

  void moveSensor(List<Sensor> from, List<Sensor> to, String sensorId) {
    var sensorToBeRemoved = from.firstWhere((element) => element.id == sensorId);
    from.removeWhere((element) => element.id == sensorId);
    to.add(sensorToBeRemoved);
  }

  void sortSensors() {
    persistedSensors.sort((l, r) => l.name.compareTo(r.name));
    sensors.sort((l, r) => l.name.compareTo(r.name));
  }
}

typedef SensorButtonCallback = void Function(String sensorId, bool toBeRemoved);

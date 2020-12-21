import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainer/common/model/Sensor.dart';
import 'package:trainer/data/local/preferences_repo.dart';
import 'package:trainer/data/native/SensorChannel.dart';
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

  Future _onClickDiscoverButton() async {
    if (!isDiscoveryStarted) {
      var sensorChannel = SensorChannel();
      sensorChannel.onSensorConnectionStateChangedHandler = (Sensor sensor) {
        updateOrAddSensor(sensors, sensor);
        setState(() {});
      };
      await sensorChannel.startService();
    }
  }

  void updateOrAddSensor(List<Sensor> sensors, Sensor sensor) {
    var sensorExists = sensors.any((it) => it.name == sensor.name);
    if (sensorExists) {
      var indexToUpdate = sensors.indexWhere((it) => it.name == sensor.name);
      sensors[indexToUpdate] = sensor;
    } else {
      sensors.add(sensor);
    }
  }

  void _onClickSelectButton() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => WorkoutWidget()));
  }

  void _onClickZonesButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ZoneWidget(preferencesRepo: PreferencesRepo())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trainer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            HomeButtons(),
            Spacer(),
            Sensors(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Column HomeButtons() {
    return Column(
      children: <Widget>[
        buttonFlatDefault(
          Key("btn_discover"),
          "Discover",
          _onClickDiscoverButton,
        ),
        buttonFlatDefault(
          Key("btn_select"),
          "Select Training Plan",
          _onClickSelectButton,
        ),
        buttonFlatDefault(
          Key("btn_zones"),
          "Zones",
          _onClickZonesButton,
        ),
      ],
    );
  }

  Column Sensors() {
    return Column(
        children: sensors
            .map((device) => Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 60.0, right: 60.0),
                  child: ColoredBox(
                    color: getColorByState(device.state),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Text(device.type, style: TextStyle(fontSize: 20.0)),
                        Spacer(),
                        Text(device.state, style: TextStyle(fontSize: 10.0)),
                        Spacer(),
                      ],
                    ),
                  ),
                ))
            .toList());
  }

  final stateColorMap = {
    "CONNECTED": Colors.green.withAlpha(70),
    "DISCONNECTED": Colors.red.withAlpha(70),
    "CONNECTING": Colors.yellow.withAlpha(70),
    "DISCONNECTING": Colors.orange.withAlpha(70),
  };

  Color getColorByState(String state) {
    return stateColorMap[state] ?? Colors.red.withAlpha(70);
  }
}

import 'package:flutter/material.dart';
import 'package:trainer/common/model/Sensor.dart';

import 'home_widget.dart';

class SensorWidget extends StatelessWidget {
  Sensor sensor;
  String sensorField = "";
  SensorButtonCallback onClickSensorButton;
  bool isSavedByUser;

  SensorWidget({this.sensor, this.sensorField, this.onClickSensorButton, this.isSavedByUser});

  Icon getIconBySensor() {
    if (sensor.params.sensorType == "HEARTRATE") {
      return Icon(
        Icons.favorite,
        color: Colors.black.withAlpha(150),
        size: 30,
      );
    } else {
      return Icon(
        Icons.memory,
        color: Colors.black.withAlpha(180),
        size: 30,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, left: 50.0, right: 50.0),
      child: Container(
        decoration: new BoxDecoration(
            color: getColorByState(sensor.state),
            borderRadius: new BorderRadius.all(Radius.circular(25.0))),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            getIconBySensor(),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(sensor.params.deviceName, style: TextStyle(fontSize: 15.0)),
                  ],
                ),

              ],
            ),
            Column(
              children: <Widget>[
                Text(sensor.state, style: TextStyle(fontSize: 10.0)),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(sensorField, style: TextStyle(fontSize: 15.0)),
                  ],
                ),
              ],
            ),
            Center(
              child: IconButton(
                icon: this.isSavedByUser ? Icon(Icons.remove_circle) : Icon(Icons.add_box),
                color: Colors.black.withAlpha(150),
                iconSize: 32,
                onPressed: () {
                  onClickSensorButton(sensor.id, this.isSavedByUser);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  final stateColorMap = {
    "CONNECTED": Colors.blue.withAlpha(140),
    "DISCONNECTED": Colors.red.withAlpha(100),
    "CONNECTING": Colors.blue.withAlpha(20),
    "DISCONNECTING": Colors.orange.withAlpha(70),
  };

  Color getColorByState(String state) {
    return stateColorMap[state] ?? Colors.red.withAlpha(70);
  }

}

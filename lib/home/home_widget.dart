import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainer/data/local/preferences_repo.dart';
import 'package:trainer/data/native/SensorChannel.dart';
import 'package:trainer/home/device.dart';
import 'package:trainer/zone/zone_widget.dart';

import '../common/styles.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key) {}

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> {
  var devices = [
    Device(name: "First Device", state: DeviceState.connected),
    Device(name: "Second Device", state: DeviceState.disconnected),
  ];

  Future _onClickDiscoverButton() async {
    var sensorChannel = SensorChannel();
    await sensorChannel.startService();
  }

  void _onClickSelectButton() {}

  void _onClickZonesButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ZoneWidget(
                preferencesRepo: PreferencesRepo(),
              )),
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
            Devices(),
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

  Column Devices() {
    return Column(
        children: devices
            .map((device) => Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 60.0, right: 60.0),
                  child: ColoredBox(
                    color: getColorByState(device.state),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Text(device.name, style: TextStyle(fontSize: 20.0)),
                        Spacer(),
                        Text(getTextByState(device.state), style: TextStyle(fontSize: 15.0)),
                        Spacer(),
                      ],
                    ),
                  ),
                ))
            .toList());
  }

  final stateColorMap = {
    DeviceState.connected: Colors.green.withAlpha(70),
    DeviceState.disconnected: Colors.red.withAlpha(70),
  };

  Color getColorByState(DeviceState state) {
    return stateColorMap[state] ?? Colors.red.withAlpha(70);
  }

  final stateTextMap = {
    DeviceState.connected: "Connected",
    DeviceState.disconnected: 'Disconnected'
  };

  String getTextByState(DeviceState state) {
    return stateTextMap[state] ?? "Unknown";
  }
}
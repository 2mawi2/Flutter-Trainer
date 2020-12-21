import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:trainer/common/model/Sensor.dart';
import 'package:trainer/common/model/SensorData.dart';


class SensorChannel {
  static const channel = const MethodChannel("com.mawistudios.trainer/sensor");

  SensorChannel() {
    _setMethodCallHandlers();
  }

  void _setMethodCallHandlers() {
    channel.setMethodCallHandler((call) async {
      if (call.method == "onSensorConnectionStateChanged" && onSensorConnectionStateChangedHandler != null) {
        var sensor = Sensor.fromJson(jsonDecode(call.arguments));
        onSensorConnectionStateChangedHandler(sensor);
      }
    });

    channel.setMethodCallHandler((call) async {
      if (call.method == "onNewSensorData" && onNewSensorDataHandler != null) {
        var sensorData = SensorData.fromJson(jsonDecode(call.arguments));
        onNewSensorDataHandler(sensorData);
      }
    });
  }

  Future<void> startService() async {
    String status = await channel.invokeMethod("startService");
    print("Invoked startService with result code: $status");
  }

  Function(Sensor sensor) onSensorConnectionStateChangedHandler;
  Function(SensorData sensor) onNewSensorDataHandler;
}

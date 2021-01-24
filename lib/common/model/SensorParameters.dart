import 'dart:convert';

class SensorParameters {
  final String networkType;
  final String sensorType;
  final String deviceName;
  final String bluetoothDevice;

  SensorParameters({this.networkType, this.sensorType, this.deviceName, this.bluetoothDevice});

  SensorParameters.fromJson(Map<String, dynamic> json)
      : networkType = json['networkType'],
        sensorType = json['sensorType'],
        deviceName = json['deviceName'],
        bluetoothDevice = json['bluetoothDevice'];

  Map<String, dynamic> toJson() => {
        'networkType': networkType,
        'sensorType': sensorType,
        'deviceName': deviceName,
        'bluetoothDevice': bluetoothDevice,
      };
}

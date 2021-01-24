import 'dart:convert';

import 'SensorParameters.dart';

class Sensor {
  final String id;
  final String state;
  final String name;
  final SensorParameters params;
  final String type;

  Sensor({this.id, this.state, this.name, this.params, this.type});

  Sensor.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        state = json['state'],
        name = json['name'],
        type = json['type'],
        params = SensorParameters.fromJson(jsonDecode(json['params']));

  Map<String, dynamic> toJson() => {
        'id': id,
        'state': state,
        'name': name,
        'params': params.toJson(),
        'type': type,
      };
}

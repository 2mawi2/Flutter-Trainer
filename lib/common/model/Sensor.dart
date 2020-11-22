class Sensor {
  final int id;
  final String state;
  final String name;
  final String params;

  Sensor({this.id, this.state, this.name, this.params});

  Sensor.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        state = json['state'],
        name = json['name'],
        params = json['params'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'state': state,
        'name': name,
        'params': params,
      };
}

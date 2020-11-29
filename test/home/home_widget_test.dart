import 'package:test/test.dart';
import 'package:trainer/common/model/Sensor.dart';
import 'package:trainer/home/home_widget.dart';
import 'package:trainer/zone/zone_helper.dart';

void main() {
  test("updateOrAddSensors should add sensor when it did not exist", () {
    var sensors = [
      Sensor(name: "name", state: "state", params: "params"),
      Sensor(name: "name2", state: "state2", params: "params3"),
    ];
    var newSensor = Sensor(name: "name3", state: "state", params: "params");

    HomeWidget().createState().updateOrAddSensor(sensors, newSensor);

    expect(sensors.length, equals(3));
    expect(sensors.any((it) => it.name == "name3"), equals(true));
  });

  test("updateOrAddSensors should update sensor if it did exist", () {
    var sensors = [
      Sensor(name: "sensor1", state: "state", params: "params"),
      Sensor(name: "sensor2", state: "state2", params: "params3"),
    ];
    var newSensor = Sensor(name: "sensor2", state: "stateUpdated", params: "paramsUpdated");

    HomeWidget().createState().updateOrAddSensor(sensors, newSensor);

    expect(sensors.length, equals(2));
    var sensor2 = sensors.singleWhere((it) => it.name =="sensor2");
    expect(sensor2.state, equals("stateUpdated"));
    expect(sensor2.params, equals("paramsUpdated"));
  });
}

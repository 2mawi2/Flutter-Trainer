enum DeviceState { connected, disconnected }

class Device {
  final String name;
  final DeviceState state;

  Device({this.name, this.state});
}

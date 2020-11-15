class Zone {
  final int index;
  final String name;
  final double min;
  final double max;

  Zone({this.index, this.name, this.min, this.max});

  String getFormattedZones() {
    return "${this.min.toStringAsFixed(0)} - ${this.max.toStringAsFixed(0)}";
  }
}

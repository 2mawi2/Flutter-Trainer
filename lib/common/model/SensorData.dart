class SensorData {
  final String sensorId;
  final String time;

  //  HEARTHRATE_BPM,
  //  WHEELREVS_KMH,
  //  WHEELREVS_DISTANCE,
  //  CRANKREVS_CADENCE,
  //  POWER_WATT
  final String dataPointType;
  final double dataPoint;

  SensorData({this.sensorId, this.time, this.dataPointType, this.dataPoint});

  SensorData.fromJson(Map<String, dynamic> json)
      : sensorId = json['sensorId'],
        time = json['time'],
        dataPointType = json['dataPointType'],
        dataPoint = json['dataPoint'];

  Map<String, dynamic> toJson() => {
        'sensorId': sensorId,
        'time': time,
        'dataPointType': dataPointType,
        'dataPoint': dataPoint
      };

  String getUnit() {
    switch (this.dataPointType) {
      case "HEARTHRATE_BPM":
        return "bpm";
      case "CRANKREVS_CADENCE":
        return "rpm";
      default:
        return "";
    }
  }

  String getDefaultLabel() {
    var unit = this.getUnit();
    var truncatedDataPoint = this.dataPoint.truncate().toString();
    return "$truncatedDataPoint $unit";
  }
}

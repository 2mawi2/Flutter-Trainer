class SensorData {
  final DateTime time;
  //  HEARTHRATE_BPM,
  //  WHEELREVS_KMH,
  //  WHEELREVS_DISTANCE,
  //  CRANKREVS_CADENCE,
  //  POWER_WATT
  final String dataPointType;
  final String dataPoint;

  SensorData({this.time, this.dataPointType, this.dataPoint});

  SensorData.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        dataPointType = json['dataPointType'],
        dataPoint = json['dataPoint'];

  Map<String, dynamic> toJson() =>
      {
        'time': time,
        'dataPointType': dataPointType,
        'dataPoint': dataPoint
      };
}

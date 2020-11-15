import 'zone.dart';

List<Zone> getZones(int ftp) {
  var difference = 0.0000001;
  return [
    Zone(
      index: 1,
      name: "ACTIVE RECOVERY",
      min: ftp * 0.0,
      max: ftp * 0.56 - difference,
    ),
    Zone(
      index: 2,
      name: "ENDURANCE",
      min: ftp * 0.56,
      max: ftp * 0.76 - difference,
    ),
    Zone(
      index: 3,
      name: "TEMPO",
      min: ftp * 0.76,
      max: ftp * 0.91 - difference,
    ),
    Zone(
      index: 4,
      name: "LACTATE THRESHOLD",
      min: ftp * 0.91,
      max: ftp * 1.06 - difference,
    ),
    Zone(
      index: 5,
      name: "VO2 MAX",
      min: ftp * 1.06,
      max: ftp * 1.21 - difference,
    ),
    Zone(
      index: 6,
      name: "ANAEROBIC CAPACITY",
      min: ftp * 1.21,
      max: ftp * 1.5,
    ),
  ];
}

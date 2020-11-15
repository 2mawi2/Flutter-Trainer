import 'package:test/test.dart';
import 'package:trainer/zone/zone_helper.dart';

void main() {
  test("should return 6 zones", () {
    var ftp = 200;
    var result = getZones(ftp);
    expect(result.length, equals(6));
  });

  test("should calculate a difference in between each min and max", () {
    var ftp = 200;
    var result = getZones(ftp);
    expect(result[0].max, isNot(result[1].min));
    expect(result[1].max, isNot(result[2].min));
    expect(result[3].max, isNot(result[4].min));
  });
}

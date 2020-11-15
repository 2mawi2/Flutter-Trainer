import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trainer/zone/zone_widget.dart';

import '../test_utils.dart';

void main() {
  testWidgets(
    'zone widget should have calculate button',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(ZoneWidget()));

      expect(find.byKey(Key("btn_calculate")), findsOneWidget);
    },
  );

  testWidgets(
    'when calculate button is pressed but invalid ftp is set an error is shown',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(ZoneWidget()));
      var invalidFtp = "";

      await simulateFtpEntered(tester, invalidFtp);

      expect(find.text("Please enter a valid FTP"), findsOneWidget);
    },
  );

  testWidgets(
    'when calculate button is pressed and valid ftp is set no error is shown',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(ZoneWidget()));
      var validFtp = "100";

      await simulateFtpEntered(tester, validFtp);

      expect(find.text("Please enter a valid FTP"), findsNothing);
    },
  );

  testWidgets(
    'when calculate button is pressed and valid ftp zones are recalculated',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(ZoneWidget()));
      await simulateFtpEntered(tester, "100");
      var zonesBefore = findDisplayedZones();

      await simulateFtpEntered(tester, "200");

      var zonesAfter = findDisplayedZones();
      zonesAfter.forEach((zoneAfter) {
        expect(zonesBefore.contains(zoneAfter), isFalse);
      });
    },
  );
}

Future simulateFtpEntered(WidgetTester tester, String ftp) async {
  await tester.enterText(find.byKey(Key("inp_ftp")), ftp);
  await tester.tap(find.byKey(Key("btn_calculate")));
  await tester.pump();
}

Iterable<String> findDisplayedZones() {
  return find
      .byKey(Key("txt_zone_value"))
      .evaluate()
      .map((e) => (e.widget as Text).data)
      .toList();
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trainer/home/home_widget.dart';

import '../test_utils.dart';

void main() {
  testWidgets(
    'home widget should have discover select and zones button',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(HomeWidget()));

      expect(find.byKey(Key("btn_discover")), findsOneWidget);
      expect(find.byKey(Key("btn_select")), findsOneWidget);
      expect(find.byKey(Key("btn_zones")), findsOneWidget);
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trainer/app.dart';

void main() {
  testWidgets(
    'home widget should have three buttons',
    (WidgetTester tester) async {
      await tester.pumpWidget(TrainerApp());
      final buttons = find.byType(FlatButton).evaluate();
      expect(buttons.length, equals(3));
    },
  );
}

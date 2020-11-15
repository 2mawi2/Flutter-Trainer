import 'package:flutter_test/flutter_test.dart';
import 'package:trainer/app.dart';

void main() {
  testWidgets('trainer widget should load', (WidgetTester tester) async {
    await tester.pumpWidget(TrainerApp());
    expect(find.text("Trainer"), findsOneWidget);
  });
}

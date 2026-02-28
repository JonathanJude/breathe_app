import 'package:breathe_app/app/box_breathing_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders setup screen', (WidgetTester tester) async {
    await tester.pumpWidget(const BoxBreathingApp());
    await tester.pumpAndSettle();

    expect(find.text('Set your breathing pace'), findsOneWidget);
    expect(find.text('Start breathing'), findsOneWidget);
  });
}

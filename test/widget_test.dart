import 'package:breathe_app/app/box_breathing_app.dart';
import 'package:breathe_app/core/di/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('renders setup screen', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await setupServiceLocator(useStubAudio: true);

    await tester.pumpWidget(const BoxBreathingApp());
    await tester.pumpAndSettle();

    expect(find.text('Set your breathing pace'), findsOneWidget);
    expect(find.text('Start breathing'), findsOneWidget);
  });
}

import 'package:breathe_app/app/box_breathing_app.dart';
import 'package:breathe_app/core/di/service_locator.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const BoxBreathingApp());
}

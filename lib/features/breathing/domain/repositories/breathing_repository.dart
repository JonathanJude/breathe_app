import 'package:breathe_app/features/breathing/domain/entities/breathing_settings.dart';
import 'package:breathe_app/features/breathing/domain/entities/last_session_state.dart';

abstract interface class BreathingRepository {
  Future<BreathingSettings> loadSettings();

  Future<void> saveSettings(BreathingSettings settings);

  Future<LastSessionState?> loadLastSessionState();

  Future<void> saveLastSessionState(LastSessionState state);

  Future<void> clearLastSessionState();
}

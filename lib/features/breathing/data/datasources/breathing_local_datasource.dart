import 'package:breathe_app/core/persistence/keys.dart';
import 'package:breathe_app/core/persistence/persistence.dart';
import 'package:breathe_app/features/breathing/data/models/breathing_settings_model.dart';
import 'package:breathe_app/features/breathing/data/models/last_session_state_model.dart';
import 'package:breathe_app/features/breathing/domain/entities/breathing_settings.dart';

abstract interface class BreathingLocalDataSource {
  Future<BreathingSettingsModel> loadSettings();

  Future<void> saveSettings(BreathingSettingsModel model);

  Future<LastSessionStateModel?> loadLastSession();

  Future<void> saveLastSession(LastSessionStateModel model);

  Future<void> clearLastSession();
}

class BreathingLocalDataSourceImpl implements BreathingLocalDataSource {
  const BreathingLocalDataSourceImpl(this._persistence);

  final Persistence _persistence;

  @override
  Future<void> clearLastSession() => _persistence.remove(AppPersistenceKeys.lastSessionState);

  @override
  Future<LastSessionStateModel?> loadLastSession() async {
    final json = _persistence.readJson(AppPersistenceKeys.lastSessionState);
    if (json == null) {
      return null;
    }

    final model = LastSessionStateModel.fromJson(json);
    if (model.elapsedSessionSeconds >= model.totalSessionSeconds || model.phaseDurationSeconds <= 0) {
      return null;
    }

    return model;
  }

  @override
  Future<BreathingSettingsModel> loadSettings() async {
    final json = _persistence.readJson(AppPersistenceKeys.breathingSettings);
    if (json == null) {
      return BreathingSettingsModel.fromEntity(BreathingSettings.defaults);
    }

    return BreathingSettingsModel.fromJson(json);
  }

  @override
  Future<void> saveLastSession(LastSessionStateModel model) {
    return _persistence.writeJson(AppPersistenceKeys.lastSessionState, model.toJson());
  }

  @override
  Future<void> saveSettings(BreathingSettingsModel model) {
    return _persistence.writeJson(AppPersistenceKeys.breathingSettings, model.toJson());
  }
}

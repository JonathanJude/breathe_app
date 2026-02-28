import 'package:breathe_app/features/breathing/data/datasources/breathing_local_datasource.dart';
import 'package:breathe_app/features/breathing/data/models/breathing_settings_model.dart';
import 'package:breathe_app/features/breathing/data/models/last_session_state_model.dart';
import 'package:breathe_app/features/breathing/domain/entities/breathing_settings.dart';
import 'package:breathe_app/features/breathing/domain/entities/last_session_state.dart';
import 'package:breathe_app/features/breathing/domain/repositories/breathing_repository.dart';

class BreathingRepositoryImpl implements BreathingRepository {
  const BreathingRepositoryImpl(this._localDataSource);

  final BreathingLocalDataSource _localDataSource;

  @override
  Future<void> clearLastSessionState() => _localDataSource.clearLastSession();

  @override
  Future<LastSessionState?> loadLastSessionState() async {
    final model = await _localDataSource.loadLastSession();
    return model?.toEntity();
  }

  @override
  Future<BreathingSettings> loadSettings() async {
    final model = await _localDataSource.loadSettings();
    return model.toEntity();
  }

  @override
  Future<void> saveLastSessionState(LastSessionState state) {
    return _localDataSource.saveLastSession(LastSessionStateModel.fromEntity(state));
  }

  @override
  Future<void> saveSettings(BreathingSettings settings) {
    return _localDataSource.saveSettings(BreathingSettingsModel.fromEntity(settings));
  }
}

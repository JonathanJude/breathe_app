import 'package:breathe_app/features/breathing/domain/entities/breathing_settings.dart';
import 'package:breathe_app/features/breathing/domain/repositories/breathing_repository.dart';

class SaveSettingsUseCase {
  const SaveSettingsUseCase(this._repository);

  final BreathingRepository _repository;

  Future<void> call(BreathingSettings settings) => _repository.saveSettings(settings);
}

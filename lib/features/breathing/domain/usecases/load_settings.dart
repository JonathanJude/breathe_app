import 'package:breathe_app/features/breathing/domain/entities/breathing_settings.dart';
import 'package:breathe_app/features/breathing/domain/repositories/breathing_repository.dart';

class LoadSettingsUseCase {
  const LoadSettingsUseCase(this._repository);

  final BreathingRepository _repository;

  Future<BreathingSettings> call() => _repository.loadSettings();
}

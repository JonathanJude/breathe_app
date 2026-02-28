import 'package:breathe_app/features/breathing/domain/entities/last_session_state.dart';
import 'package:breathe_app/features/breathing/domain/repositories/breathing_repository.dart';

class LoadLastSessionUseCase {
  const LoadLastSessionUseCase(this._repository);

  final BreathingRepository _repository;

  Future<LastSessionState?> call() => _repository.loadLastSessionState();
}

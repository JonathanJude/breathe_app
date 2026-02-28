import 'package:breathe_app/features/breathing/domain/entities/last_session_state.dart';
import 'package:breathe_app/features/breathing/domain/repositories/breathing_repository.dart';

class SaveLastSessionUseCase {
  const SaveLastSessionUseCase(this._repository);

  final BreathingRepository _repository;

  Future<void> call(LastSessionState state) => _repository.saveLastSessionState(state);
}

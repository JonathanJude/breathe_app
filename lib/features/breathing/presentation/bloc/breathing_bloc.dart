import 'dart:async';

import 'package:breathe_app/core/audio/audio_player.dart';
import 'package:breathe_app/core/theme/app_durations.dart';
import 'package:breathe_app/features/breathing/domain/entities/breathing_phase.dart';
import 'package:breathe_app/features/breathing/domain/entities/breathing_settings.dart';
import 'package:breathe_app/features/breathing/domain/entities/last_session_state.dart';
import 'package:breathe_app/features/breathing/domain/repositories/breathing_repository.dart';
import 'package:breathe_app/features/breathing/domain/usecases/load_last_session.dart';
import 'package:breathe_app/features/breathing/domain/usecases/load_settings.dart';
import 'package:breathe_app/features/breathing/domain/usecases/save_last_session.dart';
import 'package:breathe_app/features/breathing/domain/usecases/save_settings.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef _AdvanceResult = ({BreathingSessionSnapshot snapshot, bool phaseChanged, bool isCompleted});

class BreathingBloc extends Bloc<BreathingEvent, BreathingState> {
  BreathingBloc({
    required LoadSettingsUseCase loadSettingsUseCase,
    required SaveSettingsUseCase saveSettingsUseCase,
    required LoadLastSessionUseCase loadLastSessionUseCase,
    required SaveLastSessionUseCase saveLastSessionUseCase,
    required BreathingRepository breathingRepository,
    required AppAudioPlayer audioPlayer,
  }) : _loadSettingsUseCase = loadSettingsUseCase,
       _saveSettingsUseCase = saveSettingsUseCase,
       _loadLastSessionUseCase = loadLastSessionUseCase,
       _saveLastSessionUseCase = saveLastSessionUseCase,
       _breathingRepository = breathingRepository,
       _audioPlayer = audioPlayer,
       super(const BreathingInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateSetting>(_onUpdateSetting);
    on<StartSession>(_onStartSession);
    on<Pause>(_onPause);
    on<Resume>(_onResume);
    on<Cancel>(_onCancel);
    on<Complete>(_onComplete);
    on<_Tick>(_onTick);
  }

  static const int _getReadySeconds = 3;

  final LoadSettingsUseCase _loadSettingsUseCase;
  final SaveSettingsUseCase _saveSettingsUseCase;
  final LoadLastSessionUseCase _loadLastSessionUseCase;
  final SaveLastSessionUseCase _saveLastSessionUseCase;
  final BreathingRepository _breathingRepository;
  final AppAudioPlayer _audioPlayer;

  StreamSubscription<int>? _tickerSubscription;

  Future<void> _onLoadSettings(LoadSettings event, Emitter<BreathingState> emit) async {
    emit(const BreathingLoading());
    final settings = await _loadSettingsUseCase();
    final lastSession = await _loadLastSessionUseCase();
    emit(BreathingReady(settings: settings, lastSessionState: lastSession));
  }

  Future<void> _onUpdateSetting(UpdateSetting event, Emitter<BreathingState> emit) async {
    final updated = state.settings.copyWith(
      breathDurationSeconds: event.breathDurationSeconds,
      rounds: event.rounds,
      advancedTimingEnabled: event.advancedTimingEnabled,
      inhaleSeconds: event.inhaleSeconds,
      holdInSeconds: event.holdInSeconds,
      exhaleSeconds: event.exhaleSeconds,
      holdOutSeconds: event.holdOutSeconds,
      soundEnabled: event.soundEnabled,
    );

    await _saveSettingsUseCase(updated);
    final lastSessionState = state is BreathingReady ? (state as BreathingReady).lastSessionState : null;
    emit(BreathingReady(settings: updated, lastSessionState: lastSessionState));
  }

  Future<void> _onStartSession(StartSession event, Emitter<BreathingState> emit) async {
    _cancelTicker();
    final settings = state.settings;

    await _audioPlayer.preload();
    await _breathingRepository.clearLastSessionState();

    emit(BreathingPreparing(settings: settings, remainingSeconds: _getReadySeconds));
    _startTicker();
  }

  Future<void> _onPause(Pause event, Emitter<BreathingState> emit) async {
    final snapshot = state.session;
    if (snapshot == null) {
      return;
    }

    _cancelTicker();
    emit(_pausedState(snapshot));
    await _persistSnapshot(snapshot, isPaused: true);
  }

  Future<void> _onResume(Resume event, Emitter<BreathingState> emit) async {
    final snapshot = state.session;
    if (snapshot == null) {
      return;
    }

    emit(_runningState(snapshot));
    await _persistSnapshot(snapshot, isPaused: false);
    _startTicker();
  }

  Future<void> _onCancel(Cancel event, Emitter<BreathingState> emit) async {
    _cancelTicker();
    await _breathingRepository.clearLastSessionState();
    emit(BreathingReady(settings: state.settings));
  }

  Future<void> _onComplete(Complete event, Emitter<BreathingState> emit) async {
    _cancelTicker();
    await _breathingRepository.clearLastSessionState();
    emit(
      BreathingCompleted(
        settings: state.settings,
        completedRounds: state.settings.rounds,
        totalSessionSeconds: state.settings.totalSessionSeconds,
      ),
    );
  }

  Future<void> _onTick(_Tick event, Emitter<BreathingState> emit) async {
    if (state case BreathingPreparing(:final settings, :final remainingSeconds)) {
      if (remainingSeconds > 1) {
        emit(BreathingPreparing(settings: settings, remainingSeconds: remainingSeconds - 1));
        return;
      }

      await _startActiveSession(emit, settings);
      return;
    }

    if (state is! BreathingRunning) {
      return;
    }

    final current = state.session;
    if (current == null) {
      return;
    }

    final advanced = _advanceSnapshot(current);
    if (advanced.isCompleted) {
      add(const Complete());
      return;
    }

    emit(_runningState(advanced.snapshot));
    await _persistSnapshot(advanced.snapshot, isPaused: false);

    if (advanced.phaseChanged) {
      await _playPhaseTransitionChime(advanced.snapshot.settings);
    }
  }

  Future<void> _startActiveSession(Emitter<BreathingState> emit, BreathingSettings settings) async {
    final snapshot = _startSnapshot(settings);
    emit(_runningState(snapshot));
    await _persistSnapshot(snapshot, isPaused: false);
    await _playPhaseTransitionChime(settings);
  }

  BreathingSessionSnapshot _startSnapshot(BreathingSettings settings) {
    const phase = BreathingPhase.inhale;
    return BreathingSessionSnapshot(
      settings: settings,
      currentRound: 1,
      totalRounds: settings.rounds,
      currentPhase: phase,
      secondInPhase: 1,
      phaseDurationSeconds: settings.phaseSeconds(phase),
      elapsedSessionSeconds: 0,
      totalSessionSeconds: settings.totalSessionSeconds,
    );
  }

  _AdvanceResult _advanceSnapshot(BreathingSessionSnapshot current) {
    final elapsedSessionSeconds = current.elapsedSessionSeconds + 1;
    if (elapsedSessionSeconds >= current.totalSessionSeconds) {
      return (snapshot: current, phaseChanged: false, isCompleted: true);
    }

    if (current.secondInPhase < current.phaseDurationSeconds) {
      return (
        snapshot: BreathingSessionSnapshot(
          settings: current.settings,
          currentRound: current.currentRound,
          totalRounds: current.totalRounds,
          currentPhase: current.currentPhase,
          secondInPhase: current.secondInPhase + 1,
          phaseDurationSeconds: current.phaseDurationSeconds,
          elapsedSessionSeconds: elapsedSessionSeconds,
          totalSessionSeconds: current.totalSessionSeconds,
        ),
        phaseChanged: false,
        isCompleted: false,
      );
    }

    final nextPhase = current.currentPhase.next();
    final nextRound =
        current.currentPhase == BreathingPhase.holdOut ? current.currentRound + 1 : current.currentRound;
    if (nextRound > current.totalRounds) {
      return (snapshot: current, phaseChanged: false, isCompleted: true);
    }

    return (
      snapshot: BreathingSessionSnapshot(
        settings: current.settings,
        currentRound: nextRound,
        totalRounds: current.totalRounds,
        currentPhase: nextPhase,
        secondInPhase: 1,
        phaseDurationSeconds: current.settings.phaseSeconds(nextPhase),
        elapsedSessionSeconds: elapsedSessionSeconds,
        totalSessionSeconds: current.totalSessionSeconds,
      ),
      phaseChanged: true,
      isCompleted: false,
    );
  }

  BreathingRunning _runningState(BreathingSessionSnapshot snapshot) {
    return BreathingRunning(
      settings: snapshot.settings,
      currentRound: snapshot.currentRound,
      totalRounds: snapshot.totalRounds,
      currentPhase: snapshot.currentPhase,
      secondInPhase: snapshot.secondInPhase,
      phaseDurationSeconds: snapshot.phaseDurationSeconds,
      elapsedSessionSeconds: snapshot.elapsedSessionSeconds,
      totalSessionSeconds: snapshot.totalSessionSeconds,
    );
  }

  BreathingPaused _pausedState(BreathingSessionSnapshot snapshot) {
    return BreathingPaused(
      settings: snapshot.settings,
      currentRound: snapshot.currentRound,
      totalRounds: snapshot.totalRounds,
      currentPhase: snapshot.currentPhase,
      secondInPhase: snapshot.secondInPhase,
      phaseDurationSeconds: snapshot.phaseDurationSeconds,
      elapsedSessionSeconds: snapshot.elapsedSessionSeconds,
      totalSessionSeconds: snapshot.totalSessionSeconds,
    );
  }

  Future<void> _persistSnapshot(
    BreathingSessionSnapshot snapshot, {
    required bool isPaused,
  }) {
    return _saveLastSessionUseCase(
      LastSessionState(
        currentRound: snapshot.currentRound,
        totalRounds: snapshot.totalRounds,
        currentPhase: snapshot.currentPhase,
        secondInPhase: snapshot.secondInPhase,
        phaseDurationSeconds: snapshot.phaseDurationSeconds,
        elapsedSessionSeconds: snapshot.elapsedSessionSeconds,
        totalSessionSeconds: snapshot.totalSessionSeconds,
        isPaused: isPaused,
        updatedAtEpochMillis: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> _playPhaseTransitionChime(BreathingSettings settings) async {
    if (settings.soundEnabled) {
      await _audioPlayer.playChime();
    }
  }

  void _startTicker() {
    _cancelTicker();
    _tickerSubscription = Stream<int>.periodic(AppDurations.sessionTick, (value) => value).listen((_) {
      add(const _Tick());
    });
  }

  void _cancelTicker() {
    _tickerSubscription?.cancel();
    _tickerSubscription = null;
  }

  @override
  Future<void> close() async {
    _cancelTicker();
    await _audioPlayer.dispose();
    await super.close();
  }
}

class _Tick extends BreathingEvent {
  const _Tick();
}

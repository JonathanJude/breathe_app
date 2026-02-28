import 'package:breathe_app/app/router/app_router.dart';
import 'package:breathe_app/core/audio/audio_player.dart';
import 'package:breathe_app/core/audio/just_audio_player.dart';
import 'package:breathe_app/core/audio/stub_audio_player.dart';
import 'package:breathe_app/core/persistence/persistence.dart';
import 'package:breathe_app/core/persistence/shared_prefs_persistence.dart';
import 'package:breathe_app/core/theme/theme_cubit.dart';
import 'package:breathe_app/features/breathing/data/datasources/breathing_local_datasource.dart';
import 'package:breathe_app/features/breathing/data/repositories/breathing_repository_impl.dart';
import 'package:breathe_app/features/breathing/domain/repositories/breathing_repository.dart';
import 'package:breathe_app/features/breathing/domain/usecases/load_last_session.dart';
import 'package:breathe_app/features/breathing/domain/usecases/load_settings.dart';
import 'package:breathe_app/features/breathing/domain/usecases/save_last_session.dart';
import 'package:breathe_app/features/breathing/domain/usecases/save_settings.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator({bool useStubAudio = false}) async {
  if (sl.isRegistered<SharedPreferences>()) {
    return;
  }

  final sharedPreferences = await SharedPreferences.getInstance();

  sl
    ..registerSingleton<SharedPreferences>(sharedPreferences)
    ..registerLazySingleton<Persistence>(
      () => SharedPrefsPersistence(sl<SharedPreferences>()),
    )
    ..registerLazySingleton<AppAudioPlayer>(
      useStubAudio ? StubAudioPlayer.new : AppJustAudioPlayer.new,
    )
    ..registerLazySingleton<BreathingLocalDataSource>(
      () => BreathingLocalDataSourceImpl(sl<Persistence>()),
    )
    ..registerLazySingleton<BreathingRepository>(
      () => BreathingRepositoryImpl(sl<BreathingLocalDataSource>()),
    )
    ..registerLazySingleton<LoadSettingsUseCase>(
      () => LoadSettingsUseCase(sl<BreathingRepository>()),
    )
    ..registerLazySingleton<SaveSettingsUseCase>(
      () => SaveSettingsUseCase(sl<BreathingRepository>()),
    )
    ..registerLazySingleton<LoadLastSessionUseCase>(
      () => LoadLastSessionUseCase(sl<BreathingRepository>()),
    )
    ..registerLazySingleton<SaveLastSessionUseCase>(
      () => SaveLastSessionUseCase(sl<BreathingRepository>()),
    )
    ..registerFactory<ThemeCubit>(() => ThemeCubit(sl<Persistence>()))
    ..registerFactory<BreathingBloc>(
      () => BreathingBloc(
        loadSettingsUseCase: sl<LoadSettingsUseCase>(),
        saveSettingsUseCase: sl<SaveSettingsUseCase>(),
        loadLastSessionUseCase: sl<LoadLastSessionUseCase>(),
        saveLastSessionUseCase: sl<SaveLastSessionUseCase>(),
        breathingRepository: sl<BreathingRepository>(),
        audioPlayer: sl<AppAudioPlayer>(),
      ),
    )
    ..registerLazySingleton<GoRouter>(AppRouter.create);
}

Future<void> resetServiceLocator() async {
  await sl.reset();
}

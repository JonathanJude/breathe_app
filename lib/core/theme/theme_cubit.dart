import 'package:breathe_app/core/persistence/keys.dart';
import 'package:breathe_app/core/persistence/persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._persistence) : super(ThemeMode.system);

  final Persistence _persistence;

  Future<void> loadThemeMode() async {
    final persisted = _persistence.readString(AppPersistenceKeys.themeMode);
    emit(_fromStorage(persisted));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(mode);
    await _persistence.writeString(AppPersistenceKeys.themeMode, mode.name);
  }

  Future<void> toggleTheme() {
    return setThemeMode(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  ThemeMode _fromStorage(String? value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}

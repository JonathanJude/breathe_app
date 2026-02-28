import 'package:breathe_app/features/finish/finish_page.dart';
import 'package:breathe_app/features/session/session_page.dart';
import 'package:breathe_app/features/setup/setup_page.dart';
import 'package:breathe_app/core/theme/app_theme.dart';
import 'package:breathe_app/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoxBreathingApp extends StatelessWidget {
  const BoxBreathingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Box Breathing App',
            themeMode: themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            home: const SetupPage(),
            onGenerateRoute: (settings) {
              return switch (settings.name) {
                SessionPage.routeName => MaterialPageRoute<void>(
                  builder: (_) => const SessionPage(),
                ),
                FinishPage.routeName => MaterialPageRoute<void>(
                  builder: (_) => const FinishPage(),
                ),
                _ => MaterialPageRoute<void>(builder: (_) => const SetupPage()),
              };
            },
          );
        },
      ),
    );
  }
}

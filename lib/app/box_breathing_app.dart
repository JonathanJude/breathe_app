import 'package:breathe_app/core/di/service_locator.dart';
import 'package:breathe_app/core/theme/app_theme.dart';
import 'package:breathe_app/core/theme/theme_cubit.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BoxBreathingApp extends StatelessWidget {
  const BoxBreathingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = sl<GoRouter>();

    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemeCubit>(
          lazy: false,
          create: (_) => sl<ThemeCubit>()..loadThemeMode(),
        ),
        BlocProvider<BreathingBloc>(
          lazy: false,
          create: (_) => sl<BreathingBloc>()..add(const LoadSettings()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Box Breathing App',
            themeMode: themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            routerConfig: router,
          );
        },
      ),
    );
  }
}

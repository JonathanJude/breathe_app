import 'package:breathe_app/app/router/app_router.dart';
import 'package:breathe_app/core/widgets/app_scaffold.dart';
import 'package:breathe_app/core/widgets/page_top_controls.dart';
import 'package:breathe_app/core/widgets/primary_button.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathe_app/features/breathing/presentation/widgets/app_pallete.dart';
import 'package:breathe_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class FinishPage extends StatelessWidget {
  static const String routeName = '/finish';

  const FinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.sizeOf(context).width >= 900;
    final palette = context.appPallete;

    return AppScaffold(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isWeb ? 24 : 16,
          isWeb ? 10 : 8,
          isWeb ? 24 : 16,
          18,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWeb ? 420 : 360),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                PageTopControls(
                  showLeading: true,
                  padding: EdgeInsets.zero,
                  onLeadingTap: () {
                    context.go(AppRoutes.setup);
                  },
                ),
                SizedBox(height: isWeb ? 24 : 34),
                Assets.lottie.checkmark.lottie(
                  width: 120,
                  height: 120,
                  repeat: false,
                  decoder: (bytes) => LottieComposition.decodeZip(
                    bytes,
                    filePicker: (files) {
                      try {
                        return files.firstWhere(
                          (f) =>
                              f.name.startsWith('animations/') &&
                              f.name.endsWith('.json'),
                        );
                      } catch (_) {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'You did it! 🎉',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Great rounds of calm, just like that.\nYour mind thanks you.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: PrimaryButton(
                    label: "Start again",
                    trailingIcon: Assets.icons.svg.fastWind.svg(),
                    onPressed: () {
                      context.read<BreathingBloc>().add(const StartSession());
                      context.go(AppRoutes.session);
                    },
                  ),
                ),
                const SizedBox(height: 14),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: PrimaryButton(
                    label: "Back to set up",
                    isExpanded: false,
                    backgroundColor: palette.backToSetupBgColor,
                    onPressed: () => context.go(AppRoutes.setup),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

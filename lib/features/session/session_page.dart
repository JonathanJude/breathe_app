import 'package:breathe_app/core/widgets/page_top_controls.dart';
import 'package:breathe_app/core/widgets/scene_scaffold.dart';
import 'package:breathe_app/features/finish/finish_page.dart';
import 'package:breathe_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class SessionPage extends StatelessWidget {
  static const String routeName = '/session';

  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWeb = MediaQuery.sizeOf(context).width >= 900;

    final bubbleSize = isWeb ? 168.0 : 372.0;

    return SceneScaffold(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isWeb ? 24 : 16,
          isWeb ? 10 : 8,
          isWeb ? 24 : 16,
          18,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWeb ? 560 : 430),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                PageTopControls(showLeading: true, padding: EdgeInsets.zero),
                SizedBox(height: isWeb ? 20 : 28),
                Container(
                  width: bubbleSize,
                  height: bubbleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkBubbleBorder
                          : AppColors.lightBubbleBorder,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDark
                          ? const <Color>[
                              AppColors.darkBubbleStart,
                              AppColors.darkBubbleEnd,
                            ]
                          : const <Color>[
                              AppColors.lightBubbleStart,
                              AppColors.lightBubbleEnd,
                            ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '2',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: isWeb ? 50 : 66,
                          color: isDark ? Colors.white : AppColors.textLight,
                        ),
                      ),
                      if (isDark || isWeb)
                        Text(
                          'sec',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(fontSize: isWeb ? 14 : 20),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: isWeb ? 40 : 74),
                Text(
                  'Get ready',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: isWeb ? 56 : 68,
                    color: isDark ? Colors.white : AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Get going on your breathing session',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: isWeb ? 34 : 46),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(FinishPage.routeName);
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

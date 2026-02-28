import 'package:breathe_app/core/widgets/page_top_controls.dart';
import 'package:breathe_app/core/widgets/scene_scaffold.dart';
import 'package:breathe_app/features/session/session_page.dart';
import 'package:flutter/material.dart';

class FinishPage extends StatelessWidget {
  static const String routeName = '/finish';

  const FinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.sizeOf(context).width >= 900;

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
            constraints: BoxConstraints(maxWidth: isWeb ? 420 : 360),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                PageTopControls(showLeading: true, padding: EdgeInsets.zero),
                SizedBox(height: isWeb ? 24 : 34),
                const Icon(
                  Icons.check_circle,
                  size: 88,
                  color: Color(0xFF2AB64A),
                ),
                const SizedBox(height: 20),
                Text(
                  'You did it!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Great rounds of calm, just like that.\nYour mind thanks you.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushNamed(SessionPage.routeName);
                  },
                  child: const Text('Start again'),
                ),
                const SizedBox(height: 14),
                FilledButton(
                  onPressed: () =>
                      Navigator.of(context).popUntil((r) => r.isFirst),
                  child: const Text('Back to setup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

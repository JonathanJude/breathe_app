import 'package:breathe_app/core/theme/app_durations.dart';
import 'package:breathe_app/core/widgets/primary_button.dart';
import 'package:breathe_app/gen/assets.gen.dart';
import 'package:breathe_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class BreathingGetReadyContent extends StatelessWidget {
  const BreathingGetReadyContent({required this.remainingSeconds, super.key});

  final int remainingSeconds;

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.sizeOf(context).width >= 900;
    return Column(
      key: const ValueKey<String>('get-ready'),
      children: <Widget>[
        SizedBox(height: isWeb ? 20 : 28),
        SessionBubble(
          scale: 0.82,
          label: remainingSeconds.toString(),
          isWeb: isWeb,
        ),
        SizedBox(height: isWeb ? 40 : 74),
        Text(
          'Get ready',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: isWeb ? 32 : 24,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : AppColors.textLight,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Get going on your breathing session',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontSize: isWeb ? 18 : 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class BreathingActiveSessionContent extends StatelessWidget {
  const BreathingActiveSessionContent({
    required this.phaseAnimationKey,
    required this.bubbleStartScale,
    required this.bubbleEndScale,
    required this.bubbleAnimationDuration,
    required this.bubbleLabel,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.cycleLabel,
    required this.pauseLabel,
    required this.isWeb,
    required this.onPauseToggle,
    required this.isPaused,
    super.key,
  });

  final String phaseAnimationKey;
  final double bubbleStartScale;
  final double bubbleEndScale;
  final Duration bubbleAnimationDuration;
  final String? bubbleLabel;
  final String title;
  final String subtitle;
  final double progress;
  final String cycleLabel;
  final String pauseLabel;
  final bool isWeb;
  final VoidCallback onPauseToggle;
  final bool isPaused;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      key: ValueKey<String>('active-$phaseAnimationKey'),
      children: <Widget>[
        SizedBox(height: isWeb ? 8 : 10),
        Text(
          "You're a natural",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: isWeb ? 16 : 12,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isWeb ? 20 : 10),
        TweenAnimationBuilder<double>(
          key: ValueKey<String>(phaseAnimationKey),
          tween: Tween<double>(begin: bubbleStartScale, end: bubbleEndScale),
          duration: bubbleAnimationDuration,
          curve: Curves.linear,
          builder: (context, scale, child) {
            return SessionBubble(
              scale: scale,
              label: bubbleLabel,
              isWeb: isWeb,
            );
          },
        ),
        SizedBox(height: isWeb ? 40 : 74),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: isWeb ? 32 : 24,
            color: isDark ? Colors.white : AppColors.textLight,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontSize: isWeb ? 18 : 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isWeb ? 28 : 32),
        AnimatedSessionProgressBar(progress: progress),
        const SizedBox(height: 8),
        Text(
          cycleLabel,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontSize: isWeb ? 16 : 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isWeb ? 24 : 28),

        PrimaryButton(
          label: pauseLabel,
          onPressed: onPauseToggle,
          isExpanded: false,
          backgroundColor: isDark ? Color(0xFF823386) : Color(0xFFEFE6F0),
          foregroundColor: isDark ? Color(0xFF141414) : Color(0xFF28002A),
          leadingIcon: isPaused
              ? Assets.icons.svg.lightPause.svg()
              : Assets.icons.svg.lightPlay.svg(),
        ),
      ],
    );
  }
}

class SessionBubble extends StatelessWidget {
  const SessionBubble({
    required this.scale,
    required this.label,
    required this.isWeb,
    super.key,
  });

  final double scale;
  final String? label;
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bubbleSize = isWeb ? 196.0 : 372.0;

    return Transform.scale(
      scale: scale,
      child: Container(
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
        child: Center(
          child: Text(
            label ?? '',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: isWeb ? 50 : 66,
              color: isDark ? Colors.white : AppColors.textLight,
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedSessionProgressBar extends StatefulWidget {
  const AnimatedSessionProgressBar({required this.progress, super.key});

  final double progress;

  @override
  State<AnimatedSessionProgressBar> createState() =>
      _AnimatedSessionProgressBarState();
}

class _AnimatedSessionProgressBarState extends State<AnimatedSessionProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Tween<double> _progressTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.sessionTick,
    );
    _progressTween = Tween<double>(
      begin: _clampProgress(widget.progress),
      end: _clampProgress(widget.progress),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedSessionProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress == oldWidget.progress) {
      return;
    }

    final from = _clampProgress(_progressTween.evaluate(_controller));
    final to = _clampProgress(widget.progress);
    _progressTween = Tween<double>(begin: from, end: to);

    _controller
      ..stop()
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final value = _clampProgress(_progressTween.evaluate(_controller));
        return ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(minHeight: 8, value: value),
        );
      },
    );
  }

  double _clampProgress(double value) => value.clamp(0, 1).toDouble();
}

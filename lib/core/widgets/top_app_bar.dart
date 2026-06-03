import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_colors.dart';
import '../../features/settings/presentation/night_mode_controller.dart';

class LearnerTopAppBar extends ConsumerWidget {
  const LearnerTopAppBar({
    super.key,
    this.subtitle,
    this.onBack,
    this.onProfile,
  });

  final String? subtitle;
  final VoidCallback? onBack;
  final VoidCallback? onProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(nightModeProvider);
    final foreground = isNightMode
        ? AppColors.nightOnSurface
        : AppColors.primary;
    final buttonForeground = isNightMode
        ? AppColors.nightBackground
        : AppColors.primary;
    final buttonBackground = isNightMode
        ? AppColors.surfaceLowest
        : Colors.transparent;
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: foreground,
      fontWeight: FontWeight.w700,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          _RoundIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            color: buttonForeground,
            background: buttonBackground,
            onTap: onBack,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Little Learner', style: titleStyle),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ],
            ),
          ),
          _RoundIconButton(
            icon: Icons.face_rounded,
            color: buttonForeground,
            background: buttonBackground,
            onTap: onProfile ?? ref.read(nightModeProvider.notifier).toggle,
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.color,
    required this.background,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color background;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: DecoratedBox(
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: IconButton(
          onPressed: onTap,
          icon: Icon(icon, color: color, size: 32),
        ),
      ),
    );
  }
}

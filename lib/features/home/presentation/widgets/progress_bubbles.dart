import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../progress_tracker.dart';

class ProgressBubbles extends ConsumerWidget {
  const ProgressBubbles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitedCount = ref.watch(progressTrackerProvider).length;
    print('ProgressBubbles build - visitedCount: $visitedCount');
    // Clamp to max 3 (blurRadius value)
    final offsetValue = visitedCount.clamp(0, 3);
    print('ProgressBubbles build - offsetValue: $offsetValue');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.surfaceLowest, width: 4),
        boxShadow: [
          BoxShadow(
            color: const Color(0x16000000),
            blurRadius: 3,
            offset: Offset(0, offsetValue.toDouble()),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Play:',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(width: 12),
          for (var i = 0; i < 3; i++) ...[
            _Bubble(isFilled: i < offsetValue),
            if (i != 2) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.isFilled});

  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? const Color(0xFF8B4513) : AppColors.surfaceVariant,
        border: Border.all(color: AppColors.surfaceLowest, width: 4),
      ),
    );
  }
}

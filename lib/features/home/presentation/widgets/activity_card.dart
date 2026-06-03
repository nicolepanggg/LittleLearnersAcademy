import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/tactile_card.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.label,
    required this.icon,
    required this.background,
    required this.shadowColor,
    required this.textColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color shadowColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TactileCard(
      height: 188,
      background: background,
      shadowColor: shadowColor,
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.surfaceLowest,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 48, color: shadowColor),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}

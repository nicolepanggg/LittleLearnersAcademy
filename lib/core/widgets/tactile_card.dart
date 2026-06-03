import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class TactileCard extends StatelessWidget {
  const TactileCard({
    super.key,
    required this.background,
    required this.shadowColor,
    required this.child,
    this.onTap,
    this.height,
    this.padding = const EdgeInsets.all(24),
  });

  final Color background;
  final Color shadowColor;
  final Widget child;
  final VoidCallback? onTap;
  final double? height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Container(
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppColors.surfaceLowest, width: 4),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                offset: const Offset(0, 8),
                blurRadius: 0,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

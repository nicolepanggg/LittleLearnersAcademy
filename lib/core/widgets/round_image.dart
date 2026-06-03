import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class RoundImage extends StatelessWidget {
  const RoundImage({
    super.key,
    required this.asset,
    this.size = 96,
    this.borderWidth = 4,
  });

  final String asset;
  final double size;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceLowest,
        border: Border.all(color: AppColors.surfaceLowest, width: borderWidth),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(child: Image.asset(asset, fit: BoxFit.cover)),
    );
  }
}

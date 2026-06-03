import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AnimalCard extends StatelessWidget {
  const AnimalCard({
    super.key,
    required this.name,
    required this.asset,
    required this.background,
    required this.onPlaySound,
    required this.onSayName,
  });

  final String name;
  final String asset;
  final Color background;
  final VoidCallback onPlaySound;
  final VoidCallback onSayName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 440,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 28),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.surfaceLowest, width: 4),
        boxShadow: const [
          BoxShadow(color: Color(0xFFD49A00), offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        children: [
          _AnimalPortrait(asset: asset),
          const SizedBox(height: 36),
          Text(
            name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ActionButton(
                icon: Icons.pets_rounded,
                background: AppColors.primaryContainer,
                foreground: AppColors.primary,
                shadow: AppColors.primary,
                onPressed: onPlaySound,
              ),
              const SizedBox(width: 20),
              _ActionButton(
                icon: Icons.record_voice_over_rounded,
                background: AppColors.tertiaryContainer,
                foreground: AppColors.onTertiaryContainer,
                shadow: AppColors.tertiary,
                onPressed: onSayName,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimalPortrait extends StatelessWidget {
  const _AnimalPortrait({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: ClipOval(child: Image.asset(asset, fit: BoxFit.cover)),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.background,
    required this.foreground,
    required this.shadow,
    required this.onPressed,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
  final Color shadow;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      height: 58,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.surfaceLowest, width: 3),
          boxShadow: [BoxShadow(color: shadow, offset: const Offset(0, 4))],
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          icon: Icon(icon, color: foreground, size: 30),
        ),
      ),
    );
  }
}

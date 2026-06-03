import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/top_app_bar.dart';
import '../../../l10n/app_localizations.dart';
import '../../navigation/presentation/navigation_controller.dart';
import 'night_mode_controller.dart';
import 'settings_controller.dart';
import 'language_controller.dart';
import 'widgets/parent_gate.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final gameVolume = ref.watch(gameVolumeProvider);
    final isUnlocked = ref.watch(parentGateUnlockedProvider);
    final navigation = ref.read(currentTabProvider.notifier);
    final currentLocale = ref.watch(languageControllerProvider);
    final languageController = ref.read(languageControllerProvider.notifier);

    return Column(
      children: [
        LearnerTopAppBar(
          subtitle: l10n.settings,
          onBack: navigation.goBack,
          onProfile: ref.read(nightModeProvider.notifier).toggle,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SectionTitle(
                  icon: Icons.volume_up_rounded,
                  label: l10n.sounds,
                  color: AppColors.secondary,
                ),
                const SizedBox(height: 16),
                _Panel(
                  child: Column(
                    children: [
                      _VolumeSlider(
                        label: l10n.gameSounds,
                        value: gameVolume,
                        onChanged: ref.read(gameVolumeProvider.notifier).update,
                      ),
                      const SizedBox(height: 28),
                      // _VolumeSlider(
                      //   label: l10n.music,
                      //   value: musicVolume,
                      //   onChanged: ref
                      //       .read(musicVolumeProvider.notifier)
                      //       .update,
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _SectionTitle(
                  icon: Icons.translate_rounded,
                  label: l10n.language,
                  color: AppColors.tertiary,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _LanguageButton(
                        label: l10n.english,
                        nativeLabel: 'English',
                        flagAsset: AppAssets.flagUs,
                        isActive: currentLocale.languageCode == 'en',
                        onTap: languageController.setEnglish,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _LanguageButton(
                        label: l10n.traditionalChinese,
                        nativeLabel: '繁體中文',
                        flagAsset: AppAssets.flagTw,
                        isActive: currentLocale.languageCode == 'zh',
                        onTap: languageController.setChinese,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ParentGate(isUnlocked: isUnlocked),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final displayColor = isDarkMode ? _getLighterColor(color) : color;

    return Row(
      children: [
        Icon(icon, size: 32, color: displayColor),
        const SizedBox(width: 12),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: displayColor),
        ),
      ],
    );
  }

  Color _getLighterColor(Color color) {
    // Use lighter variants for dark mode
    if (color == AppColors.secondary) {
      return AppColors.secondaryContainer; // Lighter blue
    } else if (color == AppColors.tertiary) {
      return AppColors.tertiaryContainer; // Lighter green
    }
    return color;
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.surfaceLowest, width: 4),
      ),
      child: child,
    );
  }
}

class _VolumeSlider extends StatelessWidget {
  const _VolumeSlider({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 12),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceLowest,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Slider(
            value: value,
            activeColor: AppColors.primaryContainer,
            inactiveColor: AppColors.surfaceVariant,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.label,
    required this.nativeLabel,
    required this.flagAsset,
    this.isActive = false,
    required this.onTap,
  });

  final String label;
  final String nativeLabel;
  final String flagAsset;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceLowest,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive
                  ? AppColors.primaryContainer
                  : AppColors.surfaceVariant,
              width: 4,
            ),
            boxShadow: isActive
                ? const [
                    BoxShadow(
                      color: AppColors.primaryContainer,
                      offset: Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 66,
                  height: 66,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE7E0D5),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: ClipOval(
                        child: Image.asset(flagAsset, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Text(
                //   label,
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context).textTheme.labelLarge?.copyWith(
                //     color: Colors.black,
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
                const SizedBox(height: 6),
                Text(
                  nativeLabel,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF5E5546),
                    fontWeight: FontWeight.w600,
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

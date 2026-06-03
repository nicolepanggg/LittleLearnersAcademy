import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/speech/speech_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/round_image.dart';
import '../../../core/widgets/top_app_bar.dart';
import '../../../l10n/app_localizations.dart';
import '../../navigation/presentation/navigation_controller.dart';
import '../../settings/presentation/language_controller.dart';
import '../../settings/presentation/night_mode_controller.dart';
import '../../settings/presentation/settings_controller.dart';
import 'number_controller.dart';

class NumbersScreen extends ConsumerWidget {
  const NumbersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final number = ref.watch(currentNumberProvider);
    final controller = ref.read(currentNumberProvider.notifier);
    final navigation = ref.read(currentTabProvider.notifier);

    return Column(
      children: [
        LearnerTopAppBar(
          onBack: navigation.goBack,
          onProfile: ref.read(nightModeProvider.notifier).toggle,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              children: [
                Text(
                  l10n.countingFun,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.countTheApples,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                _NumberCard(number: number),
                const SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CircleButton(
                      icon: Icons.arrow_left_rounded,
                      background: AppColors.secondary,
                      onTap: controller.previous,
                    ),
                    _NumberDots(activeIndex: number - 1),
                    _CircleButton(
                      icon: Icons.arrow_right_rounded,
                      background: AppColors.primaryContainer,
                      foreground: AppColors.onPrimaryContainer,
                      onTap: controller.next,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NumberCard extends ConsumerWidget {
  const _NumberCard({required this.number});

  final int number;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final volume = ref.watch(gameVolumeProvider);
    final languageCode = ref.watch(languageControllerProvider).languageCode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
      decoration: BoxDecoration(
        color: AppColors.primaryFixed,
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: AppColors.surfaceLowest, width: 4),
        boxShadow: const [
          BoxShadow(color: AppColors.outlineVariant, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$number',
            style: const TextStyle(
              fontSize: 96,
              height: 1,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: 196,
            child: Wrap(
              spacing: 16,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: List.generate(
                number,
                (_) => const RoundImage(asset: AppAssets.apple, size: 86),
              ),
            ),
          ),
          const SizedBox(height: 32),
          InkWell(
            onTap: () => SpeechService.speak(
              _labelFor(context, number),
              rate: 0.5,
              pitch: 1.0,
              volume: volume,
              languageCode: languageCode,
            ),
            borderRadius: BorderRadius.circular(999),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFF0D47A1),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Text(
                  _labelFor(context, number),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _labelFor(BuildContext context, int number) {
    final l10n = AppLocalizations.of(context)!;
    final labels = [
      l10n.oneApple,
      l10n.twoApples,
      l10n.threeApples,
      l10n.fourApples,
      l10n.fiveApples,
    ];
    return labels[number - 1];
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.background,
    required this.onTap,
    this.foreground = Colors.white,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: background,
          padding: EdgeInsets.zero,
        ),
        child: Icon(icon, color: foreground, size: 30),
      ),
    );
  }
}

class _NumberDots extends StatelessWidget {
  const _NumberDots({required this.activeIndex});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final isActive = index == activeIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            width: isActive ? 20 : 16,
            height: isActive ? 20 : 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColors.primaryContainer
                  : AppColors.surfaceVariant,
              border: isActive
                  ? Border.all(color: AppColors.primary, width: 2)
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

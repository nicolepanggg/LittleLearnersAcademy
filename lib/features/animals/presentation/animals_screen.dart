import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/top_app_bar.dart';
import '../../../l10n/app_localizations.dart';
import '../application/animal_speech.dart';
import '../../navigation/presentation/navigation_controller.dart';
import '../../settings/presentation/language_controller.dart';
import '../../settings/presentation/night_mode_controller.dart';
import '../../settings/presentation/settings_controller.dart';
import 'widgets/animal_card.dart';

class AnimalsScreen extends ConsumerWidget {
  const AnimalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = ref.read(currentTabProvider.notifier);
    final volume = ref.watch(gameVolumeProvider);
    final languageCode = ref.watch(languageControllerProvider).languageCode;
    final l10n = AppLocalizations.of(context)!;
    final animals = [
      (
        name: l10n.lion,
        sound: 'Roar',
        asset: AppAssets.lion,
        color: const Color(0xFFFFD77A),
      ),
      (
        name: l10n.elephant,
        sound: 'Trumpet',
        asset: AppAssets.elephant,
        color: AppColors.secondaryContainer,
      ),
      (
        name: l10n.monkey,
        sound: 'Ooh ooh ah ah',
        asset: AppAssets.monkey,
        color: const Color(0xFFFFC1A6),
      ),
      (
        name: l10n.giraffe,
        sound: 'Hum',
        asset: AppAssets.giraffe,
        color: AppColors.primaryFixed,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LearnerTopAppBar(
          onBack: navigation.goBack,
          onProfile: ref.read(nightModeProvider.notifier).toggle,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 64),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Column(
                    children: [
                      Text(
                        l10n.animals,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.animalsSubtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 448,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: animals.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 24),
                    itemBuilder: (context, index) {
                      final animal = animals[index];
                      return AnimalCard(
                        name: animal.name,
                        asset: animal.asset,
                        background: animal.color,
                        onPlaySound: () => AnimalSpeech.playSound(
                          animal.sound,
                          volume: volume,
                          languageCode: languageCode,
                        ),
                        onSayName: () => AnimalSpeech.sayName(
                          animal.name,
                          volume: volume,
                          languageCode: languageCode,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

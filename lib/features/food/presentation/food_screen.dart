import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/speech/speech_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/top_app_bar.dart';
import '../../../l10n/app_localizations.dart';
import '../../navigation/presentation/navigation_controller.dart';
import '../../settings/presentation/language_controller.dart';
import '../../settings/presentation/night_mode_controller.dart';
import '../../settings/presentation/settings_controller.dart';

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = ref.read(currentTabProvider.notifier);
    final volume = ref.watch(gameVolumeProvider);
    final languageCode = ref.watch(languageControllerProvider).languageCode;
    final l10n = AppLocalizations.of(context)!;
    final foods = [
      (label: l10n.apple, asset: AppAssets.apple),
      (label: l10n.banana, asset: AppAssets.banana),
      (label: l10n.carrot, asset: AppAssets.carrot),
      (label: l10n.milk, asset: AppAssets.milk),
    ];

    return Column(
      children: [
        LearnerTopAppBar(
          onBack: navigation.goBack,
          onProfile: ref.read(nightModeProvider.notifier).toggle,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              children: [
                Text(
                  l10n.yummyFood,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.tapToTaste,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 36),
                GridView.builder(
                  itemCount: foods.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.76,
                    crossAxisSpacing: 26,
                    mainAxisSpacing: 26,
                  ),
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return _FoodTile(
                      label: food.label,
                      asset: food.asset,
                      onSpeak: () => SpeechService.speak(
                        food.label,
                        volume: volume,
                        languageCode: languageCode,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FoodTile extends StatelessWidget {
  const _FoodTile({
    required this.label,
    required this.asset,
    required this.onSpeak,
  });

  final String label;
  final String asset;
  final VoidCallback onSpeak;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceLowest,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: ClipOval(child: Image.asset(asset, fit: BoxFit.cover)),
              ),
              Positioned(
                right: 5,
                bottom: 10,
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onSpeak,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surfaceLowest,
                          width: 4,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.volume_up_rounded,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: AppColors.onSurface),
        ),
      ],
    );
  }
}

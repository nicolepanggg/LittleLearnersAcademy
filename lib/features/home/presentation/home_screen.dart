import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/round_image.dart';
import '../../../core/widgets/tactile_card.dart';
import '../../../core/widgets/top_app_bar.dart';
import '../../../l10n/app_localizations.dart';
import '../../navigation/domain/app_tab.dart';
import '../../navigation/presentation/navigation_controller.dart';
import '../../settings/presentation/night_mode_controller.dart';
import 'widgets/activity_card.dart';
import 'widgets/progress_bubbles.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = ref.read(currentTabProvider.notifier);
    final isNightMode = ref.watch(nightModeProvider);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        LearnerTopAppBar(
          onBack: navigation.goBack,
          onProfile: ref.read(nightModeProvider.notifier).toggle,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              children: [
                const RoundImage(
                  asset: AppAssets.owl,
                  size: 160,
                  borderWidth: 8,
                ),
                const SizedBox(height: 24),
                Text(
                  isNightMode ? l10n.sweetDreams : l10n.helloFriend,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.readyToPlayToday,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                // const ProgressBubbles(),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ActivityCard(
                        label: l10n.animals,
                        icon: Icons.pets_rounded,
                        background: isNightMode
                            ? AppColors.nightAnimals
                            : AppColors.secondaryContainer,
                        shadowColor: isNightMode
                            ? const Color(0xFF4B1480)
                            : AppColors.secondary,
                        textColor: isNightMode
                            ? AppColors.nightOnSurface
                            : AppColors.onSecondaryContainer,
                        onTap: () => navigation.select(AppTab.animals),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ActivityCard(
                        label: l10n.numbers,
                        icon: Icons.looks_one_rounded,
                        background: isNightMode
                            ? AppColors.nightNumbers
                            : AppColors.primaryContainer,
                        shadowColor: isNightMode
                            ? AppColors.secondary
                            : AppColors.primary,
                        textColor: isNightMode
                            ? AppColors.nightOnSurface
                            : AppColors.onPrimaryContainer,
                        onTap: () => navigation.select(AppTab.numbers),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TactileCard(
                  height: 148,
                  background: isNightMode
                      ? AppColors.nightFood
                      : AppColors.tertiaryContainer,
                  shadowColor: isNightMode
                      ? const Color(0xFF004D40)
                      : AppColors.tertiary,
                  onTap: () => navigation.select(AppTab.food),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.food,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: isNightMode
                                  ? AppColors.nightOnSurface
                                  : AppColors.onTertiaryContainer,
                            ),
                      ),
                      const CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColors.surfaceLowest,
                        child: Icon(
                          Icons.restaurant_rounded,
                          color: AppColors.tertiary,
                          size: 54,
                        ),
                      ),
                    ],
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

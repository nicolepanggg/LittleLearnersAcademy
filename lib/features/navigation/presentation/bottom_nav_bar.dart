import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/presentation/night_mode_controller.dart';
import '../domain/app_tab.dart';
import 'navigation_controller.dart';

class LearnerBottomNavBar extends ConsumerWidget {
  const LearnerBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(currentTabProvider);
    final isNightMode = ref.watch(nightModeProvider);

    return Container(
      height: 100,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
      decoration: BoxDecoration(
        color: isNightMode
            ? AppColors.nightSurface
            : AppColors.surfaceContainer,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: const [
          BoxShadow(color: AppColors.outlineVariant, offset: Offset(0, -6)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: AppTab.values.map((tab) {
          final isActive = activeTab == tab;
          return Expanded(
            child: _NavItem(tab: tab, isActive: isActive),
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem extends ConsumerWidget {
  const _NavItem({required this.tab, required this.isActive});

  final AppTab tab;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(nightModeProvider);
    final inactive = isNightMode
        ? AppColors.nightOnSurface
        : AppColors.onSurfaceVariant;
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () => ref.read(currentTabProvider.notifier).select(tab),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.onPrimaryContainer,
                    offset: Offset(0, 6),
                  ),
                ],
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              tab.icon,
              size: 30,
              color: isActive ? AppColors.onPrimaryContainer : inactive,
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                tab.label(context),
                maxLines: 1,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 13,
                  color: isActive ? AppColors.onPrimaryContainer : inactive,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

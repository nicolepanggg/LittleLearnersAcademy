import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../settings_controller.dart';

class ParentGate extends ConsumerWidget {
  const ParentGate({super.key, required this.isUnlocked});

  final bool isUnlocked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.surfaceLowest, width: 4),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.family_restroom_rounded,
            size: 48,
            color: AppColors.primary,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.parentsOnly,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            '5 + 2 = ?',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 16),
          Row(
            children: [3, 7, 9].map((answer) {
              final isDarkMode =
                  Theme.of(context).brightness == Brightness.dark;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: FilledButton(
                    onPressed: () => ref
                        .read(parentGateUnlockedProvider.notifier)
                        .answer(answer),
                    child: Text(
                      '$answer',
                      style: TextStyle(color: isDarkMode ? Colors.white : null),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (isUnlocked) ...[
            const SizedBox(height: 20),
            _ParentOption(
              label: l10n.accountSettings,
              icon: Icons.person_rounded,
            ),
            const SizedBox(height: 12),
            _ParentOption(label: l10n.helpSupport, icon: Icons.help_rounded),
          ],
        ],
      ),
    );
  }
}

class _ParentOption extends StatelessWidget {
  const _ParentOption({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

enum AppTab {
  home(Icons.home_rounded),
  animals(Icons.pets_rounded),
  numbers(Icons.looks_one_rounded),
  food(Icons.restaurant_rounded),
  settings(Icons.settings_rounded);

  const AppTab(this.icon);

  final IconData icon;

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case AppTab.home:
        return l10n.home;
      case AppTab.animals:
        return l10n.animals;
      case AppTab.numbers:
        return l10n.numbers;
      case AppTab.food:
        return l10n.food;
      case AppTab.settings:
        return l10n.settings;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../animals/presentation/animals_screen.dart';
import '../../food/presentation/food_screen.dart';
import '../../home/presentation/home_screen.dart';
import '../../numbers/presentation/numbers_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import '../domain/app_tab.dart';
import 'bottom_nav_bar.dart';
import 'navigation_controller.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(currentTabProvider);

    return Scaffold(
      body: SafeArea(bottom: false, child: _screenFor(tab)),
      bottomNavigationBar: const LearnerBottomNavBar(),
    );
  }

  Widget _screenFor(AppTab tab) {
    return switch (tab) {
      AppTab.home => const HomeScreen(),
      AppTab.animals => const AnimalsScreen(),
      AppTab.numbers => const NumbersScreen(),
      AppTab.food => const FoodScreen(),
      AppTab.settings => const SettingsScreen(),
    };
  }
}

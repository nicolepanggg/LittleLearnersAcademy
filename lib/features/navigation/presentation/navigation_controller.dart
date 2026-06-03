import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../home/presentation/progress_tracker.dart';
import '../domain/app_tab.dart';

part 'navigation_controller.g.dart';

@riverpod
class CurrentTab extends _$CurrentTab {
  final List<AppTab> _history = [];

  @override
  AppTab build() => AppTab.home;

  void select(AppTab tab) {
    print('Navigation select called with: $tab, current state: $state');
    if (state == tab) {
      print('Already on tab: $tab, returning');
      return;
    }

    _history.add(state);
    state = tab;
    print('Switched to tab: $tab');

    // Track visited pages for progress
    ref.read(progressTrackerProvider.notifier).visitPage(tab);
  }

  void goBack() {
    if (_history.isEmpty) {
      return;
    }

    state = _history.removeLast();
  }
}

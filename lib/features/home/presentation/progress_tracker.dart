import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../navigation/domain/app_tab.dart';

part 'progress_tracker.g.dart';

@Riverpod(keepAlive: true)
class ProgressTracker extends _$ProgressTracker {
  @override
  Set<AppTab> build() {
    return {};
  }

  void visitPage(AppTab tab) {
    print('visitPage called with: $tab');
    // Only track Animals, Numbers, and Food
    if (tab == AppTab.animals || tab == AppTab.numbers || tab == AppTab.food) {
      print('Tab is trackable: $tab');
      if (!state.contains(tab)) {
        print('Adding new tab to state: $tab');
        state = {...state, tab};
        print('New state length: ${state.length}');
      } else {
        print('Tab already in state: $tab');
      }
    } else {
      print('Tab not trackable: $tab');
    }
  }
}

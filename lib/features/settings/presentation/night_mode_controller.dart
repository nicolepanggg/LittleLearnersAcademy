import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'night_mode_controller.g.dart';

@riverpod
class NightMode extends _$NightMode {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}

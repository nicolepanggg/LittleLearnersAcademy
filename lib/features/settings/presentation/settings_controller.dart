import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

@riverpod
class GameVolume extends _$GameVolume {
  @override
  double build() => 0.8;

  void update(double value) {
    state = value;
  }
}

@riverpod
class MusicVolume extends _$MusicVolume {
  @override
  double build() => 0.3;

  void update(double value) {
    state = value;
  }
}

@riverpod
class ParentGateUnlocked extends _$ParentGateUnlocked {
  @override
  bool build() => false;

  void answer(int value) {
    state = value == 7;
  }
}

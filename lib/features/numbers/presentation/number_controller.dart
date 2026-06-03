import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'number_controller.g.dart';

@riverpod
class CurrentNumber extends _$CurrentNumber {
  @override
  int build() => 3;

  void next() {
    state = state == 5 ? 1 : state + 1;
  }

  void previous() {
    state = state == 1 ? 5 : state - 1;
  }
}

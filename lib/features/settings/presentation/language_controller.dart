import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_controller.g.dart';

@riverpod
class LanguageController extends _$LanguageController {
  @override
  Locale build() {
    return const Locale('en'); // Default to English
  }

  void setEnglish() {
    state = const Locale('en');
  }

  void setChinese() {
    state = const Locale('zh');
  }

  void toggle() {
    state = state.languageCode == 'en'
        ? const Locale('zh')
        : const Locale('en');
  }
}

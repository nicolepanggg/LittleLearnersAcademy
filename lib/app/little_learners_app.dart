import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../l10n/app_localizations.dart';

import '../core/scroll/app_scroll_behavior.dart';
import '../core/theme/app_theme.dart';
import '../features/navigation/presentation/app_shell.dart';
import '../features/settings/presentation/night_mode_controller.dart';
import '../features/settings/presentation/language_controller.dart';

class LittleLearnersApp extends ConsumerWidget {
  const LittleLearnersApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(nightModeProvider);
    final locale = ref.watch(languageControllerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Little Learners Academy',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isNightMode ? ThemeMode.dark : ThemeMode.light,
      scrollBehavior: const AppScrollBehavior(),
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('zh')],
      home: const AppShell(),
    );
  }
}

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    return _theme(
      scaffold: AppColors.background,
      surface: AppColors.surface,
      textColor: AppColors.onSurface,
      mutedTextColor: AppColors.onSurfaceVariant,
    );
  }

  static ThemeData get dark {
    return _theme(
      scaffold: AppColors.nightBackground,
      surface: AppColors.nightSurface,
      textColor: AppColors.nightOnSurface,
      mutedTextColor: AppColors.nightOnSurfaceVariant,
      brightness: Brightness.dark,
    );
  }

  static ThemeData _theme({
    required Color scaffold,
    required Color surface,
    required Color textColor,
    required Color mutedTextColor,
    Brightness brightness = Brightness.light,
  }) {
    final textTheme = ThemeData(brightness: brightness).textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: scaffold,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryContainer,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        surface: surface,
        brightness: brightness,
      ),
      textTheme: textTheme.copyWith(
        headlineLarge: textTheme.headlineLarge?.copyWith(
          fontSize: 32,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontSize: 28,
          height: 1.28,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontSize: 24,
          height: 1.33,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          fontSize: 20,
          height: 1.4,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          fontSize: 18,
          height: 1.45,
          fontWeight: FontWeight.w500,
          color: mutedTextColor,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          fontSize: 16,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: mutedTextColor,
        ),
      ),
    );
  }
}

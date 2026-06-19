import 'package:flutter/material.dart';

class AppColors {
  static const deepNavy = Color(0xFF0D2137);
  static const blue = Color(0xFF1D5FA8);
  static const teal = Color(0xFF0D6E5A);
  static const amber = Color(0xFF8A5200);
  static const purple = Color(0xFF4B0082);
  static const offWhite = Color(0xFFF8F8F6);
  static const ink = Color(0xFF14253A);
  static const muted = Color(0xFF617084);
  static const line = Color(0x1F0D2137);
  static const panel = Color(0xFFFFFFFF);
  static const panelTint = Color(0xFFF0F5F8);
}

class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      brightness: Brightness.light,
      primary: AppColors.deepNavy,
      secondary: AppColors.teal,
      surface: AppColors.offWhite,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.offWhite,
      fontFamily: 'Arial',
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.blue,
        selectionColor: Color(0x331D5FA8),
      ),
      focusColor: const Color(0x261D5FA8),
      hoverColor: const Color(0x101D5FA8),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 76,
          height: 0.98,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: AppColors.deepNavy,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 52,
          height: 1.02,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: AppColors.deepNavy,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 40,
          height: 1.08,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: AppColors.deepNavy,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 30,
          height: 1.14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: AppColors.deepNavy,
        ),
        titleLarge: TextStyle(
          fontSize: 21,
          height: 1.28,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: AppColors.deepNavy,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          height: 1.32,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: AppColors.deepNavy,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          height: 1.62,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: AppColors.ink,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          height: 1.58,
          letterSpacing: 0,
          color: AppColors.muted,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: AppColors.deepNavy,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: AppColors.muted,
        ),
      ),
    );
  }
}

// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ─── Renk Paleti ───────────────────────────────────────────
  static const Color primaryPink = Color(0xFFF48FB1);
  static const Color deepPink = Color(0xFFE91E8C);
  static const Color lightPink = Color(0xFFFCE4EC);
  static const Color accentPurple = Color(0xFFCE93D8);
  static const Color rosePink = Color(0xFFFF80AB);
  static const Color softWhite = Color(0xFFFFF8F9);
  static const Color darkText = Color(0xFF2D1B2E);
  static const Color greyText = Color(0xFF8D6E73);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color scaffoldBackground = Color(0xFFFFF0F5);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPink,
        primary: deepPink,
        secondary: accentPurple,
        tertiary: rosePink,
        surface: cardBackground,
        background: scaffoldBackground,
      ),
      scaffoldBackgroundColor: scaffoldBackground,
      fontFamily: 'Poppins',

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: softWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: deepPink),
      ),

      // Card
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 4,
        shadowColor: primaryPink.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: deepPink,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: lightPink,
        selectedColor: deepPink,
        labelStyle: const TextStyle(fontSize: 13, color: darkText),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: softWhite,
        selectedItemColor: deepPink,
        unselectedItemColor: greyText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),

      // InputDecoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightPink.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: deepPink, width: 2),
        ),
        hintStyle: const TextStyle(color: greyText),
        prefixIconColor: greyText,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(color: darkText, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(color: darkText, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: darkText, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: darkText, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: darkText),
        bodyMedium: TextStyle(color: greyText),
        labelLarge: TextStyle(color: deepPink, fontWeight: FontWeight.w600),
      ),
    );
  }
}

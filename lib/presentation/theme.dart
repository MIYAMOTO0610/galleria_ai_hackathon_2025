import 'package:flutter/material.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  colorScheme: appColorScheme,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xFF003CFF),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    ),
  ),
);

final appColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.white,
  brightness: Brightness.dark,
  primary: const Color(0xFF404040),
);

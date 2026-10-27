import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFCD116)),
        appBarTheme: const AppBarTheme(centerTitle: true),
        cardTheme: CardThemeData(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      );
}
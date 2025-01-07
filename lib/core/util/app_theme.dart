import 'package:flutter/material.dart';

class AppTheme {
  static const textTheme = TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ), // Large headlines
    displayMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ), // Section headers
    bodyLarge: TextStyle(
      color: Color(0xFFE0E0E0),
      fontSize: 16,
    ), // Regular text
    bodyMedium: TextStyle(
      color: Color(0xFFB3B3B3),
      fontSize: 14,
    ), // Muted text
  );
  static const appBarTheme = AppBarTheme(
    backgroundColor: Color(0xFF1C1C1C),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:phonebook/core/constants/colors.dart';


class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black, 
      elevation: 0.5,
    ),
    cardColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: primaryclr,
      background: Colors.white,
      surface: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    cardColor: const Color(0xFF1E1E1E), 
    colorScheme: ColorScheme.dark(
      primary: Colors.blue.shade600,
      background: Colors.black,
      surface: const Color(0xFF1E1E1E),
    ),
  );
}

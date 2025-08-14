import 'package:flutter/material.dart';
import 'package:phonebook/core/constants/colors.dart';

// class AppThemes {
//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: primaryclr,
//     scaffoldBackgroundColor: const Color(0xFFF0F2F5),
//     cardColor: Colors.white,
//     appBarTheme: const AppBarTheme(
//       color: Colors.white,
//       iconTheme: IconThemeData(color: Colors.black),
//     ),
//     colorScheme: ColorScheme.fromSwatch(
//       primarySwatch: Colors.blue,
//       brightness: Brightness.light,
//     ).copyWith(
//       secondary: Colors.blueAccent,
//       onSurface: Colors.black87,
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: Colors.black87),
//       bodyMedium: TextStyle(color: Colors.black54),
//       titleLarge: TextStyle(color: Colors.black),
//     ),
//   );

//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: Colors.blue.shade600,
//     scaffoldBackgroundColor: const Color(0xFF121212),
//     cardColor: const Color(0xFF1E1E1E),
//     appBarTheme: const AppBarTheme(
//       color: Color(0xFF1E1E1E),
//       iconTheme: IconThemeData(color: Colors.white),
//     ),
//     colorScheme: ColorScheme.fromSwatch(
//       primarySwatch: Colors.blue,
//       brightness: Brightness.dark, // Set ColorScheme brightness to match ThemeData
//     ).copyWith(
//       secondary: Colors.blueAccent,
//       onSurface: Colors.white70,
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: Colors.white70),
//       bodyMedium: TextStyle(color: Colors.white54),
//       titleLarge: TextStyle(color: Colors.white),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:phonebook/core/constants/colors.dart'; // Make sure you have your primaryclr defined here

class AppThemes {
  // ✅ PURE WHITE THEME
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black, // Makes AppBar icons and text black
      elevation: 0.5,
    ),
    cardColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: primaryclr,
      background: Colors.white,
      surface: Colors.white,
    ),
  );

  // ✅ PURE BLACK THEME
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white, // Makes AppBar icons and text white
    ),
    cardColor: const Color(0xFF1E1E1E), // Slightly off-black for cards
    colorScheme: ColorScheme.dark(
      primary: Colors.blue.shade600,
      background: Colors.black,
      surface: const Color(0xFF1E1E1E),
    ),
  );
}

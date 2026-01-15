import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette based on #134E4A
  static const Color primaryDark = Color(0xFF134E4A); // Main color
  static const Color primaryDarker = Color(0xFF0F3A35); // Darker shade
  static const Color primaryMedium = Color(0xFF1A5C54); // Medium shade
  static const Color primaryLight = Color(0xFF2D7A6E); // Lighter shade
  static const Color textWhite = Color(0xFFFFFFFF); // Pure white for text
  static const Color iconGray = Color(0xFFE5E5E5); // Light gray for icons

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryDark,
      scaffoldBackgroundColor: primaryDark,
      colorScheme: ColorScheme.dark(
        primary: primaryDark,
        secondary: primaryMedium,
        surface: primaryDarker,
      ),
      textTheme: TextTheme(
        // Quote text style
        headlineLarge: GoogleFonts.playfairDisplay(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: textWhite,
          height: 1.4,
        ),
        // Author text style
        bodyLarge: GoogleFonts.playfairDisplay(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: textWhite,
          letterSpacing: 0.5,
        ),
        // Button text style
        labelLarge: GoogleFonts.playfairDisplay(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textWhite,
          letterSpacing: 2,
        ),
      ),
      iconTheme: const IconThemeData(
        color: iconGray,
        size: 28,
      ),
    );
  }
}

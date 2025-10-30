import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors (Gradient)
  static const Color primaryBlue = Color(0xFF0C4886);
  static const Color secondaryBlue = Color(0xFF157FEC);

  // Accent Colors
  static const Color successGreen = Color(0xFF73D490);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textLightGray = Color(0xFF898C92);

  // Background
  static const Color backgroundGray = Color(0xFFF5F5F5);
  static const Color cardWhite = Color(0xFFFFFFFF);

  // Text Colors
  static const Color hintGray = Color(0xFF9CA3AF);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, secondaryBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

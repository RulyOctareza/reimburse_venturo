import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';

class AppTextStyles {
  // Headers
  static TextStyle title = GoogleFonts.inter(
    fontSize: 19,
    fontWeight: FontWeight.w600, // Semi-Bold
    color: AppColors.textDark,
  );

  static TextStyle sectionHeader = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Semi-Bold
    color: AppColors.textDark,
  );

  static TextStyle fieldLabel = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600, // Semi-Bold
    color: AppColors.textDark,
  );

  // Content
  static TextStyle personName = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.textDark,
  );

  static TextStyle jobTitle = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textLightGray,
  );

  static TextStyle statusBadge = GoogleFonts.inter(
    fontSize: 9,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textDark,
  );

  // Body text
  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textDark,
  );

  // Hints/Placeholders
  static TextStyle hint = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.hintGray,
  );

  // Button text
  static TextStyle button = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Semi-Bold
    color: Colors.white,
  );
}

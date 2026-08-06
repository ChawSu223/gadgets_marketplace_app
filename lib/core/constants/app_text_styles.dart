import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Heading 1 (Large Titles)
  static TextStyle h1 = GoogleFonts.redHatDisplay(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Heading 2 (Sub Titles / Section Titles)
  static TextStyle h2 = GoogleFonts.redHatDisplay(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  // Heading 3 (Sub Titles / Section Titles)
  static TextStyle h3 = GoogleFonts.redHatDisplay(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Body Text (Regular Content)
  static TextStyle body = GoogleFonts.redHatDisplay(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  // Body Small Text (Regular Content)
  static TextStyle bodySmall = GoogleFonts.redHatDisplay(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  // Subtitle / Caption (Muted text)
  static TextStyle caption = GoogleFonts.redHatDisplay(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Text small
  static TextStyle notification = GoogleFonts.redHatDisplay(
    fontSize: 7.sp,
    fontWeight: FontWeight.w900,
    color: AppColors.surface,
  );

  // Button Text
  static TextStyle button = GoogleFonts.redHatDisplay(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  // title text
  static TextStyle title1 = GoogleFonts.notoSans(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static TextStyle title2 = GoogleFonts.redHatDisplay(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}

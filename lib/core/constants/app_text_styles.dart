import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Heading 1 (Large Titles)
  static TextStyle h1 = TextStyle(
    fontFamily: "assets/fonts/RedHatDisplay-Regular.ttf",

    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // Heading 2 (Sub Titles / Section Titles)
  static TextStyle h2 = TextStyle(
    fontFamily: "assets/fonts/RedHatDisplay-Regular.ttf",

    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  // Heading 3 (Sub Titles / Section Titles)
  static TextStyle h3 = TextStyle(
    fontFamily: "assets/fonts/RedHatDisplay-Regular.ttf",

    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // Body Text (Light Content)
  static TextStyle body = TextStyle(
    fontFamily: "assets/fonts/RedHatDisplay-Regular.ttf",

    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
  );
  // Body Small Text (Light Content)
  static TextStyle bodySmall = TextStyle(
    fontFamily: "assets/fonts/RedHatDisplay-Regular.ttf",

    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
  );

  // Subtitle / Caption (Muted text)
  static TextStyle caption = TextStyle(
    fontFamily: "assets/fonts/RedHatDisplay-Regular.ttf",

    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
    color: AppColors.textSecondary,
  );

  // Text small
  static TextStyle notification = TextStyle(
    fontFamily: "assets/fonts/RedHatDisplay-Regular.ttf",

    fontSize: 7.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.surface,
  );

  // Button Text
  static TextStyle button = TextStyle(
    fontFamily: "assets/fonts/RedHatDisplay-Regular.ttf",

    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  // title text
  // static TextStyle title1 = GoogleFonts.notoSans(
  //   fontSize: 22,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.textPrimary,
  // );
  static TextStyle title2 = TextStyle(
    fontFamily: "assets/fonts/RedHatDisplay-Regular.ttf",
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}

import 'package:flutter/material.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';

class AppButtonStyles {
  AppButtonStyles();

  static const ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.primary),
    foregroundColor: WidgetStatePropertyAll(Colors.black),

    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
        side: BorderSide(color: AppColors.primary),
      ),
    ),
    elevation: WidgetStatePropertyAll(0.5),
  );

  static const ButtonStyle secondaryButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.background),
    foregroundColor: WidgetStatePropertyAll(Colors.black),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
        side: BorderSide(color: AppColors.primary),
      ),
    ),
    elevation: WidgetStatePropertyAll(0.5),
  );

  static const ButtonStyle fullButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.primary),
    foregroundColor: WidgetStatePropertyAll(Colors.black),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
        side: BorderSide(color: AppColors.primary),
      ),
    ),
    elevation: WidgetStatePropertyAll(0.5),
    minimumSize: WidgetStatePropertyAll(Size.fromRadius(25)),
    maximumSize: WidgetStatePropertyAll(Size.fromRadius(60)),
  );
}

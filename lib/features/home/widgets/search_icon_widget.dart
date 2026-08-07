import 'package:flutter/material.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SearchIconWidget extends StatelessWidget {
  void Function()? onTap;
  SearchIconWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border1, width: 1.5),
        ),
        padding: EdgeInsets.all(6),
        child: Icon(
          LucideIcons.search,
          size: 22,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:gadgets_marketplace/core/constants/app_text_styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Stack(
        children: [
          // Positioned.fill(child: Container(color: AppColors.success)),
          // Container(decoration: BoxDecoration(color: AppColors.error, borderRadius: ),)
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,

                border: Border.all(color: AppColors.border1, width: 1.5),
              ),
              padding: EdgeInsets.all(6),
              child: Icon(
                LucideIcons.bell,
                size: 22,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 1,
            child: CircleAvatar(
              backgroundColor: AppColors.error,
              radius: 7,
              child: Center(
                child: Text("9+", style: AppTextStyles.notification),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

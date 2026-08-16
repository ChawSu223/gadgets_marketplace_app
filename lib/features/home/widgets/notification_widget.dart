import 'package:flutter/material.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:gadgets_marketplace/core/constants/app_text_styles.dart';

class NotificationWidget extends StatelessWidget {
  final void Function()? onPressed;
  final IconData iconData;
  final int count;

  const NotificationWidget({
    super.key,
    required this.onPressed,
    required this.iconData,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
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
              child: Icon(iconData, size: 22, color: AppColors.textSecondary),
            ),
          ),
          if (count <= 0)
            Container()
          else if (count >= 10)
            Positioned(
              right: 1,
              top: 1,
              child: CircleAvatar(
                backgroundColor: AppColors.error,
                radius: 7,
                child: Center(
                  child: Text("9+", style: AppTextStyles.notification),
                ),
              ),
            )
          else
            Positioned(
              right: 1,
              top: 1,
              child: CircleAvatar(
                backgroundColor: AppColors.error,
                radius: 7,
                child: Center(
                  child: Text(
                    count.toString(),
                    style: AppTextStyles.notification,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

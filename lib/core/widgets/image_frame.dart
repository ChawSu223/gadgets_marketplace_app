import 'package:flutter/material.dart';
import 'package:gadgets_marketplace/views/home/widgets/error_widgets.dart';

class ImageFrame extends StatelessWidget {
  String imagePath;
  EdgeInsets? margin;

  ImageFrame({super.key, required this.imagePath, this.margin});

  @override
  Widget build(BuildContext context) {
    if (margin == null) {
      return ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(20),
        child: Image.asset(
          imagePath,
          width: 500,
          height: 300,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return ImageErrorWidget();
          },
        ),
      );
    } else if (margin != null) {
      return Container(
        padding: margin,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),
          child: Image.asset(
            imagePath,
            width: 500,
            height: 300,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return ImageErrorWidget();
            },
          ),
        ),
      );
    }
    return Container();
  }
}

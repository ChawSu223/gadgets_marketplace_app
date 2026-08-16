import 'package:flutter/material.dart';
import 'package:gadgets_marketplace/features/home/widgets/error_widgets.dart';

class ImageFrame extends StatelessWidget {
  String imagePath;
  EdgeInsets? margin;
  double? width;
  double? height;
  BorderRadiusGeometry? borderRadius;

  ImageFrame({
    super.key,
    required this.imagePath,
    this.margin,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (margin == null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadiusGeometry.circular(20),
        child: Image.asset(
          imagePath,
          width: width ?? 500,
          height: height ?? 300,
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
          borderRadius: borderRadius ?? BorderRadiusGeometry.circular(20),
          child: Image.asset(
            imagePath,
            width: width ?? 500,
            height: height ?? 300,
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

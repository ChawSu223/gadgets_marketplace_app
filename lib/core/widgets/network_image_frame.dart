import 'package:flutter/material.dart';
import 'package:gadgets_marketplace/features/home/widgets/error_widgets.dart';

class NetworkImageFrame extends StatelessWidget {
  String imagePath;
  EdgeInsets? margin;
  double? width;
  double? height;
  double? borderRadius;

  NetworkImageFrame({
    super.key,
    required this.imagePath,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (margin == null) {
      return ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(20),
        child: Image.network(
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
          borderRadius: BorderRadiusGeometry.circular(borderRadius ?? 20),
          child: Image.network(
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

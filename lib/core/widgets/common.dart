import 'package:flutter/material.dart';
import 'package:gadgets_marketplace/core/widgets/image_frame.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Common {
  static final List<Map<String, dynamic>> catogeries = [
    {'name': "All", 'icon': null},
    {'name': "Accessories", 'icon': LucideIcons.cable},
    {'name': "Audio", 'icon': LucideIcons.headphones},
    {'name': "Cameras", 'icon': LucideIcons.camera},
    {'name': "Gadgets", 'icon': LucideIcons.smartphone},
    {'name': "Gaming", 'icon': LucideIcons.gamepad},
    {'name': "Laptops", 'icon': LucideIcons.laptop},
    {'name': "Smartphones", 'icon': LucideIcons.smartphone},
    {'name': "Wearables", 'icon': LucideIcons.watch},
    {'name': "Smart Homes", 'icon': LucideIcons.cctv},
  ];
  static final List<Widget> carouselItems = [
    ImageFrame(imagePath: "assets/images/carousel1.jpg"),
    ImageFrame(imagePath: "assets/images/carousel2.avif"),
    ImageFrame(imagePath: "assets/images/carousel3.avif"),
    ImageFrame(imagePath: "assets/images/carousel4.jpg"),
    ImageFrame(imagePath: "assets/images/gadget_carousel5.png"),
  ];

  static final List<Widget> detailsCarouselItems = [
    ImageFrame(
      imagePath: "assets/images/carousel1.jpg",
      margin: EdgeInsets.all(8),
    ),
    ImageFrame(
      imagePath: "assets/images/carousel2.avif",
      margin: EdgeInsets.all(8),
    ),
    ImageFrame(
      imagePath: "assets/images/carousel3.avif",
      margin: EdgeInsets.all(8),
    ),
    ImageFrame(
      imagePath: "assets/images/carousel4.jpg",
      margin: EdgeInsets.all(8),
    ),
    ImageFrame(
      imagePath: "assets/images/gadget_carousel5.png",
      margin: EdgeInsets.all(8),
    ),
  ];
}

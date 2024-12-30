import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final Widget? child;
  final ColorFilter? colorFilter;

  const CustomNetworkImage({
    super.key,
    this.child,
    this.colorFilter,
    required this.imageUrl,
    this.backgroundColor,
    required this.height,
    required this.width,
    this.border,
    this.borderRadius,
    this.boxShape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(imageUrl,context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Placeholder while loading
          return Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.6),
            highlightColor: Colors.grey.withOpacity(0.3),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: border,
                color: Colors.grey.withOpacity(0.6),
                borderRadius: borderRadius,
                shape: boxShape,
              ),
            ),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          // Error widget
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              border: border,
              color: Colors.grey.withOpacity(0.6),
              borderRadius: borderRadius,
              shape: boxShape,
            ),
            child: const Icon(Icons.error),
          );
        } else {
          // Successfully loaded image
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              border: border,
              borderRadius: borderRadius,
              shape: boxShape,
              color: backgroundColor,
              image: DecorationImage(
                image: snapshot.data as ImageProvider,
                fit: BoxFit.cover,
                colorFilter: colorFilter,
              ),
            ),
            child: child,
          );
        }
      },
    );
  }

  Future<ImageProvider?> _loadImage(String url,BuildContext context) async {
    try {
      final image = NetworkImage(url);
      await precacheImage(image,context);
      return image;
    } catch (e) {
      return null;
    }
  }
}

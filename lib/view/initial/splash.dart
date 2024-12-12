import 'package:flutter/material.dart';
import 'package:track_trek/core/constant/image_constants.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName='/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
child: Image.asset(splashImgUrl),
      ),
    );
  }
}

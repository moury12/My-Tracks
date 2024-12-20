import 'package:flutter/material.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';

class SeacrchScreen extends StatelessWidget {
  static const String routeName ='/search';
  const SeacrchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: CustomAppbar(
      tile: AppStaticString.search,
    ),

   );
  }
}

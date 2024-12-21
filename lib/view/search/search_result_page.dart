import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_user_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';

class SearchResultScreen extends StatelessWidget {
  static const String routeName='/search-result';
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(HomeUserController());
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.searchResult,
      ),
      body: ListView.builder(itemCount: 5,
        padding: padding16,
        itemBuilder: (context, index) =>TrackCardWidget(fromUser: true,react:HomeUserController.to.react ,) ,),
    );
  }
}

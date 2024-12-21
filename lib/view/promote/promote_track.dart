import 'package:flutter/material.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';

class PromoteTrackScreen extends StatelessWidget {
  static const String routeName ='/promote-tracK';
  const PromoteTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.promoteTrack,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: padding16,
              children: [
                const CustomDropdown(
                  hintText: AppStaticString.selectTrack,
                )
              ],
            ),
          ),
          Padding(
            padding: padding16,
            child: CustomButton(onTap: () {

            },title: AppStaticString.done,),
          )
        ],
      ),
    );
  }
}

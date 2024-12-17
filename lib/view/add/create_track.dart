import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/create_track_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';

import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/upload_image_widget.dart';
import 'package:track_trek/view/add/upload_track.dart';

class CreateTrackScreen extends StatelessWidget {
  static const String routeName = '/create-track';
  const CreateTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tile: AppStaticString.createTrack,
      ),
      body: Padding(
        padding: padding16,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              CustomTextField(
                textEditingController:
                    CreateTrackController.to.trackNameController.value,
                title: AppStaticString.trackName,
                hintText: AppStaticString.typeHere,
              ),
              CustomDropdown(
                title: AppStaticString.selectCategory,
              ),
              UploadImageWidget(),
              CustomTextField(
                textEditingController:
                    CreateTrackController.to.trackLocationController.value,
                title: AppStaticString.location,
                hintText: AppStaticString.typeHere,
              ),
              CustomTextField(
                textEditingController:
                    CreateTrackController.to.trackDescriptionController.value,
                title: AppStaticString.description,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                hintText: AppStaticString.typeHere,
              ),
              CustomButton(
                onTap: () {
                  Get.toNamed(UploadTrackScreen.routeName);
                },
                title: AppStaticString.next,
              )
            ],
          ),
        ),
      ),
    );
  }
}

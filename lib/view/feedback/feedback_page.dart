import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';

class FeedbackScreen extends StatelessWidget {
  static const String routeName ='/feedback';
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tile: AppStaticString.feedback,
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding:padding16,
          child: Column(spacing: 16.h,
            children: [
              CustomTextField(
                title: AppStaticString.email,
              ), CustomTextField(
                title: AppStaticString.description,
                hintText: AppStaticString.typeHere,
             /*   textEditingController: CreateTrackController
                    .to.uploadTrackDescriptionController.value,*/
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(width: MediaQuery.sizeOf(context).width/2,
                    child: RowButton( radius: 8.r, firstButtonText: AppStaticString.cancel, textColor: AppColors.whiteLightColor, secendtButtonText: AppStaticString.send)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

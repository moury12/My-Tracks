import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class ProfileScreen extends StatelessWidget {
  final bool? showAppbar;
  static const String routeName = '/profile';
  const ProfileScreen({super.key,  this.showAppbar=true});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    String? argument = Get.arguments;
    return Scaffold(
      appBar: showAppbar!?const CustomAppbar(
        tile: AppStaticString.profile,
      ):const PreferredSize(
          preferredSize: Size.zero, child: SizedBox.shrink()),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding16,
          child: Column(
            spacing: 16.h,
            children: [
              Stack(
                children: [
                  BlackContainerWidget(
                    radius: 8.r,
                    child: Column(
                      spacing: 6.h,
                      children: [
                        ProfileCircleImageWidget(height: 70.w, width: 70.w),

                        ///====================dynamic name=====================///
                        const UserInfoText(
                          text:
                              '${AppStaticString.nameWithClone}Md. Hasan Khondokar',
                          color: AppColors.whiteLightColor,
                        ),

                        ///====================dynamic email=====================///
                        const UserInfoText(
                          text:
                              '${AppStaticString.emailUser}trtgj@fdsjfgj.xvcvb',
                          color: AppColors.whiteLightColor,
                        ),

                        ///====================dynamic contact=====================///
                        const UserInfoText(
                          text:
                              '${AppStaticString.contactNumber}845454546546545',
                          color: AppColors.whiteLightColor,
                        ),
                      ],
                    ),
                  ),
                  argument != null && argument == 'edit'
                      ? const SizedBox.shrink()
                      : Positioned(
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(ProfileScreen.routeName,
                                    arguments: 'edit');
                              },
                              icon: Image.asset(
                                editIconUrl,
                                height: 18.w,
                                width: 18.w,
                              )),
                        )
                ],
              ),
              CustomTextField(
                title: AppStaticString.name,
                isEnable: argument != null && argument == 'edit' ? true : false,
                textEditingController:
                    ProfileController.to.nameController.value,
              ),
              CustomTextField(
                title: AppStaticString.email,
                isEnable: argument != null && argument == 'edit' ? true : false,
                textEditingController:
                    ProfileController.to.emailController.value,
              ),
              CustomTextField(
                title: AppStaticString.contactNumber,
                isEnable: argument != null && argument == 'edit' ? true : false,
                textEditingController:
                    ProfileController.to.contactNumberController.value,
              ),
              CustomTextField(
                title: AppStaticString.location,
                isEnable: argument != null && argument == 'edit' ? true : false,
                textEditingController:
                    ProfileController.to.locationController.value,
              ),
              argument != null && argument == 'edit'
                  ? CustomButton(
                      onTap: () {},
                      title: AppStaticString.save,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

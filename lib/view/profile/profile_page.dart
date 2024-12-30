import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class ProfileScreen extends StatelessWidget {
  final bool? showAppbar;
  static const String routeName = '/profile';
  const ProfileScreen({super.key, this.showAppbar = true});

  @override
  Widget build(BuildContext context) {
    // Get.put(ProfileController());

    String? argument = Get.arguments;
    return Scaffold(
      appBar: showAppbar!
          ? const CustomAppbar(
              tile: AppStaticString.profile,
            )
          : const PreferredSize(
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
                        Stack(
                          children: [
                            Obx(
                              () =>
                                   ProfileController.to.userModel.value
                                              .profileImage !=
                                          null && ProfileController.to.uploadProfileImg.value.isEmpty
                                      ? CustomNetworkImage(
                                          boxShape: BoxShape.circle,
                                          imageUrl:
                                              '${ApiClient.baseUrl}/${ProfileController.to.userModel.value.profileImage}',
                                          height: 70.w,
                                          width: 70.w):
                                   ProfileController.to.uploadProfileImg.value.isNotEmpty &&
                                       argument != null &&
                                       argument == 'edit'
                                       ? ClipOval(
                                     child: Image.file(
                                         File(ProfileController
                                             .to.uploadProfileImg.value),
                                         height: 70.w,
                                         width: 70.w,fit: BoxFit.cover,),
                                   ): ProfileCircleImageWidget(
                                          height: 70.w, width: 70.w),
                            ),
                            argument != null && argument == 'edit'
                                ? Positioned(
                                    bottom: -10.h,
                                    right: -10.w,
                                    child: IconButton(
                                        onPressed: () async{
                                         await pickImages(

                                              singleImagePath: ProfileController
                                                  .to.uploadProfileImg);

                                        },
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          color: AppColors.whiteLightColor,
                                        )),
                                  )
                                : SizedBox.shrink()
                          ],
                        ),

                        ///====================dynamic name=====================///
                        Obx(() {
                          return UserInfoText(
                            text:
                                '${AppStaticString.nameWithClone}${ProfileController.to.userModel.value.name ?? 'n/a'}',
                            color: AppColors.whiteLightColor,
                          );
                        }),

                        ///====================dynamic email=====================///
                        Obx(() {
                          return UserInfoText(
                            text:
                                '${AppStaticString.emailUser}${ProfileController.to.userModel.value.email ?? 'n/a'}',
                            color: AppColors.whiteLightColor,
                          );
                        }),

                        ///====================dynamic contact=====================///
                        Obx(() {
                          return UserInfoText(
                            text:
                                '${AppStaticString.contactNumber}: ${ProfileController.to.userModel.value.phoneNumber ?? 'n/a'}',
                            color: AppColors.whiteLightColor,
                          );
                        }),
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
              Obx(() {
                return CustomTextField(
                  title: AppStaticString.name,
                  isEnable:
                      argument != null && argument == 'edit' ? true : false,
                  textEditingController:
                      ProfileController.to.nameController.value,
                );
              }),
              Obx(() {
                return CustomTextField(
                  title: AppStaticString.email,
                  isEnable:
                      /*argument != null && argument == 'edit' ? true :*/ false,
                  textEditingController:
                      ProfileController.to.emailController.value,
                );
              }),
              Obx(() {
                return CustomTextField(
                  title: AppStaticString.contactNumber,
                  keyboardType: TextInputType.number,
                  isEnable:
                      argument != null && argument == 'edit' ? true : false,
                  textEditingController:
                      ProfileController.to.contactNumberController.value,
                );
              }),
              Obx(() {
                return CustomTextField(
                  title: AppStaticString.location,
                  isEnable:
                      argument != null && argument == 'edit' ? true : false,
                  textEditingController:
                      ProfileController.to.locationController.value,
                );
              }),
              argument != null && argument == 'edit'
                  ? Obx(
                  () {
                      return CustomButton(
                                      isLoading: ProfileController.to.isLoadingUpdateProfile.value,
                          onTap: ()async {
                           await ProfileController.to.updateProfileRequest();
                          },
                          title: AppStaticString.save,
                        );
                    }
                  )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

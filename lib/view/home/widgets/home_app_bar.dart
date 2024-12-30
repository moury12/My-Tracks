import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/utils/text_style.dart';

class HomeAppBar extends StatelessWidget {
  final Function()? openDrawer;
  const HomeAppBar({
    super.key,
    this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingH16V6,
      child: Row(
        children: [
          Obx(() {
            return ProfileController.to.userModel.value.profileImage != null &&
                    ProfileController
                        .to.userModel.value.profileImage!.isNotEmpty
                ? CustomNetworkImage(
              boxShape: BoxShape.circle,
                    imageUrl:
                        '${ApiClient.baseUrl}/${ProfileController.to.userModel.value.profileImage}',
                    height: 52.w,
                    width: 52.w)
                : Image.asset(
                    dummyProfileImgUrl,
                    height: 52.w,
                  );
          }),
          space12W,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Text(
                  ProfileController.to.userModel.value.name ??
                      AppStaticString.dummyName,
                  style: poppinsMedium.copyWith(
                      fontSize: getFontSizeLarge(context)),
                );
              }),
              Row(
                children: [
                  Image.asset(
                    userLocationIconUrl,
                    height: 21.w,
                  ),
                  Obx(() {
                    return Text(
                      ProfileController.to.userModel.value.address ??
                          AppStaticString.dummyAddress,
                      style: poppinsMedium.copyWith(
                          fontSize: getFontSizeSemiSmall(context)),
                    );
                  })
                ],
              )
            ],
          ),
          Spacer(),
          GestureDetector(
              onTap: openDrawer ?? () {},
              child: Image.asset(
                drawerIconUrl,
                height: 50.w,
              ))
        ],
      ),
    );
  }
}

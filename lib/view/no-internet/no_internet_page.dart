import 'package:flutter/material.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';

class NoInternetScreen extends StatelessWidget {
  static const String routeName = '/no-internet';
  final VoidCallback onRetry;

  const NoInternetScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: padding16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                noInternetImgUrl, // Replace with your image asset
                height: 200,
              ),
              space16H,
              Text(
                AppStaticString.noInternetText,
                style: poppinsMedium.copyWith(
                  fontSize: getFontSizeDefault(context),
                ),
              ),
              space12H,
              Text(
                AppStaticString.pleaseCheckInternet,
                textAlign: TextAlign.center,
                style: poppinsMedium.copyWith(
                    fontSize: getFontSizeSmall(context),
                    color: AppColors.greyColor),
              ),
              space16H,
              CustomButton(
                onTap: () {
                  if (NetworkController.to.isConnected.value) {
                    // Ensure the onRetry function is invoked when there's internet
                    onRetry();
                  } else {
                    noInternetShowCustomSnackbar();
                  }
                },
                title: AppStaticString.retry,
              )

            ],
          ),
        ),
      ),
    );
  }


}

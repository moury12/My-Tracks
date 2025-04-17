import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/auth/auth_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName ='/forget-pass';
   ForgetPasswordScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.forgotPass,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: padding16,
                child:  Form(
                  key:formKey ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      space16H,
                      Text(
                        AppStaticString.forgetPass,
                        style: poppinsMedium.copyWith(
                          color: AppColors.whiteBrightColor,
                            fontSize: getFontSizeExtraLarge(context)),
                      ),   space16H,Text(
                        AppStaticString.enterEmailToSendCode,
                        textAlign: TextAlign.center,
                        style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSemiSmall(context)),
                      ),
                      space16H,
                      CustomTextField(

                        textEditingController:
                        AuthController.to.emailForgetController,
                        title: AppStaticString.email,
                        hintText: AppStaticString.emailEnter,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                  return AppStaticString.emailRequired;
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return AppStaticString.enterValidEmail;
                                }
                                return null;
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: padding16.copyWith(bottom: 24.sp),
            child: Obx(
             () {
                return CustomButton(
                  isLoading: AuthController.to.isLoadingForgetPass.value,
                  onTap: (){
                if(formKey.currentState!.validate()){
                  AuthController.to.forgetPassRequest();
                }
                },title:AppStaticString.sendCode ,);
              }
            ),
          )
        ],
      ),
      ///==============send code for reset pass ==========================///
     
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/text_style.dart';

class PrivacyTermsScreen extends StatelessWidget {
  static const String routeName ='/privacy-terms';
  const PrivacyTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? argument =Get.arguments;
    return Scaffold(
      appBar:  CustomAppbar(tile:argument!=null&&argument=='terms'?AppStaticString.termsCondition: AppStaticString.privacyPolicy,),
      body: Padding(
        padding:padding16,
        child:  SingleChildScrollView(
          child: Center(
///===================dynamic text=========================///
            child: Text(''
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)'

            ,style: poppinsRegular.copyWith(fontSize: getFontSizeDefault(context)),) ),
        ),
      ),
    );
  }
}
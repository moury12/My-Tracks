import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/feedback/feedback_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
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
      body: Obx(
         () {
           final isLoading =  argument != null && argument == 'terms'?FeedBackController.to.isLoadingTerms.value:FeedBackController.to.isLoadingPrivacy.value;
          return isLoading?
              const DefaultProgressIndicator():Padding(
            padding:padding16,
            child:  SingleChildScrollView(
              child: Center(
          ///===================dynamic text=========================///
                child:
                /*Text(argument!=null&&argument=='terms'?
                FeedBackController.to.terms.value.description??''
                    :FeedBackController.to.policy.value.description??'',
                  style: poppinsRegular.copyWith(fontSize:
                  getFontSizeDefault(context)),) */
              HtmlWidget(
                  '''${argument!=null&&argument=='terms'?
               FeedBackController.to.terms.value.description??''
                   :FeedBackController.to.policy.value.description ?? ''
           }''',textStyle: poppinsRegular.copyWith(fontSize:
                  getFontSizeDefault(context)),
              )),
            ),
          );
        }
      ),
    );
  }
}
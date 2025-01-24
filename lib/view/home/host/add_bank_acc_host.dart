import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/host/stripe_onboarding_controller.dart';
import 'package:track_trek/controller/home/host/stripe_onboarding_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddBankAccHost extends StatelessWidget {
  static const String routeName ='/add-bank';
  const AddBankAccHost({super.key});

  @override
  Widget build(BuildContext context) {
    if (StripeOnboardingController.to.webController == null) {
      StripeOnboardingController.to.initializeWebViewController();
    }
    return Scaffold(
      appBar:CustomAppbar(tile: AppStaticString.stripeOnboarding,),
      body: Stack(
        children: [
          WebViewWidget(controller: StripeOnboardingController.to.webController!),
          Obx(
                () => StripeOnboardingController.to.isLoading.value
                ? const Center(
              child: DefaultProgressIndicator(),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
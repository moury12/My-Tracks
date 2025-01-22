import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatelessWidget {
  static const String routeName = '/payment';

  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final commonController = CommonController.to;

    // Initialize WebViewController if not already done
    if (commonController.webController == null) {
      commonController.initializeWebViewController();
    }

    return Scaffold(
      appBar:CustomAppbar(tile: AppStaticString.payment,),
      body: Stack(
        children: [
          WebViewWidget(controller: commonController.webController!),
          Obx(
                () => commonController.isLoading.value
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

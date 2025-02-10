import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  static const String routeName = '/payment';

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
  @override
  void dispose() {
    CommonController.to.webController=null;
    CommonController.to.stripeUrl.value='';
    // TODO: implement dispose
    super.dispose();
  }
}

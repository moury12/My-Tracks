import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/initial/splash.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  static const String routeName = '/payment';
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController webController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)

      ..setUserAgent('Mozilla/5.0 (Mobile; rv:52.0) Gecko/52.0 Firefox/52.0')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading status based on progress.
            setState(() {
              isLoading = progress < 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onHttpError: (HttpResponseError error) {
            showCustomSnackbar(
                title: AppStaticString.failed,
                message: error.toString(),
                type: SnackBarType.failed);
          },
          onWebResourceError: (WebResourceError error) {
            showCustomSnackbar(
                title: AppStaticString.failed,
                message: error.toString(),
                type: SnackBarType.failed);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(CommonController.to.stripeUrl.value)) {
              return NavigationDecision.prevent;
            }
            if(request.url.contains('http://10.0.60.26:8001/payment/success')){
              Get.offAllNamed(SplashScreen.routeName);

            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(CommonController.to.stripeUrl.value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tile: AppStaticString.payment,),
      body: Stack(
        children: [
          WebViewWidget(controller: webController),
          if (isLoading)
            const Center(
              child: DefaultProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

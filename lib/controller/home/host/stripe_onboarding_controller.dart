import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/add/create_track_event_page.dart';
import 'package:track_trek/view/home/host/add_bank_acc_host.dart';
import 'package:track_trek/view/initial/splash.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/service/manage/manage_service.dart';

class StripeOnboardingController extends GetxController {
  static StripeOnboardingController get to => Get.find();
  RxString webUrl = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isWebViewLoading = false.obs;
  RxBool isHostVerified = false.obs;
  WebViewController? webController;
  isHostAddBankAcc({required String argument}) async {
    if (NetworkController.to.isConnected.value) {
      isLoading.value = true;
      isHostVerified.value = await ManageService.getSinglePayoutInfo();
      if (isHostVerified.value) {
        isLoading.value = false;
        Get.toNamed(CreateTrackEventScreen.routeName, arguments: argument);
      } else {
        Get.put(StripeOnboardingController());
        isLoading.value = true;
        final String onboardingUrl = await ManageService.redirectToStripeInfo();

        if (onboardingUrl.isNotEmpty) {
          webUrl.value = onboardingUrl;
          isLoading.value = false;
          Get.toNamed(AddBankAccHost.routeName);
        } else {
          showCustomSnackbar(
              title: AppStaticString.failed,
              message: 'Please restart the app',
              type: SnackBarType.failed);
        }
      }
    } else {
      /*  isLoadingPostLike.value = false;*/
      noInternetShowCustomSnackbar();
    }
  }

  void initializeWebViewController() {
    if (webController != null) {
      return; // Avoid re-initialization
    }
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent('Mozilla/5.0 (Mobile; rv:52.0) Gecko/52.0 Firefox/52.0')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("WebView progress: $progress");
            isLoading.value = progress < 100;
          },
          onPageStarted: (String url) {
            debugPrint("Page started loading: $url");
            isLoading.value = true;
          },
          onPageFinished: (String url) {
            debugPrint("Page finished loading: $url");
            isLoading.value = false;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint("HTTP Error: ${error}");
            Get.snackbar('Error', 'HTTP Error: ',
                snackPosition: SnackPosition.BOTTOM);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("Web Resource Error: ${error.description}");
            Get.snackbar('Error', error.description,
                snackPosition: SnackPosition.BOTTOM);
          },
         onNavigationRequest: (NavigationRequest request) {
           if (request.url.startsWith(ApiClient.baseUrlWithoutPort)) {
             // Allow navigation to your local development server
             return NavigationDecision.navigate;
           }
            //  if (request.url.contains('${ApiClient.baseUrl}/payment/return')) {
            //   Get.offAllNamed(SplashScreen.routeName);
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(webUrl.value));
  }

  @override
  void onClose() {
    webController = null; // Clear WebViewController
    super.onClose();
  }
}

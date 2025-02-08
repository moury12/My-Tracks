import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking/book_track_join_event_controller.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutBookingScreen extends StatelessWidget {
  static const String routeName = '/checkout-booking';

  const CheckoutBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingController = BookTrackJoinEventController.to;
debugPrint('-------------------check out url-----------------------');
debugPrint(bookingController.checkoutUrl.value);
    // Initialize WebViewController if not already done
    if (bookingController.webController == null) {
      bookingController.initializeWebViewController();

    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        bookingController.checkoutUrl.value = "";
        bookingController.webController=null;
      },
      child: Scaffold(
        appBar:CustomAppbar(tile: AppStaticString.payment,),
        body: Stack(
          children: [
            WebViewWidget(controller: bookingController.webController!),
            Obx(
                  () => bookingController.isLoading.value
                  ? const Center(
                child: DefaultProgressIndicator(),
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
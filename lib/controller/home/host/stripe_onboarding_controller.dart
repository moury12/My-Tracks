import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/home/host/add_bank_acc_host.dart';

import '../../../core/service/manage/manage_service.dart';

class StripeOnboardingController extends GetxController {
  static StripeOnboardingController get to => Get.find();
  RxString webUrl = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isHostVerified = false.obs;

  isHostAddBankAcc() async {
    if (NetworkController.to.isConnected.value) {
      StripeOnboardingController.to.isLoading.value = true;
      isHostVerified.value = await ManageService.getSinglePayoutInfo();
      if (isHostVerified.value) {
        StripeOnboardingController.to.isLoading.value = false;
      } else {
        Get.put(StripeOnboardingController());
        StripeOnboardingController.to.isLoading.value = true;
        final String onboardingUrl = await ManageService.redirectToStripeInfo();

        if (onboardingUrl.isNotEmpty) {
          StripeOnboardingController.to.webUrl.value = onboardingUrl;
          StripeOnboardingController.to.isLoading.value = false;
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
}

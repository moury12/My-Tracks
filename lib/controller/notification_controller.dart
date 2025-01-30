import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/notification/Notification_model.dart';
import 'package:track_trek/core/service/notification/notification_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class NotificationController extends GetxController {
  static NotificationController get to =>Get.find();
  RxList<NotificationModel> notifyList = <NotificationModel>[].obs;
  RxBool isLoadingNotification = false.obs;
  getNotification() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingNotification.value = true;
      notifyList.value = await NotificationService.getNotificationList();
      if (notifyList.isNotEmpty) {
        isLoadingNotification.value = false;
      } else {
        isLoadingNotification.value = false;
         
      }
    } else {
      isLoadingNotification.value = false;
      // noInternetShowCustomSnackbar();
    }
  }
  Future<void> refreshCall()async{
    await  getNotification();;

    notifyList.refresh();

  }
  @override
  void onInit() {
   refreshCall();
    // TODO: implement onInit
    super.onInit();
  }
}

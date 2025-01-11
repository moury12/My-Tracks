import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/model/manage/manage_model.dart';
import 'package:track_trek/core/service/manage/manage_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class FeedBackController extends GetxController {
  static FeedBackController get to => Get.find();

  ///==================== controller variable =====================///

  TextEditingController userNameController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  ///===================Loading variable ===========================///

  RxBool isLoadingFeedbackPost = false.obs;
  RxBool isLoadingPrivacy = false.obs;
  RxBool isLoadingTerms= false.obs;

  ///================== dynamic object variable =========================///

  Rx<ManageModel> terms = ManageModel().obs;
  Rx<ManageModel> policy = ManageModel().obs;


  getPrivacyPolicyCall() async {
     if (NetworkController.to.isConnected.value) {
        isLoadingPrivacy.value = true;
        policy.value = await ManageService.getPrivacyPolicy(
        );
        if (policy.value.sId != null) {
           isLoadingPrivacy.value = false;
        } else {
           isLoadingPrivacy.value = false;
        }
     } else {
        isLoadingPrivacy.value = false;
        noInternetShowCustomSnackbar();
     }
  }
  getTermsConditionCall() async {
     if (NetworkController.to.isConnected.value) {
        isLoadingTerms.value = true;
        terms.value = await ManageService.getTermsCondition(
        );
        if (terms.value.sId != null) {
           isLoadingTerms.value = false;
        } else {
           isLoadingTerms.value = false;
        }
     } else {
        isLoadingTerms.value = false;
        noInternetShowCustomSnackbar();
     }
  }

  postFeedBackCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingFeedbackPost.value = true;
      bool postedFeedback = await ManageService.postFeedbackRequest(
          feedback: feedbackController.text, userName: userNameController.text);
      if (postedFeedback) {
         feedbackController.clear();
         userNameController.clear();
        isLoadingFeedbackPost.value = false;
      } else {
        isLoadingFeedbackPost.value = false;
      }
    } else {
      isLoadingFeedbackPost.value = false;
      noInternetShowCustomSnackbar();
    }
  }
  @override
  void onInit() {
     getPrivacyPolicyCall();
     getTermsConditionCall();
    // TODO: implement onInit
    super.onInit();
  }
}

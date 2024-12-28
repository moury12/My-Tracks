import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/model/user_model.dart';
import 'package:track_trek/core/service/user_service.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  RxBool loadingUserData =false.obs;
Rx<UserModel> userModel =UserModel().obs;
  ///=====================add dynmic name ====================///
  Rx<TextEditingController> nameController =
      TextEditingController(text: 'Khushi akter').obs;

  ///=====================add dynmic email ====================///
  Rx<TextEditingController> emailController =
      TextEditingController(text: 'youremail@gmail.com').obs;

  ///=====================add dynmic contactNumber ====================///
  Rx<TextEditingController> contactNumberController =
      TextEditingController(text: '+999 68526546 65').obs;

  ///=====================add dynmic location ====================///
  Rx<TextEditingController> locationController =
      TextEditingController(text: '4140 Parker Rd. Allentown, New Mexico 31134')
          .obs;
  getUserProfileData()async{
    loadingUserData.value = true;
    userModel.value = await UserService.getUserData();
    loadingUserData.value=false;
  }
  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    locationController.value.dispose();
    contactNumberController.value.dispose();
    super.onClose();
  }
}

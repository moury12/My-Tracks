import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

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
  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    locationController.value.dispose();
    contactNumberController.value.dispose();
    super.onClose();
  }
}

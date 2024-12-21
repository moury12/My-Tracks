import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find();
  var selectedOption = 0.obs;
  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  RxString image=''.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
          source: source, maxWidth: 800, maxHeight: 800, imageQuality: 70);

      if (pickedFile != null) {
        image.value = pickedFile.path;
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }
}

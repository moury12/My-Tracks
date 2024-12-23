import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/constant/image_constants.dart';

class HomeUserController extends GetxController{
  static HomeUserController get to =>Get.find();
  RxInt currentPage =0.obs;
  RxInt selectedCategory =0.obs;
  RxBool react =false.obs;
  Timer? timer;
  Rx<PageController> controller = PageController(
    initialPage: 0,
      viewportFraction: 0.9, keepPage: true).obs;
  List<String> pages =[dummyBannerUrl,dummyBanner2Url,dummyEventImgUrl];
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (currentPage.value < pages.length - 1) {
          currentPage.value++;
        } else {
          currentPage.value = 0;
        }

        if (controller.value.hasClients) {
          controller.value.animateToPage(
            currentPage.value,
            duration: const Duration(milliseconds:400),
            curve: Curves.linear,
          );
        }
      });
    });
    super.onInit();
  }

}
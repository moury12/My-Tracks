import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BookTrackJoinEventController extends GetxController{
  static BookTrackJoinEventController get to => Get.find();
  RxInt currentIndex= 0.obs;
  Rx<PageController> pageController = PageController(initialPage: 0).obs;
}
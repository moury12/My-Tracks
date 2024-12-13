import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/constant/app_strings.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RxList<String> tabs = [AppStaticString.track, AppStaticString.event].obs;
  var tabContent = <Widget>[

  ].obs;
}

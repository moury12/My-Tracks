import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/constant/app_strings.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var selectedLabel = 0.obs;
  RxList<String> tabs = [AppStaticString.track, AppStaticString.event].obs;
  RxList<String> labelTabs = [AppStaticString.running,'', AppStaticString.booked].obs;
  var tabContent = <Widget>[

  ].obs;
}

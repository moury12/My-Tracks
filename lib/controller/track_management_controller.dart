import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/constant/app_strings.dart';

class TrackManagementController extends GetxController {
  static TrackManagementController get to => Get.find();
  RxList<String> tabs = <String>[
    AppStaticString.track,
    AppStaticString.event,
    AppStaticString.renters
  ].obs;
  var tabContent = <Widget>[].obs;
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/constant/app_strings.dart';

class BookingManagementController extends GetxController{
  static BookingManagementController get to =>Get.find();
  var selectedLabel = 0.obs;
  RxList<String> tabs = [AppStaticString.track, AppStaticString.event].obs;
  RxList<String> labelTabs = [AppStaticString.runningBooking, AppStaticString.history].obs;
  var tabContent = <Widget>[

  ].obs;
}
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

double getFontSizeSmall(BuildContext context) =>
context.width >= 1300 ? 15.sp : 12.sp;
 double getFontSizeSemiSmall(BuildContext context) =>
context.width >= 1300 ? 15.sp : 13.sp;
 double getFontSizeDefault(BuildContext context) =>
context.width >= 1300 ? 17.sp : 14.sp;
 double getFontSizeLarge(BuildContext context) =>
context.width >= 1300 ? 20.sp : 16.sp;
 double getFontSizeExtraLarge(BuildContext context) =>
context.width >= 1300 ? 20.sp : 18.sp;
 double getButtonFontSize(BuildContext context) =>
context.width >= 1300 ? 26.sp : 20.sp;
 double getButtonFontSizeLarge(BuildContext context) =>
context.width >= 1300 ? 30.sp : 24.sp;

 double getFontSizeOverLarge(BuildContext context) =>
context.width >= 1300 ? 56.sp : 46.sp;
 double getFontSizeForReview(BuildContext context) => 36.sp;
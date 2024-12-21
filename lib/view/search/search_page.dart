import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/search/search_result_page.dart';
import 'package:track_trek/view/search/widgets/search_widget.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.search,
      ),
      body: Padding(
        padding: padding16,
        child: Column(
          children: [
            CustomTextField(
              onTap: () {
                Get.toNamed(SearchScreen.routeName);
              },
              hintText: AppStaticString.searchHerr,
              prefixIcon: Padding(
                padding: padding8,
                child: Image.asset(
                  searchIconUrl,
                  height: 24.w,
                  width: 24.w,
                ),
              ),
            ),
            space12H,
           ...List.generate(5, (index) =>   SearchAddress(onTap: () {
             Get.toNamed(SearchResultScreen.routeName);
           },),)
          ],
        ),
      ),
    );
  }
}


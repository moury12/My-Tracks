import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/home_app_bar.dart';

import 'widgets/gradient_container_widget.dart';
import 'widgets/track_card_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    HomeController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Column(
        children: List.generate(5, (i) => const TrackCardWidget()),
      ),
    ));
    HomeController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Column(
        children: List.generate(
            5,
            (i) => BlackContainerWidget(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(dummyEventImgUrl)),
                       space12H,
                       Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(

                            children: [
                              Text(AppStaticString.dummyEvent,style: poppinsMedium.copyWith(fontSize:getFontSizeSmall(context)),),
                              Text(

                                  '${AppStaticString.locationWithClone}Rock hill boston',maxLines: 1,overflow: TextOverflow.ellipsis,
                                  style: poppinsRegular.copyWith(fontSize:getFontSizeSmall(context)))
                            ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                          )),space16W,
                          Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                  '${AppStaticString.dateWithClone} 05 january ',maxLines: 1,overflow: TextOverflow.ellipsis,
                                  style: poppinsRegular.copyWith(fontSize:getFontSizeSmall(context))),
                              Text(AppStaticString.dummyTime,maxLines: 1,overflow: TextOverflow.ellipsis,
                                  style: poppinsRegular.copyWith(fontSize:getFontSizeSmall(context)))
                            ],
                          ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${AppStaticString.priceWithClone}\$120'),
                          Image.asset(
                            verticalDividerImgUrl,
                            height: 10.w,
                          ),
                          Text('${AppStaticString.totalSlot}20'),
                          Image.asset(
                            verticalDividerImgUrl,
                            height: 10.w,
                          ),
                          Text('${AppStaticString.unsold}10'),
                        ],
                      ),
                      space16H,
                      RichText(text:  TextSpan(children:[
                        TextSpan(
                          text: AppStaticString.dummyDesc,style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSmall(context),
                            color: AppColors.fadeWhiteColor
                        ),
                        ),
                        TextSpan(text: AppStaticString.seeMore,style: poppinsSemiBold.copyWith(
                            fontSize: getFontSizeSmall(context)
                        ),)
                      ])),
                      space16H,
                      CustomButton(onTap: (){},child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppStaticString.viewAllParticipent,style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackLightColor,
                              fontSize: getFontSizeSemiSmall(context))),
                          space8W,
                          Image.asset(arrowTopImgUrl,height: 24.w,)
                        ],),)
                    ],
                  ),
                )),
      ),
    ));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
            Expanded(
                child: ListView(
              padding: padding16,
              children: [
                Row(
                  children: [
                    const GradientContainerWidget(),
                    space24W,
                    const Expanded(
                        child: BlackContainerWidget(
                      text: AppStaticString.booked,
                    ))
                  ],
                ),
                DynamicTabWidget(
                  tabs: HomeController.to.tabs,
                  tabContent: HomeController.to.tabContent,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

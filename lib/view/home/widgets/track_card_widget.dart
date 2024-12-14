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
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

class TrackCardWidget extends StatelessWidget {
  const TrackCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12T,
      child: BlackContainerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: padding14V,
              child: ClipRRect(borderRadius: BorderRadius.circular(8.r),child: Image.asset(dummyEventImgUrl)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child:  Text(AppStaticString.dummyEvent,style: poppinsMedium.copyWith(
                    fontSize: getFontSizeLarge(context)
                ),)),

                space16W,
                Expanded(
                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(locationIconUrl,height: 24.w,),
                      space6W,
                      Expanded(child:  Text(AppStaticString.dummyAddress,style: poppinsMedium.copyWith(
                          fontSize: getFontSizeSmall(context)
                      ),))
                    ],),
                )
              ],
            ),
            space16H,
            RichText(text:  TextSpan(children:[
              TextSpan(
                text: AppStaticString.dummyDesc,style: poppinsRegular.copyWith(
                  fontSize: getFontSizeSmall(context),

              ),
              ),
              TextSpan(text: AppStaticString.seeMore,style: poppinsSemiBold.copyWith(
                  fontSize: getFontSizeSmall(context)
              ),)
            ])),
            space16H,
            Text('${AppStaticString.totalSlot}10',style: poppinsSemiBold.copyWith(
                fontSize: getFontSizeLarge(context)
            ),),
            space16H,
      Row(
        children: [
      Flexible(flex: 5,
        child: SizedBox(height: 45.w,
          child: Stack(
            children: List.generate(5, (index)=>Positioned(left: (30*index).toDouble(),
                child: ClipOval(child: Image.asset(dummyProfileImgUrl,height: 45.w,width: 45.w,fit: BoxFit.cover,)))),
          ),
        ),
      ),
      space8W,
      Flexible(flex: 4,
          child: CustomButton(onTap: (){},child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(AppStaticString.viewAll,style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.blackLightColor,
                fontSize: getFontSizeSemiSmall(context))),
            space8W,
            Image.asset(arrowTopImgUrl,height: 24.w,)
          ],),))
        ],
      ),space16H,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OptionWidget(icon: commentIconUrl, text: '120',),
                OptionWidget(icon: reactIconUrl, text: '120',),
                OptionWidget(icon: mapIconUrl, text: AppStaticString.map,),
                OptionWidget(icon: shareIconUrl, text: AppStaticString.share,),
              ],)
          ],
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  final String icon;
  final String text;
  const OptionWidget({
    super.key, required this.icon, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.asset(icon,height: 24.sp,),
      space6W,
      Text(text,style: poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),)
    ],);
  }
}
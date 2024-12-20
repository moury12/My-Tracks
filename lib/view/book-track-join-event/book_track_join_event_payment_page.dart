import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/manage/widgets/blue_container_widget.dart';

class BookTrackJoinEventPaymentScreen extends StatelessWidget {
  static const String routeName ='/track-event-payment';
  const BookTrackJoinEventPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? argument = Get.arguments;
    return Scaffold(
appBar: CustomAppbar(
  tile: argument!=null&& argument==event?AppStaticString.joinEvent:AppStaticString.bookTrackSlot,
),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:padding16,
                child: Column(
            
                  children: [
                    SizedBox(width: double.infinity,
                      child: BlueContainerWidget(
            
                        child: Column(
                          children: [
                            Text(AppStaticString.priceAmount,style: poppinsRegular.copyWith(
                              color: AppColors.blackLightColor,
                                fontSize: getButtonFontSizeLarge(context)),),
                            ///=======================dynamic price=====================///
                            Text('\$12.00',style: poppinsMedium.copyWith(
                                color: AppColors.blackLightColor,
                                fontSize: getButtonFontSizeLarge(context))),
            
                          ],
                        ),
                      ),
            
                    ),
            space12H,
                    argument!=null&& argument==event? Column(  spacing: 12.h,
                      children: [
                        CustomDropdown(
                          title: AppStaticString.selectPeople,
            
                        ),
                        CustomTextField(
                          title: AppStaticString.drivingLicence,
                        ),CustomTextField(
                          title: AppStaticString.carLicence,
                        ),CustomTextField(
                          title: AppStaticString.contactNumber,
                        )
            
                      ],
                    ):
                    CustomDropdown(
                      title: AppStaticString.selectPeople,
            
                    ),
                    space12H,
            
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: padding16,
            child: CustomButton(onTap: () {

            },title: AppStaticString.goPay,),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/book_track_join_event_controller.dart';
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
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/manage/widgets/blue_container_widget.dart';

class BookTrackJoinEventPaymentScreen extends StatelessWidget {
  static const String routeName = '/track-event-payment';
  const BookTrackJoinEventPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? argument = Get.arguments;
    return Scaffold(
      appBar: CustomAppbar(
        tile: argument != null && argument == event
            ? AppStaticString.joinEvent
            : AppStaticString.bookTrackSlot,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: padding16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: BlueContainerWidget(
                        child: Column(
                          children: [
                            Text(
                              AppStaticString.priceAmount,
                              style: poppinsRegular.copyWith(
                                  color: AppColors.blackLightColor,
                                  fontSize: getButtonFontSizeLarge(context)),
                            ),

                            ///=======================dynamic price=====================///
                            Text('\$12.00',
                                style: poppinsMedium.copyWith(
                                    color: AppColors.blackLightColor,
                                    fontSize: getButtonFontSizeLarge(context))),
                          ],
                        ),
                      ),
                    ),
                    space8H,
                    const BlueTextWidget(
                      text:
                          '${AppStaticString.allowedPeople} 30   ${AppStaticString.unsold} 10',
                      textAlign: TextAlign.start,
                    ),
                    space12H,
                    Obx(
                     () {
                        return CustomDropdown<int>(
                          title: AppStaticString.selectPeople,
                          items: BookTrackJoinEventController.to.memberList,
                          selectedValue: BookTrackJoinEventController
                              .to.selectedValue.value,
                          onChanged: (value) {

                            BookTrackJoinEventController
                                .to.selectedValue.value =value;
                            BookTrackJoinEventController.to.updateSubSelectedValue();
                          },
                        );
                      }
                    ),
                    space16H,
                    argument != null && argument == event
                        ? Obx(
                          () {
                            return Column(

                                                  children: List.generate(BookTrackJoinEventController
                              .to.selectedValue.value??0, (index) => Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 12.h,
                            children: [
                              Text('People ${BookTrackJoinEventController
                                  .to.memberList[index]}:',style: poppinsMedium.copyWith(fontSize: getFontSizeLarge(context)),),
                              const CustomTextField(
                                title: AppStaticString.drivingLicence,
                              ),
                              CustomDropdown<String>(
                                title: AppStaticString.bookingFor,
                                items: BookTrackJoinEventController.to.bookingForList,
                                selectedValue: BookTrackJoinEventController
                                    .to.subSelectedValue[index],
                                onChanged: (value) {
                                  print('----------------------');

                                  BookTrackJoinEventController
                                      .to.subSelectedValue[index] =value;

                                },

                              ),
                              const CustomTextField(
                                title: AppStaticString.carLicence,
                              ),
                              const CustomTextField(
                                title: AppStaticString.contactNumber,
                              ),
                              Row(
                                children: [
                                  Expanded(child: SizedBox.shrink()),
                                  Expanded(child: CustomButton(onTap: () {

                                  },
                                  title: AppStaticString.save,
                                  fillColor: AppColors.blueColor,borderColor: AppColors.blueColor,)),
                                ],
                              ),
                              space12H
                            ],
                                                  ),),
                                                );
                          }
                        )
                        :space12H,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: padding16,
            child: CustomButton(
              onTap: () {},
              title: AppStaticString.goPay,
            ),
          )
        ],
      ),
    );
  }
}

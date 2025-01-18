import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking/book_track_join_event_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/manage/widgets/blue_container_widget.dart';

class BookTrackPaymentScreen extends StatefulWidget {
  static const String routeName = '/track-payment';
  const BookTrackPaymentScreen({super.key});

  @override
  State<BookTrackPaymentScreen> createState() => _BookTrackPaymentScreenState();
}

class _BookTrackPaymentScreenState extends State<BookTrackPaymentScreen> {
  Map<String, dynamic> argument = {};
  TrackSlots slot = TrackSlots();
  String price = '\$0';
  @override
  void initState() {
    argument = Get.arguments;
    slot = argument['slot'];
    price = slot.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tile: AppStaticString.bookTrackSlot,
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
                            Text('\$$price',
                                style: poppinsMedium.copyWith(
                                    color: AppColors.blackLightColor,
                                    fontSize: getButtonFontSizeLarge(context)))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: CustomTextField(
                        textEditingController: BookTrackJoinEventController
                            .to.peopleNumberController.value,
                        title: AppStaticString.selectPeople,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: padding16,
            child: Obx(() {
              return CustomButton(
                isLoading:
                    BookTrackJoinEventController.to.isLoadingBookTrack.value,
                onTap: () {
                  if (slot is TrackSlots) {
                    BookTrackJoinEventController.to
                        .bookTrackSlotCall(slotId: slot.sId ?? '');
                  }
                },
                title: AppStaticString.goPay,
              );
            }),
          )
        ],
      ),
    );
  }
}

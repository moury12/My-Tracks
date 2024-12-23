import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:track_trek/controller/book_track_join_event_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/upload_track.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_payment_page.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class BookTrackJoinEventScreen extends StatelessWidget {
  static const String routeName = '/book-join-track-event';
  const BookTrackJoinEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? argument = Get.arguments;
    return Scaffold(
      appBar:  CustomAppbar(
        tile:argument != null && argument == event
            ?AppStaticString.joinEvent :AppStaticString.bookTRack,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding16V,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: padding16H,
                    child: SizedBox(
                      height: 160.h,
                      child: PageView.builder(
                        controller: BookTrackJoinEventController
                            .to.pageController.value,
                        itemCount: 5,
                        itemBuilder: (context, index) => BlackContainerWidget(
                          padding: padding16H,
                          child: Image.asset(dummyEventImgUrl,fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(iconCircleWithBorderUrl))),
                      child: IconButton(
                          highlightColor: BookTrackJoinEventController
                                      .to.currentIndex.value >
                                  0
                              ? Colors.white10
                              : Colors.transparent,
                          onPressed: () {
                            if (BookTrackJoinEventController
                                    .to.currentIndex.value >
                                0) {
                              BookTrackJoinEventController
                                  .to.currentIndex.value--;
                              BookTrackJoinEventController
                                  .to.pageController.value
                                  .animateToPage(
                                      BookTrackJoinEventController
                                          .to.currentIndex.value,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                            }
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_sharp,
                            color: BookTrackJoinEventController
                                        .to.currentIndex.value >
                                    0
                                ? AppColors.normalDarkWhite
                                : null,
                          )),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(iconCircleWithBorderUrl))),
                      child: IconButton(
                          highlightColor: BookTrackJoinEventController
                                      .to.currentIndex.value >
                                  0
                              ? Colors.white10
                              : Colors.transparent,
                          onPressed: () {
                            BookTrackJoinEventController
                                .to.currentIndex.value++;
                            BookTrackJoinEventController.to.pageController.value
                                .animateToPage(
                                    BookTrackJoinEventController
                                        .to.currentIndex.value,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                          },
                          icon: const Icon(Icons.arrow_forward_ios)),
                    ),
                  ),
                ],
              ),
              space16H,
              Padding(
                padding: padding16H,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.h,
                  children: [
                    Row(
                      spacing: 6.w,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            spacing: 6.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///===========dynamic event name================///
                              Text(
                                AppStaticString.dummyEvent,
                                style: poppinsMedium.copyWith(
                                    fontSize: getFontSizeExtraLarge(context)),
                              ),

                              ///===========dynamic event location================///

                              Text(
                                '${AppStaticString.locationWithClone} Stockton, New Hampshire',
                                style: poppinsRegular.copyWith(
                                    fontSize: getFontSizeDefault(context)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: argument != null && argument == event
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ///===========dynamic event date================///

                                      Text(
                                        '${AppStaticString.dateWithClone}05 january',
                                        style: poppinsRegular.copyWith(
                                            fontSize:
                                                getFontSizeSmall(context)),
                                      ),

                                      ///===========dynamic event time ================///
                                      Text(
                                        AppStaticString.dummyTime,
                                        style: poppinsRegular.copyWith(
                                            fontSize:
                                                getFontSizeSmall(context)),
                                      ),
                                    ],
                                  )
                                : SelectDateButton()),
                      ],
                    ),
                    argument != null && argument == event
                        ? BlueTextWidget(
                            text:
                                '${AppStaticString.allowedPeople} 30   ${AppStaticString.unsold} 10',
                            textAlign: TextAlign.start,
                          )
                        : SizedBox.shrink(),
                    ExpandableText(text: AppStaticString.dummyDesc),

                    ...List.generate(
                      6,
                      (index) => MarronGradientContainerWidget(
                        child: TrackSlotWidget(
                          onTap: () {
                            Get.toNamed(BookTrackJoinEventPaymentScreen.routeName,arguments: argument);
                          },
                          argument: userPanel,
                          needToShowSeat: argument != null && argument == event
                              ? true
                              : false,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

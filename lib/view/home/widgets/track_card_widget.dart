import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/controller/home_user_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/review/review_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/track_for_user_panel.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_page.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

import '../../../core/global/string_variable.dart';

class TrackCardWidget extends StatelessWidget {
  final bool? fromManage;
  final bool? fromUser;
  final bool? fromPromote;
  final RxBool? react;
  final SingleTrackModel? trackModel;
  final TrackForUserPanelModel? trackModelUserPanel;
  final Function()? onActive;
  final Function()? onDeactivate;
  const TrackCardWidget({
    super.key,
    this.fromManage = false,
    this.fromUser = false,
    this.react,
    this.trackModel,
    this.onActive,
    this.onDeactivate,
    this.trackModelUserPanel,
    this.fromPromote = false,
  });

  @override
  Widget build(BuildContext context) {
    List<ReviewModel> reviewListVar =[];
    final String imageUrl = trackModel != null
        ? '${ApiClient.baseUrl}/${trackModel!.trackImage!.first}'
        : trackModelUserPanel != null
            ? '${ApiClient.baseUrl}/${trackModelUserPanel!.trackImage!.first}'
            : '';
    final String imageHostUrl = trackModel != null
        ? ''
        : trackModelUserPanel != null
            ? '${ApiClient.baseUrl}/${trackModelUserPanel!.host!.profileImage}'
            : '';
    final String sId = trackModel != null
        ? trackModel!.sId ?? ''
        : trackModelUserPanel != null
            ? trackModelUserPanel!.sId ?? ''
            : '';
    final String name = trackModel != null
        ? trackModel!.trackName ?? ''
        : trackModelUserPanel != null
            ? trackModelUserPanel!.trackName ?? ''
            : 'n/a';
    final String totalSlot = trackModel != null
        ? trackModel!.slots!.length.toString()
        : trackModelUserPanel != null
            ? trackModelUserPanel!.slots!.length.toString()
            : 'n/a';
    final String location = trackModel != null
        ? trackModel!.address ?? ''
        : trackModelUserPanel != null
            ? trackModelUserPanel!.address ?? ''
            : 'n/a';
    final bool isReact = trackModel != null
        ? false
        : trackModelUserPanel != null
            ? trackModelUserPanel!.isLiked??false
            : false;
    final String description = trackModel != null
        ? trackModel!.description ?? ''
        : trackModelUserPanel != null
            ? trackModelUserPanel!.description ?? ''
            : 'n/a';
    final String totalComment = trackModel != null
        ? trackModel!.totalReview.toString()
        : trackModelUserPanel != null
            ? trackModelUserPanel!.totalReview.toString()
            : 'n/a';
    final String totalReaction = trackModel != null
        ? trackModel!.totalLikes.toString()
        : trackModelUserPanel != null
            ? trackModelUserPanel!.totalLikes.toString()
            : 'n/a';
    final double lat = trackModel != null
        ? trackModel!.location!.coordinates!.last.toDouble()
        : trackModelUserPanel != null
            ? trackModelUserPanel!.location!.coordinates!.last.toDouble()
            : 0.0;
    final double lng = trackModel != null
        ? trackModel!.location!.coordinates!.first.toDouble()
        : trackModelUserPanel != null
            ? trackModelUserPanel!.location!.coordinates!.first.toDouble()
            : 0.0;
    final String hostName = trackModel != null
        ? 'n/a'
        : trackModelUserPanel != null
            ? trackModelUserPanel!.host!.name ?? ''
            : 'n/a';
    final String rating = trackModel != null
        ? '4.5'
        : trackModelUserPanel != null
            ? (trackModelUserPanel!.rating ?? '0.0').toString()
            : '0.0';
    return Padding(
      padding: padding12T,
      child: BlackContainerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CustomNetworkImage(
                        imageUrl: imageUrl,
                        height: 150.h,
                        width: double.infinity)
                    ),
            space12H,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  name,
                  style: poppinsMedium.copyWith(
                      fontSize: getFontSizeLarge(context)),
                )),
                space16W,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        locationIconUrl,
                        height: 24.w,
                      ),
                      space6W,

                      ///======================dynamic address===================///

                      Expanded(
                          child: Text(
                        location,
                        style: poppinsMedium.copyWith(
                            fontSize: getFontSizeSmall(context)),
                      ))
                    ],
                  ),
                )
              ],
            ),
            space12H,

            ///====================dynamic description =====================///
            ExpandableText(
              text: description,
              maxLines: 3, // Number of lines to show before truncating
            ),

            space12H,
            fromUser == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///======================dynamic user profile img=======================///

                      imageHostUrl.isNotEmpty
                          ? CustomNetworkImage(
                              imageUrl: imageHostUrl,
                              height: 45.w,
                              width: 45.w,
                              boxShape: BoxShape.circle,
                              imageErrorUrl: dummyProfileImgUrl,
                            )
                          : const ProfileCircleImageWidget(),
                      space8W,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hostName,
                              style: poppinsLight.copyWith(
                                  fontSize: getFontSizeSmall(context)),
                            ),
                            RatingTextWidget(rating: rating),
                          ],
                        ),
                      ),
                      DividerVertical(
                        height: 24.h,
                      ),

                      ///======================dynamic user total slot=======================///

                      Expanded(
                          child: Text(
                        textAlign: TextAlign.center,
                        '${AppStaticString.slotWithClone} $totalSlot',
                        style: poppinsLight.copyWith(
                            fontSize: getFontSizeSmall(context)),
                      ))
                    ],
                  )

                ///======================dynamic total slot=======================///

                : Text(
                    '${AppStaticString.totalSlot}${trackModel != null ? trackModel!.slots != null ? trackModel!.slots!.length : '0' : '0'}',
                    style: poppinsSemiBold.copyWith(
                        fontSize: getFontSizeLarge(context)),
                  ),
            fromUser == true ? const SizedBox.shrink() : space12H,
            fromManage == true || fromUser == true || fromPromote == true
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: SizedBox(
                          height: 45.w,
                          child: Stack(
                            children: List.generate(
                                trackModel != null
                                    ? trackModel!.renters != null
                                        ? trackModel!.renters!.length > 5
                                            ? 5
                                            : trackModel!.renters!.length
                                        : 0
                                    : 5,
                                (index) => Positioned(
                                    left: (30.w * index).toDouble(),
                                    child: trackModel != null &&
                                            trackModel!.renters != null
                                        ? CustomNetworkImage(
                                            imageUrl:
                                                '${ApiClient.baseUrl}/${trackModel!.renters![index].profileImage}',
                                            height: 45.w,
                                            width: 45.w,
                                            boxShape: BoxShape.circle,
                                            imageErrorUrl: dummyProfileImgUrl,
                                          )
                                        : const ProfileCircleImageWidget())),
                          ),
                        ),
                      ),
                      space8W,
                      Flexible(
                          flex: 4,
                          child: CustomButton(
                            onTap: () {
                              Get.toNamed(
                                EventTrackSlotScreen.routeName,
                                arguments: {
                                  'slots': trackModel!.slots,
                                  'type': 'track'
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppStaticString.viewAllSlot,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.blackLightColor,
                                        fontSize:
                                            getFontSizeSemiSmall(context))),
                                space8W,
                                Image.asset(
                                  arrowTopImgUrl,
                                  height: 24.w,
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
            fromManage == true ? const SizedBox.shrink() : space12H,

            fromPromote == true
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///================comments==============///
                      OptionWidget(
                        icon: commentIconUrl,
                        function: () {

                          if (Boxes.getUserData().get(roleKey) == 'USER') {
                            HomeUserController.to
                                .getTrackReviewListCall(trackId: sId);
                            reviewListVar = HomeUserController.to.reviewList;
                          } else {
                            HomeController.to
                                .getTrackReviewListCall(trackId: sId);
                            reviewListVar = HomeUserController.to.reviewList;
                          }
                          showModalBottomSheet(
                            constraints: BoxConstraints.tightForFinite(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                            ),
                            context: context,
                            isScrollControlled:
                                true, // Allows better control of the height and width
                            builder: (context) =>  ReviewListWidget(
                              reviewList: reviewListVar,
                            ),
                          );
                        },
                        text: totalComment,
                      ),

                      ///================react==============///

                      /*CommonController.to.isLoadingPostLike.value?DefaultProgressIndicator(color: AppColors.whiteLightColor,):*/ OptionWidget(
                                function: () {
                                 CommonController.to.postLikeDisLikeCall(trackId: sId);

                                },
                                icon:/* react!.value*/ isReact== true
                                    ? reactFillIconUrl
                                    : reactIconUrl,
                                text: totalReaction,
                              ),

                      ///================map==============///

                      OptionWidget(
                        icon: mapIconUrl,
                        text: AppStaticString.map,
                        function: () {
                          _showMapBottomSheet(
                            context,
                            lat,
                            lng,
                          );
                        },
                      ),
                      fromManage == true
                          ? const SizedBox.shrink()

                          ///================share==============///

                          : OptionWidget(
                              function: () async {
                                await Share.share(
                                    'Check out this cool Flutter app!');
                              },
                              icon: shareIconUrl,
                              text: AppStaticString.share,
                            ),
                    ],
                  ),
            fromManage == true ? space12H : const SizedBox.shrink(),
            fromManage == true
                ? Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: onDeactivate ?? () {},
                          fillColor: Colors.transparent,
                          borderColor: AppColors.redColor,
                          // height: 48.h,
                          title: AppStaticString.deactivate,
                          textColor: AppColors.redColor,
                        ),
                      ),
                      space12W,

                      ///========================active button========================///
                      Expanded(
                        child: CustomButton(
                          fillColor: AppColors.greenColor,
                          borderColor: AppColors.greenColor,
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => DefaultDialogWithButton(
                                secondButtonTap: onActive,
                                content: Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: Text(
                                    AppStaticString.areYouSureWantToReactivate,
                                    textAlign: TextAlign.center,
                                    style: poppinsRegular.copyWith(
                                        fontSize: getFontSizeDefault(context),
                                        color: AppColors.whiteLightColor),
                                  ),
                                ),
                                textColor: AppColors.redColor,
                                borderColor: AppColors.marronColor,
                                firstButtonText: AppStaticString.no,
                                secendtButtonText: AppStaticString.yes,
                              ),
                            );
                          },
                          // height: 48.h,
                          title: AppStaticString.active,
                        ),
                      )
                    ],
                  )
                : const SizedBox.shrink(),
            fromUser == true
                ? Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: CustomButton(
                      onTap: () {

                        Get.toNamed(BookTrackJoinEventScreen.routeName,arguments: {'id':sId,
                        'type':'track'});
                      },
                      title: AppStaticString.bookSlot,
                      img: doubleArrowIconUrl,
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void _showMapBottomSheet(
      BuildContext context, double latitude, double longitude) {
    showModalBottomSheet(
      constraints: BoxConstraints.tightForFinite(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
      ),
      context: context,
      isScrollControlled: true, // Allows full-screen height if needed
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: GoogleMap(
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 14, // Set a more focused zoom level
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false, // Custom button added
                zoomControlsEnabled: false, // Custom zoom controls added
                markers: {
                  Marker(
                    markerId: const MarkerId("selected_location"),
                    position: LatLng(latitude, longitude),
                    infoWindow: const InfoWindow(
                      title: "Selected Location",
                      snippet: "This is the chosen spot.",
                    ),
                  ),
                },
              ),
            ),
            // Custom zoom controls
          ],
        );
      },
    );
  }
}

class RatingTextWidget extends StatelessWidget {
  const RatingTextWidget({
    super.key,
    required this.rating,
  });

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.w,
      children: [
        Text(
          AppStaticString.ratingWithClone,
          style: poppinsLight.copyWith(
              fontSize: getFontSizeSmall(context)),
        ),
        Icon(
          Icons.star_border_outlined,
          color: AppColors.yellowColor,
          size: 15.sp,
        ),
    
        ///======================dynamic user rating=======================///
        Text(
          rating,
          style: poppinsLight.copyWith(
              fontSize: getFontSizeSmall(context)),
        )
      ],
    );
  }
}

class ReviewListWidget extends StatelessWidget {
  final List<ReviewModel> reviewList;
  const ReviewListWidget({
    super.key,
    required this.reviewList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        // color: Colors.white, // Background color for the bottom sheet
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: SingleChildScrollView(
        child: Obx(() {
          return reviewList.isEmpty
              ? const EmptyTextWidget(text: 'Review not found!!')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        AppStaticString.comments,
                        style: poppinsMedium.copyWith(
                          fontSize: getFontSizeSmall(context),
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey[300]),
                    ...List.generate(
                      reviewList.length,
                      (index) {
                        final review = reviewList[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  review.user!.profileImage != null
                                      ? CustomNetworkImage(
                                          imageUrl:
                                              review.user!.profileImage ?? '',
                                          height: 45.w,
                                          width: 45.w,
                                          imageErrorUrl: dummyProfileImgUrl,
                                          boxShape: BoxShape.circle,
                                        )
                                      : const ProfileCircleImageWidget(),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// User name and duration
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${review.user!.name ?? AppStaticString.dummyName} ',
                                                style: poppinsRegular.copyWith(
                                                  fontSize: getFontSizeDefault(
                                                      context),
                                                ),
                                              ),
                                              TextSpan(
                                                text: formatTimestamp(
                                                    timestamp:
                                                        review.createdAt ?? ''),
                                                style: poppinsRegular.copyWith(
                                                  color:
                                                      AppColors.normalDarkWhite,
                                                  fontSize:
                                                      getFontSizeSmall(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 6.0),
                                        RatingTextWidget(rating: review.rating!=null?review.rating.toString():'0.0'),

                                        ///===================== Comment text =================///
                                        Text(
                                          review.review.toString(),
                                          style: poppinsRegular.copyWith(
                                            color: const Color(0xffD2D2D2),
                                            fontSize:
                                                getFontSizeDefault(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[300]),
                          ],
                        );
                      },
                    ),
                  ],
                );
        }),
      ),
    );
  }
}

class ProfileCircleImageWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const ProfileCircleImageWidget({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Image.asset(
      dummyProfileImgUrl,
      height: height ?? 45.w,
      width: width ?? 45.w,
      fit: BoxFit.cover,
    ));
  }
}

class OptionWidget extends StatelessWidget {
  final String icon;
  final String text;
  final Function()? function;
  const OptionWidget({
    super.key,
    required this.icon,
    required this.text,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Row(
        children: [
          Image.asset(
            icon,
            height: 24.sp,
          ),
          space6W,
          Text(
            text,
            style: poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),
          )
        ],
      ),
    );
  }
}
class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final TextStyle? buttonStyle;
  final int maxLines;

  const ExpandableText({
    super.key,
    required this.text,
    this.textStyle,
    this.buttonStyle,
    this.maxLines = 2,
  });

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  bool _isTextOverflowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkTextOverflow();
      }
    });
  }

  @override
  void didUpdateWidget(covariant ExpandableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _checkTextOverflow();
        }
      });
    }
  }

  void _checkTextOverflow() {
    final textStyle = widget.textStyle ??
        poppinsRegular.copyWith(
          fontSize: getFontSizeSmall(context),
        );

    final textSpan = TextSpan(text: widget.text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    if (textPainter.didExceedMaxLines) {
      if (mounted) {
        setState(() {
          _isTextOverflowing = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isTextOverflowing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.text,
          style: widget.textStyle ??
              poppinsRegular.copyWith(
                fontSize: getFontSizeSmall(context),
              ),
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (_isTextOverflowing)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'See Less' : AppStaticString.seeMore,
              style: widget.buttonStyle ??
                  poppinsSemiBold.copyWith(
                    fontSize: getFontSizeSmall(context),
                  ),
            ),
          ),
      ],
    );
  }
}


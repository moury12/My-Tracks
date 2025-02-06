import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/create_track_event_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/add/widgets/upload_image_widget.dart';
import 'package:track_trek/view/add/widgets/black_container_with_border.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';
import 'package:track_trek/view/search/widgets/search_widget.dart';

class CreateTrackEventScreen extends StatelessWidget {
  static const String routeName = '/create-track-event';
  CreateTrackEventScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? argument = Get.arguments;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        CreateTrackEventController.to.clearAfterPop();
      },
      child: Scaffold(
        appBar: CustomAppbar(
          tile: argument != null && argument == event
              ? AppStaticString.createEvent
              : AppStaticString.createTrack,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: padding16,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6.h,
                children: [
                  CustomTextField(
                    isRequired: true,
                    textEditingController: argument != null && argument == event
                        ? CreateTrackEventController
                            .to.eventNameController.value
                        : CreateTrackEventController
                            .to.trackNameController.value,
                    title: argument != null && argument == event
                        ? AppStaticString.eventName
                        : AppStaticString.trackName,
                    hintText: AppStaticString.typeHere,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStaticString.fieldRequired;
                      }
                      return null;
                    },
                  ),
                  space6H,
                  argument != null && argument == event
                      ? GestureDetector(
                          onTap: () async {
                            CreateTrackEventController
                                .to
                                .eventStartDateController
                                .value
                                .text = await selectDate(context);
                          },
                          child: Obx(() {
                            return CustomTextField(
                              isEnable: false,
                              textEditingController: CreateTrackEventController
                                  .to.eventStartDateController.value,
                              title: AppStaticString.startDate,
                              isRequired: true,
                              hintText: AppStaticString.typeHere,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStaticString.fieldRequired;
                                }
                                return null;
                              },
                            );
                          }),
                        )
                      : Obx(() {
/*
                        CreateTrackEventController.to.categoryListCall();
*/
                          return CustomDropdown<String>(
                            isLoading: CreateTrackEventController
                                .to.isLoadingCategory.value,
                            title: AppStaticString.selectCategory,
                            isRequired: true,
                            items:
                                CreateTrackEventController.to.catList.isNotEmpty
                                    ? CreateTrackEventController.to.catList
                                        .map(
                                          (element) => element.name.toString(),
                                        )
                                        .toList()
                                    : [],
                            onChanged: (value) {
                              /*  CreateTrackEventController
                                  .to.categoryListCall();*/
                              CreateTrackEventController
                                  .to.selectedCategory.value = value.toString();
                            },
                          );
                        }),
                  argument != null && argument == event
                      ? GestureDetector(
                          onTap: () async {
                            CreateTrackEventController.to.selectedEventStartTime
                                .value = await selectAndFormatTime(
                                    context: context,
                                    initialTime:
                                        const TimeOfDay(hour: 10, minute: 0)) ??
                                '';
                          },
                          child: Obx(() {
                            return CustomDropdown(
                              isRequired: true,
                              hintColor: AppColors.whiteLightColor,
                              /*selectedValue:CreateTrackEventController.to.selectedEventStartTime
                                  .value ,*/
                              hintText: CreateTrackEventController.to
                                      .selectedEventStartTime.value.isNotEmpty
                                  ? CreateTrackEventController
                                      .to.selectedEventStartTime.value
                                  : AppStaticString.typeHere,
                              title: AppStaticString.startTime,
                            );
                          }),
                        )
                      : const SizedBox.shrink(),
                  argument != null && argument == event
                      ? GestureDetector(
                          onTap: () async {
                            CreateTrackEventController.to.eventEndDateController
                                .value.text = await selectDate(context);
                          },
                          child: Obx(() {
                            return CustomTextField(
                              isEnable: false,
                              textEditingController: CreateTrackEventController
                                  .to.eventEndDateController.value,
                              title: AppStaticString.endDate,
                              isRequired: true,
                              hintText: AppStaticString.typeHere,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStaticString.fieldRequired;
                                }
                                return null;
                              },
                            );
                          }),
                        )
                      : const SizedBox.shrink(),
                  argument != null && argument == event
                      ? GestureDetector(
                          onTap: () async {
                            CreateTrackEventController.to.selectedEventEndTime
                                .value = await selectAndFormatTime(
                                    context: context,
                                    initialTime:
                                        const TimeOfDay(hour: 10, minute: 0)) ??
                                '';
                          },
                          child: Obx(() {
                            return CustomDropdown(
                              isRequired: true,
                              hintColor: AppColors.whiteLightColor,
                              /*selectedValue:CreateTrackEventController.to.selectedEventStartTime
                                  .value ,*/
                              hintText: CreateTrackEventController
                                      .to.selectedEventEndTime.value.isNotEmpty
                                  ? CreateTrackEventController
                                      .to.selectedEventEndTime.value
                                  : AppStaticString.typeHere,
                              title: AppStaticString.endTime,
                            );
                          }),
                        )
                      : const SizedBox.shrink(),

                  ///===============================upload images================================///
                  Obx(() {
                    return UploadImageWidget(
                        isRequired: true,
                        function: () {
                          pickImages(
                              allowMultiple: true,
                              uploadImages: CreateTrackEventController
                                  .to.trackPhotosList);
                        },
                        images: CreateTrackEventController
                                .to.trackPhotosList.isNotEmpty
                            ? Wrap(
                                children: [
                                  ...List.generate(
                                    CreateTrackEventController
                                        .to.trackPhotosList.length,
                                    (index) => Stack(
                                      children: [
                                        Padding(
                                          padding: padding12,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            child: Image.file(
                                              File(CreateTrackEventController
                                                  .to.trackPhotosList[index]),
                                              height: 70.w,
                                              width: 70.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: -5.w,
                                          top: -5.h,
                                          child: IconButton(
                                              onPressed: () {
                                                removeImage(
                                                    uploadImages:
                                                        CreateTrackEventController
                                                            .to.trackPhotosList,
                                                    imagePath:
                                                        CreateTrackEventController
                                                                .to
                                                                .trackPhotosList[
                                                            index]);
                                              },
                                              icon: const Icon(
                                                CupertinoIcons
                                                    .multiply_circle_fill,
                                                color: AppColors.primaryColor,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  CreateTrackEventController
                                              .to.trackPhotosList.length <
                                          5
                                      ? Padding(
                                          padding: padding8,
                                          child: UploadImageIconTextWidget(
                                            function: () {
                                              pickImages(
                                                  allowMultiple: true,
                                                  uploadImages:
                                                      CreateTrackEventController
                                                          .to.trackPhotosList);
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink()
                                ],
                              )
                            : null);
                  }),
                  space6H,
                  Obx(() {
                    return CommonController.to.isLoadingOnFetch.value
                        ? Center(
                            child: DefaultProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStaticString.fieldRequired;
                              }
                              return null;
                            },
                            title: AppStaticString.location,
                            isRequired: true,
                            onChanged: (val) {
                              CommonController.to.fetchSuggestedPlaces(val);
                            },
                            hintText: AppStaticString.typeHere,
                            textEditingController:
                                argument != null && argument == event
                                    ? CreateTrackEventController
                                        .to.eventLocationController.value
                                    : CreateTrackEventController
                                        .to.trackLocationController.value,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                          );
                  }),
                  Obx(() {
                    return CommonController.to.isLoadingOnFetch.value
                        ? SizedBox.shrink()
                        : CommonController
                                .to.isLoadingOnLocationSuggestion.value
                            ? Center(
                              child: DefaultProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                            )
                            : Column(
                                children: List.generate(
                                  CommonController.to.addressSuggestion.length,
                                  (index) {
                                    final address = CommonController
                                        .to.addressSuggestion[index];
                                    return SearchAddress(
                                      onTap: () async {
                                        CommonController
                                            .to.isLoadingOnFetch.value = true;
                                        final placeId = address['place_id'];
                                        await CommonController.to
                                            .getLatLngFromPlace(placeId,
                                                lat: CreateTrackEventController
                                                    .to.destinationLat,
                                                lng: CreateTrackEventController
                                                    .to.destinationLng,
                                                selectedAddress:
                                                    CreateTrackEventController
                                                        .to.selectedAddress);
                                        if (argument != null &&
                                            argument == event) {
                                          CreateTrackEventController
                                                  .to
                                                  .eventLocationController
                                                  .value
                                                  .text =
                                          address['description'];
                                        } else {
                                          CreateTrackEventController
                                                  .to
                                                  .trackLocationController
                                                  .value
                                                  .text =
                                          address['description'];
                                        }

                                        CommonController.to.addressSuggestion
                                            .clear();
                                        CommonController
                                            .to.isLoadingOnFetch.value = false;
                                      },
                                      title: address['description'],
                                    );
                                  },
                                ),
                              );
                  }),
                  space6H,
                  CustomTextField(
                    textEditingController: argument != null && argument == event
                        ? CreateTrackEventController
                            .to.eventDescriptionController.value
                        : CreateTrackEventController
                            .to.trackDescriptionController.value,
                    title: AppStaticString.description,
                    maxLines: 4,
                    isRequired: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStaticString.fieldRequired;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    hintText: AppStaticString.typeHere,
                  ),
                  argument != null && argument == event
                      ? const SizedBox(
                          width: double.infinity,
                          child: BlackContainerWithBroder())
                      : const SizedBox.shrink(),
                  argument != null && argument == event
                      ? const Row(
                          children: [
                            Spacer(),
                            AddButtonInContainer(),
                          ],
                        )
                      : const SizedBox.shrink(),

                  Obx(() {
                    return CreateTrackEventController
                            .to.eventNameControllerList.isNotEmpty
                        ? Column(
                            children: List.generate(
                              CreateTrackEventController
                                  .to.eventNameControllerList.length,
                              (index) => Padding(
                                padding: padding6V,
                                child: CustomTextField(
                                  title: CreateTrackEventController
                                      .to.eventNameControllerList[index],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }),
                  Obx(() {
                    return CustomButton(
                      isLoading: argument != null && argument == event
                          ? CreateTrackEventController
                              .to.isLoadingPostEvent.value
                          : CreateTrackEventController
                              .to.isLoadingPostTrack.value,
                      onTap: () {
                        if (formKey.currentState!
                                .validate() /*&&
                            CreateTrackEventController
                                    .to.selectedCategory.value !=
                                null &&
                            CreateTrackEventController
                                .to.trackPhotosList.isNotEmpty*/
                            ) {
                          if (argument != null && argument == event) {
                            CreateTrackEventController.to.postEventRequest();
                          } else {
                            CreateTrackEventController.to.postTrackRequest();
                          }
                        } else {
                          showCustomSnackbar(
                              title: AppStaticString.failed,
                              message: AppStaticString.fieldRequired,
                              type: SnackBarType.failed);
                        }
                      },
                      title: argument != null && argument == event
                          ? AppStaticString.createEvent
                          : AppStaticString.createTrack,
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

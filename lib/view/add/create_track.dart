import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/create_event_controller.dart';
import 'package:track_trek/controller/create_track_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';

import 'package:track_trek/core/constant/padding_constant.dart';

import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/add/upload_image_widget.dart';
import 'package:track_trek/view/add/upload_track.dart';
import 'package:track_trek/view/add/widgets/black_container_with_border.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';

class CreateTrackScreen extends StatelessWidget {
  static const String routeName = '/create-track';
  const CreateTrackScreen({super.key});


  @override
  Widget build(BuildContext context) {
    String? argument = Get.arguments;
    return Scaffold(
      appBar: CustomAppbar(
        tile: argument != null && argument == 'event'
            ? AppStaticString.createEvent
            : AppStaticString.createTrack,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6.h,
            children: [
              CustomTextField(
                textEditingController: argument != null && argument == 'event'
                    ? CreateEventController.to.eventNameController.value
                    : CreateTrackController.to.trackNameController.value,
                title: argument != null && argument == 'event'
                    ? AppStaticString.eventName
                    : AppStaticString.trackName,
                hintText: AppStaticString.typeHere,
              ),
              space6H,
              argument != null && argument == 'event'
                  ? CustomTextField(
                      textEditingController: CreateEventController
                          .to.eventStartDateController.value,
                      title: AppStaticString.startDate,
                      hintText: AppStaticString.typeHere,
                    )
                  :  Obx(() {
                return CustomDropdown<String>(
                  title: AppStaticString.selectCategory,
                  items: CreateEventController.to.catList.isNotEmpty
                      ? CreateEventController.to.catList.map((element) => element.name.toString(),).toList()
                      : [],
                  onChanged: (value) {
                    CreateTrackController.to.selectedCategory.value=value.toString();
                  },
                );
              }),
              argument != null && argument == 'event'
                  ? const CustomDropdown(
                      title: AppStaticString.startTime,
                    )
                  : const SizedBox.shrink(),
              argument != null && argument == 'event'
                  ? CustomTextField(
                      textEditingController:
                          CreateEventController.to.eventEndDateController.value,
                      title: AppStaticString.endDate,
                      hintText: AppStaticString.typeHere,
                    )
                  : const SizedBox.shrink(),
              argument != null && argument == 'event'
                  ? const CustomDropdown(
                      title: AppStaticString.endTime,
                    )
                  : const SizedBox.shrink(),

              ///===============================upload images================================///
              Obx(() {
                return UploadImageWidget(
                    function: () {
                      pickImages(
                          allowMultiple: true,
                          uploadImages:
                              CreateTrackController.to.trackPhotosList);
                    },
                    images: CreateTrackController.to.trackPhotosList.isNotEmpty
                        ? Wrap(
                            children: [
                              ...List.generate(
                                CreateTrackController.to.trackPhotosList.length,
                                (index) => Stack(
                                  children: [
                                    Padding(
                                      padding: padding12,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: Image.file(
                                          File(CreateTrackController
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
                                                    CreateTrackController
                                                        .to.trackPhotosList,
                                                imagePath: CreateTrackController
                                                    .to.trackPhotosList[index]);
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.multiply_circle_fill,
                                            color: AppColors.primaryColor,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              CreateTrackController.to.trackPhotosList.length <
                                      5
                                  ? Padding(
                                      padding: padding8,
                                      child: UploadImageIconTextWidget(
                                        function: () {
                                          pickImages(
                                              allowMultiple: true,
                                              uploadImages:
                                                  CreateTrackController
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
              CustomTextField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '';
                  }
                  return null;
                },
                title: AppStaticString.location,
                hintText: AppStaticString.typeHere,
                textEditingController: argument != null && argument == 'event'
                    ? CreateEventController.to.eventLocationController.value
                    : CreateTrackController.to.trackLocationController.value,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onChanged: (value) async{
               await searchLocation(value, destinationLng:CreateTrackController.to.destinationLng,destinationLat: CreateTrackController.to.destinationLat, locationSuggestions: CreateTrackController.to.locationSuggestions );

                },

              ),
              Obx(() {
                return CreateTrackController.to.locationSuggestions.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: CreateTrackController.to.locationSuggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = CreateTrackController.to.locationSuggestions[index];
                    return ListTile(
                      title: Text(suggestion.address), // Display the address
                      onTap: () {
                        debugPrint('------------------------lat long---------------------');
                        // Handle the selection of a suggestion
                        CreateTrackController.to.destinationLat.value = suggestion.lat.toString();
                        CreateTrackController.to.destinationLng.value = suggestion.lng.toString();
                        debugPrint('Selected Lat: ${CreateTrackController.to.destinationLat.value} Selected lng: ${CreateTrackController.to.destinationLng.value}');
                      },
                    );
                  },
                );
              }),
              space6H,
              CustomTextField(
                textEditingController: argument != null && argument == 'event'
                    ? CreateEventController.to.eventDescriptionController.value
                    : CreateTrackController.to.trackDescriptionController.value,
                title: AppStaticString.description,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                hintText: AppStaticString.typeHere,
              ),
              argument != null && argument == 'event'
                  ? const SizedBox(
                      width: double.infinity, child: BlackContainerWithBroder())
                  : const SizedBox.shrink(),
              argument != null && argument == 'event'
                  ? const Row(
                      children: [
                        Spacer(),
                        AddButtonInContainer(),
                      ],
                    )
                  : const SizedBox.shrink(),
              CreateEventController.to.eventNameControllerList.isNotEmpty
                  ? Obx(() {
                      return Column(
                        children: List.generate(
                          CreateEventController
                              .to.eventNameControllerList.length,
                          (index) => CustomTextField(
                            title: CreateEventController
                                .to.eventNameControllerList[index],
                          ),
                        ),
                      );
                    })
                  : const SizedBox.shrink(),
              Obx(
                () {
                  return CustomButton(
                    isLoading:CreateTrackController.to.isLoadingPostTrack.value,
                    onTap: () {
                      if( argument != null && argument == 'event'){

                      }else{
                        CreateTrackController.to.postTrackRequest();
                      }
                    },
                    title: AppStaticString.next,
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}

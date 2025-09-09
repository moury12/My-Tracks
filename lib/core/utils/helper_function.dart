import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/location/place_search_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/view/add/widgets/multiple_date_picker.dart';
import 'package:track_trek/view/auth/login.dart';

enum SnackBarType { success, failed, alert }

void showCustomSnackbar({
  required String title,
  required String message,
  required SnackBarType type,
  SnackPosition position = SnackPosition.BOTTOM, // Default position
}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: AppColors.blackBackgroundColor.withValues(alpha:.5),
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.all(12),
    colorText: AppColors.whiteLightColor,
    dismissDirection: DismissDirection.horizontal,
    icon: Image.asset('assets/logo.png'),
    /*   Icon(
      icon,
      color: Colors.white,
      size: 30,
    ),*/
    snackPosition: position,
    duration: const Duration(
        seconds: 3), // Duration for how long the snackbar will be displayed
  );
}
Future<void> preloadImagesFromUrls(
    List<String> imageUrls) async {
  for (var imageUrl in imageUrls) {
    if (imageUrl.isNotEmpty) {
      try {
        final imageProvider = CachedNetworkImageProvider(imageUrl);
        final completer = Completer<void>();
        bool isCompleted = false;

        imageProvider.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener((_, __) {
            if (!isCompleted) {
              completer.complete();
              isCompleted = true;
            }
          }, onError: (error, stackTrace) {
            if (!isCompleted) {
              debugPrint("Error caching URL: $imageUrl / $error");
              completer.complete();
              isCompleted = true;
            }
          }),
        );

        await completer.future;
      } catch (e) {
        debugPrint("Exception while caching URL: $imageUrl / $e");
      }
    }
  }
}

Future<void> pickImages({
  bool allowMultiple = false,
  RxList<String>? uploadImages,
  RxString? singleImagePath,
})
async {
  try {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Restrict to image files
        allowMultiple: allowMultiple,
        allowCompression: true,
        compressionQuality: 50 // Allow multiple selection
        );

    if (result != null) {
      final selectedPaths = result.paths.whereType<String>().toList();

      if (allowMultiple && uploadImages != null) {
        if (uploadImages.length + selectedPaths.length <= 5) {
          uploadImages.addAll(selectedPaths); // Add selected images to the list
        } else {
          showCustomSnackbar(
            title: "Limit Reached",
            message: "You can only add up to 5 images.",
            type: SnackBarType.alert,
          );
        }
      } else if (!allowMultiple && singleImagePath != null) {
        singleImagePath.value = result.files.single.path ?? '';
      } else {
        debugPrint("No files selected or improper usage of the method.");
      }
    } else {
      debugPrint("No files selected.");
    }
  } catch (e) {
    debugPrint("File picker error: $e");
  }
}

void removeImage(
    {required RxList<String> uploadImages, required String imagePath}) {
  if (uploadImages.contains(imagePath)) {
    uploadImages.remove(imagePath);
  } else {
    debugPrint("Image not found in the list.");
  }
}

Future<void> searchLocation(String address,
    {required Rx<String?> destinationLat,
    required Rx<String?> destinationLng,
    required RxList<LocationSuggestion> locationSuggestions}) async {
  if (address.isEmpty) {
    destinationLat.value = null;
    destinationLng.value = null;
    locationSuggestions.value = []; // Reset if the address is empty
    return;
  }

  try {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      locationSuggestions.value = locations.map((location) {
        // Create LocationSuggestion objects with address and LatLng
        return LocationSuggestion(
            address: address, lat: location.latitude, lng: location.longitude);
      }).toList();
      destinationLat.value = locations.last.latitude.toString();
      destinationLng.value = locations.last.longitude.toString();
    } else {
      destinationLat.value = null;
      destinationLng.value = null;
      locationSuggestions.value = [];
      // No result found, reset
      // showCustomSnackbar(
      //     title: 'Error',
      //     message: 'No results found for the provided address.',
      //     type: SnackBarType.failed);
    }
  } catch (e) {
    destinationLat.value = null;
    destinationLng.value = null;
    locationSuggestions.value = []; // Reset on error
/*    showCustomSnackbar(
        title: 'Error',
        message: 'Failed to fetch location. Please try again.',
        type: SnackBarType.failed);*/
  }
}

void noInternetShowCustomSnackbar() {
  return showCustomSnackbar(
    title: AppStaticString.failed,
    message: AppStaticString.noInternetText,
    type: SnackBarType.failed,
  );
}

Future<String?> selectAndFormatTime({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  try {
    final ThemeData customTimePickerTheme = Theme.of(context).copyWith(
      timePickerTheme: TimePickerThemeData(

        backgroundColor:
            AppColors.blackLightColor, // Background color of the dialog
        hourMinuteShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        dialHandColor: AppColors.blueColor,
        hourMinuteTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? Colors.white // Text color when selected
                : Colors.grey[300]!),
        hourMinuteColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.blueColor // Background color when selected
                : Colors.grey[800]!),
        dialBackgroundColor: Colors.grey[800], // Dial's background color
        dialTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? Colors.white // Dial text color when selected
                : Colors.grey[400]!),
        entryModeIconColor: AppColors.blueColor, // Color of the entry mode icon
      ),
    );
    // Show time picker dialog
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: customTimePickerTheme,
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      // Format the selected time
      final now = DateTime.now();
      final formattedTime = DateFormat.jm().format(
        DateTime(
            now.year, now.month, now.day, pickedTime.hour, pickedTime.minute),
      ).replaceAll('\u202F', ' ');
      return formattedTime; // Return the formatted time
    } else {
      return null; // No time selected
    }
  } catch (e) {
    debugPrint('Error picking time: $e');
    return null;
  }
}

void logOutCall() {
  Boxes.getUserData().delete(tokenKey);
  Boxes.getUserData().delete(roleKey);
  Boxes.getUserData().clear();
  Get.delete<ProfileController>();
  Get.offAllNamed(LoginScreen.routeName);
}
void showCalendarDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(colors: [AppColors.blueColor,AppColors.blueColorDark])),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MultipleDatePicker(
                  preSelectedDates: [
                    DateTime(2021, 3, 2),
                    DateTime(2021, 3, 14),
                    DateTime(2021, 3, 21),
                  ],
                  onDateSelected: (List<DateTime> selected) {
                    // setState(() {
                    //   selectedDates = selected;
                    // });
                  },
                ),
                // const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomButton(
                      textColor:Colors.black,
                        borderColor:Colors.black,
                        fillColor: Colors.transparent,
                        radius: 20.r,
                        onTap: () {
                        Navigator.pop(context);
                        },
                        title: AppStaticString.cancel,
                      ),
                    ),
                    space12W,
                    Expanded(
                      child: CustomButton(
borderColor: Colors.black,
                        fillColor: Colors.black,
                        radius: 20.r,
                        onTap: () {  Navigator.pop(context); },
                        textColor: Colors.white,
                        title: AppStaticString.confrim,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<String> selectDate(
  BuildContext context,
) async {
  final DateTime? pickedDate = await showDatePicker(
    barrierDismissible: false,

    // builder: (context, child) {
    //   return Theme(
    //
    //
    //     child: child!,
    //   );
    // },
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    // Format the date
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    // Update the observable
    return formattedDate;
  }
  return ''; // Return null if no date is selected
}

String formatTimestamp({
  required String timestamp,
  String format = 'yyyy-MM-dd hh:mm a',
  bool toLocal = true,
}) {
  try {
    // Parse the timestamp
    DateTime parsedDate = DateTime.parse(timestamp);

    // Convert to local timezone if required
    if (toLocal) {
      parsedDate = parsedDate.toLocal();
    }

    // Format the date using the provided format
    return DateFormat(format).format(parsedDate);
  } catch (e) {
    // Handle parsing or formatting errors
    return '';
  }
}

String formatDateTime(String isoDateTime) {
  try {
    // Parse the ISO date-time string
    final DateTime dateTime = DateTime.parse(isoDateTime);

    // Convert to local time if necessary
    final DateTime localDateTime = dateTime.toLocal();

    // Format date and time
    final String formattedDate = DateFormat('MM/dd/yyyy').format(localDateTime);
    final String startTime = DateFormat('hh:mma').format(localDateTime);
    final String endTime = DateFormat('hh:mma')
        .format(localDateTime.add(const Duration(hours: 2))); // 2-hour range

    return "$formattedDate $startTime - $endTime";
  } catch (e) {
    // Handle parsing errors gracefully
    return 'Invalid date';
  }
}

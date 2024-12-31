import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/location/place_search_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/view/auth/login.dart';

enum SnackBarType { success, failed, alert }

void showCustomSnackbar({
  required String title,
  required String message,
  required SnackBarType type,
  SnackPosition position = SnackPosition.BOTTOM, // Default position
}) {
  Color backgroundColor = AppColors.primaryColor;
  IconData icon = Icons.sentiment_dissatisfied_outlined;
  Color textColor = Colors.white;
  switch (type) {
    case SnackBarType.success:
      backgroundColor = AppColors.greenColor;
      icon = Icons.emoji_emotions_outlined;
      break;
    case SnackBarType.failed:
      backgroundColor = Colors.redAccent;
      Icons.sentiment_dissatisfied_outlined;
      break;
    // TODO: Handle this case.
    case SnackBarType.alert:
      backgroundColor = Colors.orangeAccent;
      icon = Icons.sentiment_neutral;
      break;
    // TODO: Handle this case.
  }
  Get.snackbar(
    title,
    message,
    backgroundColor: backgroundColor,
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.all(12),
    colorText: textColor,
    dismissDirection: DismissDirection.horizontal,
    icon:
        /* Image.asset(splashImgUrl),*/
        Icon(
      icon,
      color: Colors.white,
      size: 30,
    ),
    snackPosition: position,
    duration: const Duration(
        seconds: 3), // Duration for how long the snackbar will be displayed
  );
}

Future<void> pickImages({
  bool allowMultiple = false,
  RxList<String>? uploadImages,
  RxString? singleImagePath,
}) async {
  try {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Restrict to image files
      allowMultiple: allowMultiple, // Allow multiple selection
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
    {required Rx<String?> destinationLat,required Rx<String?> destinationLng,
      required RxList<LocationSuggestion> locationSuggestions  })
async {
  if (address.isEmpty) {
    destinationLat.value = null;
    destinationLng.value = null;
    locationSuggestions.value = [];// Reset if the address is empty
    return;
  }

  try {

    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      locationSuggestions.value = locations.map((location) {
        // Create LocationSuggestion objects with address and LatLng
        return LocationSuggestion(
          address: address,
          lat: location.latitude,
          lng: location.longitude
        );
      }).toList();
     /* destinationLatLng.value =
          LatLng(locations.last.latitude, locations.last.longitude).toString();*/
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
    locationSuggestions.value = [];// Reset on error
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
    // Show time picker dialog
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      // Format the selected time
      final now = DateTime.now();
      final formattedTime = DateFormat.jm().format(
        DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute),
      );
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

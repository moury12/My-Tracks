import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/init/google_map_api_key.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/service/review/review_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:http/http.dart' as http;
import 'package:track_trek/view/initial/splash.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find();
  /*RxBool isLoadingPostLike = false.obs;*/
  RxBool isLiked = false.obs;
  RxBool isLoadingOnFetch = false.obs;
  RxBool isLoadingOnLocationSuggestion = false.obs;

  // RxString stripeUrl ='https://checkout.stripe.com/c/pay/cs_test_a145Ie3jBXtvrM28zoB0JJz69cotaDOpdSxsG0nyZI0C66YofS6PoVz6Zo#fidkdWxOYHwnPyd1blpxYHZxWjA0STVuNnVHXWc3akhWcmpKdk10UVZqYzNzRF0xTER3ajJSSGpTV3V2YUh2dFdVX3dgbWxkQF9SSmd2Q01fTnNAbnBzUUJkYFJJS2RAXFZ1aEJnVU00YT1VNTVXMXxPU1dcaycpJ2N3amhWYHdzYHcnP3F3cGApJ2lkfGpwcVF8dWAnPyd2bGtiaWBabHFgaCcpJ2BrZGdpYFVpZGZgbWppYWB3dic%2FcXdwYHgl'.obs;
  RxString stripeUrl =''.obs;
  RxList<dynamic> addressSuggestion = [].obs;

  postLikeDisLikeCall({required String trackId}) async {
    if (NetworkController.to.isConnected.value) {
      try {
        // Locate the specific track item
        final trackItem = HomeUserController.to.trackList
            .firstWhere((track) => track.sId == trackId);

        // Save the previous state for rollback
        final previousIsLiked = trackItem.isLiked;
        final previousTotalLikes = trackItem.totalLikes ?? 0;

        // Optimistically toggle the isLiked state
        trackItem.isLiked = !(trackItem.isLiked ?? false);

        // Update totalLikes optimistically
        if (trackItem.isLiked == true) {
          trackItem.totalLikes = previousTotalLikes + 1;
        } else {
          trackItem.totalLikes = previousTotalLikes - 1;
        }

        // Refresh the list to update the UI
        HomeUserController.to.trackList.refresh();

        // Make the server request
        final likeHitted =
            await ReviewService.likeDislikeRequest(trackId: trackId);

        if (likeHitted.isNotEmpty) {
          // Update based on server response
          trackItem.isLiked = likeHitted == 'Liked';

          // Adjust totalLikes if needed
          if (trackItem.isLiked == true && previousIsLiked != true) {
            trackItem.totalLikes = previousTotalLikes + 1;
          } else if (trackItem.isLiked == false && previousIsLiked != false) {
            trackItem.totalLikes = previousTotalLikes - 1;
          }

          HomeUserController.to.trackList.refresh();
        } else {
          // Rollback on failure
          trackItem.isLiked = previousIsLiked;
          trackItem.totalLikes = previousTotalLikes;

          HomeUserController.to.trackList.refresh();
          throw Exception("Failed to update like status.");
        }
      } catch (e) {
        print(e.toString());
      } finally {
        /*  isLoadingPostLike.value = false;*/
      }
    } else {
      /*  isLoadingPostLike.value = false;*/
      noInternetShowCustomSnackbar();
    }
  }

  Future<void> fetchSuggestedPlaces(String input) async {
    isLoadingOnLocationSuggestion.value = true;
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${Uri.encodeComponent(input)}&key=${GoogleClient.googleMapUrl}';
    final response = await http.get(Uri.parse(url));
    print(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      addressSuggestion.value = data['predictions'];
      isLoadingOnLocationSuggestion.value = false;
    } else {
      isLoadingOnLocationSuggestion.value = false;
    }
  }
  var isLoading = true.obs;

   WebViewController? webController;

  void initializeWebViewController() {
    if (webController != null) {
      return; // Avoid re-initialization
    }
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent('Mozilla/5.0 (Mobile; rv:52.0) Gecko/52.0 Firefox/52.0')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("WebView progress: $progress");
            isLoading.value = progress < 100;
          },
          onPageStarted: (String url) {
            debugPrint("Page started loading: $url");
            isLoading.value = true;
          },
          onPageFinished: (String url) {
            debugPrint("Page finished loading: $url");
            isLoading.value = false;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint("HTTP Error: ${error}");
            Get.snackbar('Error', 'HTTP Error: ', snackPosition: SnackPosition.BOTTOM);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("Web Resource Error: ${error.description}");
            Get.snackbar('Error', error.description, snackPosition: SnackPosition.BOTTOM);
          },

          onNavigationRequest: (NavigationRequest request) {
           /* if (request.url.startsWith("https://www.google.com/webhp?hl=en&sa=X&ved=0ahUKEwj4-qy6koSLAxVLRmwGHT7zHXIQPAgI")) {
              return NavigationDecision.prevent;
            }*/
            if (request.url.contains('${ApiClient.baseUrl}/payment/success')) {
              Get.offAllNamed(SplashScreen.routeName);
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(stripeUrl.value));
  }
  Future<void> getLatLngFromPlace(
    String placeId, {
    required RxString lat,
    required RxString lng,
    required RxString selectedAddress,
  }) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=${GoogleClient.googleMapUrl}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse response
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['results'].isNotEmpty) {
          final location = data['results'][0]['geometry']['location'];

          // Update RxString values
          selectedAddress.value = data['results'][0]['formatted_address'];
          lat.value = location['lat'].toString();
          lng.value = location['lng'].toString();
          print(lat.value);
          print(lng.value);
        } else {
          print("No results found for the provided placeId.");
        }
      } else {
        print("HTTP Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    Boxes.getUserData().get(roleKey) != null
        ? Boxes.getUserData().get(roleKey) == 'USER'
            ? 0.obs
            : 1.obs
        : 0.obs;
    // categoryListCall();
    super.onInit();
  }

  var selectedRoleOption = Boxes.getUserData().get(roleKey) != null
      ? Boxes.getUserData().get(roleKey) == 'USER'
          ? 0.obs
          : 1.obs
      : 0.obs;
  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  RxString image = ''.obs;
  @override
  void onClose() {
    webController = null; // Clear WebViewController
    super.onClose();
  }

}

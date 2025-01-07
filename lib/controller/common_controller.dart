import 'package:get/get.dart';
import 'package:track_trek/controller/home_user_controller.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/service/review/review_service.dart';


class CommonController extends GetxController {
  static CommonController get to => Get.find();
  RxBool isLoadingPostLike = false.obs;
  RxBool isLiked = false.obs;
  postLikeDisLikeCall({required String trackId}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingPostLike.value = true;
      final String likeHitted =
      await ReviewService.likeDislikeRequest(trackId: trackId);
      if (likeHitted.isNotEmpty) {
        isLoadingPostLike.value = false;
if(likeHitted=='Disliked'){
  isLiked.value =false;
}else{
  isLiked.value =true;
}
        if( Boxes.getUserData().get(roleKey) == 'USER'){
        bool? isLiked= HomeUserController.to.trackList.where((p0) => p0.sId==trackId,).first.isLiked!;
         if(isLiked ==true){
           isLiked =false;
         }else{
           isLiked =true;
         }
          HomeUserController.to.trackList.refresh();
        }else{
          /*HomeController.to.getTrackListCall();*/
        }
      } else {
        isLoadingPostLike.value = false;
        // showCustomSnackbar(
        //     title: AppStaticString.failed,
        //     message: AppStaticString.failedToLoadData,
        //     type: SnackBarType.failed);
      }
    } else {
      isLoadingPostLike.value = false;
      // noInternetShowCustomSnackbar();
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

}

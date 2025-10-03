import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/host/widget/loading_event_card.dart';

class HomeAppBar extends StatefulWidget {
  final Function()? openDrawer;
  const HomeAppBar({
    super.key,
    this.openDrawer,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
String devicePlace= "Unknown location";
//
//   void getAddressFromLatLng() async {
//     try {
//       List<Placemark> placemarks =
//       await placemarkFromCoordinates(double.parse(HomeUserController.to.lat.value), double.parse(HomeUserController.to.lng.value));
//
//       if (placemarks.isEmpty) {
//         devicePlace="Unknown location";
//       } ;
//
//       final place = placemarks.first;
//       print("&*^RRRRRRRRRRRRR${place.name}");
//      setState(() {
//        devicePlace= "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//      });
//     } catch (e) {
//       debugPrint(e.toString());
//       devicePlace= "Unknown location";
//     }
//   }
// @override
//   void initState() {
//     getAddressFromLatLng();
//     // TODO: implement initState
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingH16V6,
      child: Obx(
         () {
          return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileController.to.isLoadingUserData.value
                  ? userInfoLoadingWidget(context)
                  : Flexible(
                child: Row(

                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProfileController.to.userModel.value.profileImage != null &&
                        ProfileController.to.userModel.value.profileImage!.isNotEmpty
                        ? CustomNetworkImage(
                      imageErrorUrl: dummyProfileImgUrl,
                      boxShape: BoxShape.circle,
                      imageUrl: '${ApiClient.baseUrl}/${ProfileController.to.userModel.value.profileImage}',
                      height: 52.w,
                      width: 52.w,
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                                                dummyProfileImgUrl,
                                                height: 52.w,
                                              ),
                        ),
                    space12W,
                    Expanded( // ✅ this is now safe
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ProfileController.to.userModel.value.name ?? 'Guest User',
                            style: poppinsMedium.copyWith(fontSize: getFontSizeLarge(context)),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                userLocationIconUrl,
                                height: 21.w,
                              ),
                              Flexible(
                                child: Text(
                                  ProfileController.to.userModel.value.address ?? devicePlace,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: poppinsMedium.copyWith(
                                    fontSize: getFontSizeSemiSmall(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: widget.openDrawer ?? () {},
                child: Image.asset(
                  drawerIconUrl,
                  height: 50.w,
                ),
              ),
            ],
          );

         }
      ),
    );
  }
}

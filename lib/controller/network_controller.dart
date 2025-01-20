import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  static NetworkController get to => Get.find();
  var isConnected = false.obs;
  Stream<List<ConnectivityResult>> connectivityStream =
      Connectivity().onConnectivityChanged;
  @override
  void onInit() {
    initConnectivity();
    listenConnectivityChange();

    super.onInit();
  }

  Future<void> initConnectivity() async {
    try {
      List<ConnectivityResult> result =
          await Connectivity().checkConnectivity();
      updateConnectionStatus(result);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void listenConnectivityChange() {
    connectivityStream.listen(
      (event) {
        updateConnectionStatus(event);
      },
    );
  }

  void updateConnectionStatus(List<ConnectivityResult> result) {
    isConnected.value = result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)||result.contains(ConnectivityResult.ethernet);
  }
}

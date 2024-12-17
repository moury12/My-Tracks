import 'package:get/get.dart';
import 'package:track_trek/controller/auth_controller.dart';
import 'package:track_trek/controller/create_event_controller.dart';
import 'package:track_trek/controller/create_event_controller.dart';
import 'package:track_trek/controller/create_track_controller.dart';
import 'package:track_trek/controller/create_track_controller.dart';

class CreateTrackBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateTrackController>(CreateTrackController());
  }
}

class CreateEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateEventController>(CreateEventController());
  }
}

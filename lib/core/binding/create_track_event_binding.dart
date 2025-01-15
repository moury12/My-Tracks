import 'package:get/get.dart';
import 'package:track_trek/controller/booking/book_track_join_event_controller.dart';
import 'package:track_trek/controller/create_track_event_controller.dart';

class CreateTrackBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateTrackEventController>(CreateTrackEventController());
  }
}

class BookTrackJoinEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTrackEventController(), fenix: true);
  }
}

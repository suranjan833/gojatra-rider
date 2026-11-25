import 'package:get/get.dart';

import '../controllers/accept_ride_controller.dart';

class AcceptRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcceptRideController>(
      () => AcceptRideController(),
    );
  }
}

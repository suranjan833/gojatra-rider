import 'package:get/get.dart';
import 'package:gojatrarider/app/modules/earnings/controllers/earnings_controller.dart';
import 'package:gojatrarider/app/modules/home/controllers/home_controller.dart';
import 'package:gojatrarider/app/modules/profile/controllers/profile_controller.dart';
import 'package:gojatrarider/app/modules/trips/controllers/trips_controller.dart';
import '../controllers/bottom_nav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<EarningsController>(() => EarningsController());
    Get.lazyPut<TripsController>(() => TripsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

import 'package:get/get.dart';
import '../controllers/safety_centre_controller.dart';

class SafetyCentreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SafetyCentreController>(() => SafetyCentreController());
  }
}

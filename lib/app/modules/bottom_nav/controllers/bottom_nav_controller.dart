import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final currentIndex = 0.obs;

  void changeTab(int index) {
    if (index >= 0 && index <= 3) {
      currentIndex.value = index;
    }
  }
}

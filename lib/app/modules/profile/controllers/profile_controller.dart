import 'package:get/get.dart';
import '../../../data/config/app_config.dart';
import '../../../data/models/captain_profile_model.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final captainProfile = CaptainProfile.mock().obs;

  // Preferences
  final isBikeEnabled = true.obs;
  final isAutoEnabled = false.obs;
  final isCabEnabled = false.obs;
  final isParcelEnabled = true.obs;
  final selectedNavigation = 'Google Maps'.obs;
  final selectedLanguage = 'English'.obs;
  final rideAlertSound = true.obs;
  final highPriorityPush = true.obs;

  void toggleServiceType(String service, bool value) {
    if (service == 'bike') isBikeEnabled.value = value;
    if (service == 'auto') isAutoEnabled.value = value;
    if (service == 'cab') isCabEnabled.value = value;
    if (service == 'parcel') isParcelEnabled.value = value;
  }

  void setNavigationApp(String app) {
    selectedNavigation.value = app;
    AppConfig.showInfo(title: 'Navigation Updated', message: 'Primary navigation app set to $app');
  }

  void setLanguage(String lang) {
    selectedLanguage.value = lang;
    AppConfig.showInfo(title: 'Language Updated', message: 'App language updated to $lang');
  }

  void openDocuments() {
    Get.toNamed(Routes.KYC_DOCUMENTS);
  }

  void openSafetyCentre() {
    Get.toNamed(Routes.SAFETY_CENTRE);
  }

  void logout() {
    AppConfig.showWarning(title: 'Logged Out', message: 'Captain session ended safely.');
  }
}

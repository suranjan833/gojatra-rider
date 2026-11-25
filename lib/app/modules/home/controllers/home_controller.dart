import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/config/app_config.dart';

class HomeController extends GetxController {
  final isOnline = true.obs;
  final todayEarnings = 1420.50.obs;
  final completedTrips = 8.obs;
  final captainRating = 4.92.obs;
  final acceptanceRate = '96%'.obs;

  // Pre-flight checks per features.md
  final isGpsEnabled = true.obs;
  final isNetworkConnected = true.obs;
  final isDocumentsValid = true.obs;
  final isVehicleSelected = true.obs;

  // Duty parameters
  final selectedOfflineReason = RxnString();
  final demandLevel = 'High Demand'.obs;
  final batteryOptimizedLocation = true.obs;

  bool get allPreflightsPassed =>
      isGpsEnabled.value &&
      isNetworkConnected.value &&
      isDocumentsValid.value &&
      isVehicleSelected.value;

  void toggleDuty() {
    HapticFeedback.mediumImpact();
    if (isOnline.value) {
      isOnline.value = false;
      AppConfig.showInfo(title: 'Duty Status', message: 'You are now OFFLINE. Turn online anytime.');
    } else {
      if (!allPreflightsPassed) {
        AppConfig.showError(title: 'Pre-flight Check Incomplete', message: 'Ensure GPS, connection, and documents are valid before going online.',
        );
        return;
      }
      isOnline.value = true;
      AppConfig.showSuccess(title: 'Ready for Duty', message: 'You are now ONLINE and visible to riders.');
    }
  }

  void goOfflineWithReason(String reason) {
    selectedOfflineReason.value = reason;
    isOnline.value = false;
    AppConfig.showInfo(title: 'Duty Offline', message: 'Shift paused: $reason');
  }
}

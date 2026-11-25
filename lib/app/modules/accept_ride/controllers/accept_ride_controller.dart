import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/config/appcolor.dart';
import '../../../data/config/app_config.dart';
import '../../../data/config/app_typography.dart';
import '../../../routes/app_pages.dart';
import '../models/ride_request_model.dart';

enum RideRequestStatus {
  incoming,
  accepting,
  accepted,
  declined,
  expired,
  navigating,
  arrived,
  inTrip,
  payment,
  completed,
}

class AcceptRideController extends GetxController {
  final currentRide = Rxn<RideRequestModel>();
  final status = RideRequestStatus.incoming.obs;
  final remainingSeconds = 20.obs;
  final timerProgress = 1.0.obs;
  final isNavigating = false.obs;
  final swipeProgress = 0.0.obs;
  final waitSeconds = 0.obs;

  Timer? _countdownTimer;
  Timer? _waitTimer;
  int _mockIndex = 0;

  @override
  void onInit() {
    super.onInit();
    loadNewRequest();
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    _waitTimer?.cancel();
    super.onClose();
  }

  void loadNewRequest() {
    _countdownTimer?.cancel();
    _waitTimer?.cancel();
    _mockIndex++;
    currentRide.value = (_mockIndex % 2 == 1)
        ? RideRequestModel.mockDefault()
        : RideRequestModel.mockSecondary();

    status.value = RideRequestStatus.incoming;
    remainingSeconds.value = currentRide.value?.timeoutSeconds ?? 20;
    timerProgress.value = 1.0;
    isNavigating.value = false;
    swipeProgress.value = 0.0;
    waitSeconds.value = 0;

    _startTimer();
  }

  void _startTimer() {
    final totalDuration = currentRide.value?.timeoutSeconds ?? 20;
    _countdownTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final newRemainingMs = (remainingSeconds.value * 1000) - 100;
      if (newRemainingMs <= 0) {
        timer.cancel();
        remainingSeconds.value = 0;
        timerProgress.value = 0.0;
        _onTimeExpired();
      } else {
        remainingSeconds.value = (newRemainingMs / 1000).ceil();
        timerProgress.value = (newRemainingMs / (totalDuration * 1000)).clamp(0.0, 1.0);
      }
    });
  }

  void _onTimeExpired() {
    if (status.value == RideRequestStatus.incoming) {
      status.value = RideRequestStatus.expired;
      HapticFeedback.lightImpact();
      AppConfig.showWarning(
        title: 'Request Expired',
        message: 'You did not respond in time. Searching for nearby rides...',
      );
    }
  }

  void updateSwipeProgress(double ratio) {
    swipeProgress.value = ratio.clamp(0.0, 1.0);
  }

  void resetSwipe() {
    swipeProgress.value = 0.0;
  }

  Future<void> acceptRide() async {
    if (status.value != RideRequestStatus.incoming) return;

    _countdownTimer?.cancel();
    swipeProgress.value = 1.0;
    status.value = RideRequestStatus.accepting;
    HapticFeedback.mediumImpact();

    await Future.delayed(const Duration(milliseconds: 700));

    status.value = RideRequestStatus.accepted;
    HapticFeedback.selectionClick();

    AppConfig.showSuccess(
      title: 'Ride Accepted!',
      message: 'Navigate to pickup location and request the 4-digit OTP from passenger.',
    );
  }

  void declineRide() {
    _countdownTimer?.cancel();
    HapticFeedback.lightImpact();
    status.value = RideRequestStatus.declined;

    AppConfig.showError(
      title: 'Ride Declined',
      message: 'Ride request passed. You remain available in the captain queue.',
    );
  }

  void startNavigation() {
    HapticFeedback.lightImpact();
    isNavigating.value = true;
    status.value = RideRequestStatus.navigating;
    AppConfig.showInfo(
      title: 'Navigation Started',
      message: 'Routing to ${currentRide.value?.pickupAddress ?? 'pickup location'}. Follow live instructions.',
    );
  }

  void markArrivedAtPickup() {
    HapticFeedback.mediumImpact();
    status.value = RideRequestStatus.arrived;
    waitSeconds.value = 0;
    _waitTimer?.cancel();
    _waitTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      waitSeconds.value++;
    });
    AppConfig.showSuccess(
      title: 'Arrived at Pickup',
      message: 'Passenger has been notified. Ask for the 4-digit OTP to start trip.',
    );
  }

  bool verifyOtpAndStartTrip(String otp) {
    HapticFeedback.mediumImpact();
    final expected = currentRide.value?.pickupOtp ?? '4492';
    if (otp == expected) {
      _waitTimer?.cancel();
      status.value = RideRequestStatus.inTrip;
      AppConfig.showSuccess(
        title: 'OTP Verified — Trip Started',
        message: 'Driving to ${currentRide.value?.dropAddress}. Drive safely!',
      );
      return true;
    } else {
      AppConfig.showError(
        title: 'Invalid OTP',
        message: 'Please re-check the 4-digit PIN with the passenger.',
      );
      return false;
    }
  }

  void endTripAndRequestPayment() {
    HapticFeedback.mediumImpact();
    status.value = RideRequestStatus.payment;
    AppConfig.showInfo(
      title: 'Trip Ended',
      message: 'Please collect payment and confirm before completing trip.',
    );
  }

  void confirmPaymentAndFinish(bool isCash) {
    HapticFeedback.mediumImpact();
    status.value = RideRequestStatus.completed;
    AppConfig.showSuccess(
      title: 'Trip Completed Successfully',
      message: '₹${currentRide.value?.fareAmount.toStringAsFixed(2)} earned. Added to your daily balance.',
    );
  }

  void openEmergencySos() {
    Get.toNamed(Routes.SAFETY_CENTRE);
  }

  void callPassenger() {
    HapticFeedback.lightImpact();
    final phone = currentRide.value?.passengerPhone ?? '';
    AppConfig.showInfo(
      title: 'Calling Passenger',
      message: 'Connecting call to $phone...',
    );
  }

  void chatPassenger() {
    HapticFeedback.lightImpact();
    AppConfig.showInfo(
      title: 'Passenger Chat',
      message: 'Opening in-app message channel with ${currentRide.value?.passengerName ?? 'passenger'}...',
    );
  }

  void cancelAcceptedRide() {
    HapticFeedback.mediumImpact();
    Get.defaultDialog(
      title: 'Cancel Ride?',
      titleStyle: AppTypography.headingLarge.copyWith(fontSize: 18.sp),
      middleText: 'Frequent cancellations affect your Captain acceptance score. Are you sure you want to cancel this ride?',
      middleTextStyle: AppTypography.cardDetails.copyWith(fontSize: 13.sp),
      backgroundColor: AppColors.softWhite,
      radius: 18.r,
      textConfirm: 'Yes, Cancel',
      textCancel: 'Keep Ride',
      confirmTextColor: Colors.white,
      buttonColor: AppColors.error,
      cancelTextColor: AppColors.nearBlack,
      onConfirm: () {
        Get.back();
        status.value = RideRequestStatus.declined;
        AppConfig.showWarning(
          title: 'Trip Cancelled',
          message: 'Trip was cancelled. Returning to duty radar.',
        );
      },
    );
  }
}

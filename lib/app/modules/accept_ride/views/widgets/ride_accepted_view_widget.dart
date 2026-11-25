import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import '../../controllers/accept_ride_controller.dart';

class RideAcceptedViewWidget extends GetView<AcceptRideController> {
  const RideAcceptedViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ride = controller.currentRide.value;
      if (ride == null) return const SizedBox.shrink();

      final currentStatus = controller.status.value;

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          border: Border.all(color: AppColors.warmBeige, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 28.r,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drag Handle
            Center(
              child: Container(
                width: 44.w,
                height: 4.5.h,
                decoration: BoxDecoration(
                  color: AppColors.warmBeige,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),

            // Header Banner
            _buildStatusHeader(currentStatus),
            SizedBox(height: 12.h),

            // OTP Container (before trip starts)
            if (currentStatus == RideRequestStatus.accepted ||
                currentStatus == RideRequestStatus.navigating ||
                currentStatus == RideRequestStatus.arrived)
              _buildOtpBox(ride.pickupOtp),

            SizedBox(height: 12.h),

            // Passenger details row
            _buildPassengerRow(ride.passengerName, ride.passengerRating),
            SizedBox(height: 14.h),

            // State-Specific Action CTA
            _buildLifecycleAction(currentStatus, ride.pickupOtp, ride.fareAmount),
            SizedBox(height: 8.h),

            // Emergency SOS and Cancel Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextButton.icon(
                    onPressed: () => controller.openEmergencySos(),
                    icon: Icon(Iconsax.shield_tick, size: 16.sp, color: AppColors.error),
                    label: Text(
                      'Emergency SOS',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.error,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                if (currentStatus != RideRequestStatus.completed)
                  Flexible(
                    child: TextButton(
                      onPressed: () => controller.cancelAcceptedRide(),
                      child: Text(
                        'Cancel Ride',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.softSlate,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatusHeader(RideRequestStatus currentStatus) {
    String title = 'Ride Accepted!';
    String subtitle = 'Head to customer pickup location';
    IconData icon = Iconsax.tick_circle;
    Color iconColor = AppColors.freshGreen;

    if (currentStatus == RideRequestStatus.navigating) {
      title = 'Navigating to Pickup';
      subtitle = 'Follow live GPS route';
      icon = Iconsax.routing;
      iconColor = AppColors.deepForestGreen;
    } else if (currentStatus == RideRequestStatus.arrived) {
      final waitSec = controller.waitSeconds.value;
      title = 'Arrived at Pickup';
      subtitle = 'Wait time: ${waitSec ~/ 60}:${(waitSec % 60).toString().padLeft(2, '0')}';
      icon = Iconsax.timer_1;
      iconColor = const Color(0xFFD97706);
    } else if (currentStatus == RideRequestStatus.inTrip) {
      title = 'Trip In Progress';
      subtitle = 'Driving to destination';
      icon = Iconsax.car;
      iconColor = AppColors.deepForestGreen;
    } else if (currentStatus == RideRequestStatus.payment) {
      title = 'Collect Payment';
      subtitle = 'Confirm fare receipt from passenger';
      icon = Iconsax.wallet_money;
      iconColor = AppColors.champagneGold;
    } else if (currentStatus == RideRequestStatus.completed) {
      title = 'Trip Completed!';
      subtitle = 'Fare credited to your wallet';
      icon = Iconsax.award;
      iconColor = AppColors.freshGreen;
    }

    return Row(
      children: [
        Container(
          width: 32.r,
          height: 32.r,
          decoration: BoxDecoration(
            color: iconColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(icon, size: 18.sp, color: Colors.white),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.headingLarge.copyWith(
                  fontSize: 16.5.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.nearBlack,
                ),
              ),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.cardDetails.copyWith(
                  fontSize: 11.5.sp,
                  color: AppColors.softSlate,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpBox(String otp) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.deepForestGreen.withValues(alpha: 0.25),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Iconsax.key, size: 16.sp, color: AppColors.deepForestGreen),
              SizedBox(width: 8.w),
              Text(
                'Pickup OTP Pin:',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepForestGreen,
                ),
              ),
            ],
          ),
          Text(
            otp,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
              color: AppColors.deepForestGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerRow(String name, double rating) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceWarm,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.stone,
            child: Text(
              name.isNotEmpty ? name[0] : 'P',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.nearBlack,
                fontSize: 13.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.nearBlack,
                  ),
                ),
                Text(
                  '$rating ★ Passenger',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.softSlate,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Iconsax.message_2, size: 18.sp, color: AppColors.nearBlack),
            onPressed: () => controller.chatPassenger(),
          ),
          IconButton(
            icon: Icon(Iconsax.call, size: 18.sp, color: AppColors.deepForestGreen),
            onPressed: () => controller.callPassenger(),
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleAction(RideRequestStatus currentStatus, String expectedOtp, double fare) {
    if (currentStatus == RideRequestStatus.accepted) {
      return _buildPrimaryCta(
        title: 'Start Navigation',
        icon: Iconsax.direct_up,
        onTap: () => controller.startNavigation(),
      );
    } else if (currentStatus == RideRequestStatus.navigating) {
      return _buildPrimaryCta(
        title: 'I\'ve Arrived at Pickup',
        icon: Iconsax.location_tick,
        onTap: () => controller.markArrivedAtPickup(),
      );
    } else if (currentStatus == RideRequestStatus.arrived) {
      return _buildPrimaryCta(
        title: 'Verify OTP & Start Trip',
        icon: Iconsax.play_circle,
        onTap: () => controller.verifyOtpAndStartTrip(expectedOtp),
      );
    } else if (currentStatus == RideRequestStatus.inTrip) {
      return _buildPrimaryCta(
        title: 'Arrived at Dropoff & End Trip',
        icon: Iconsax.flag,
        onTap: () => controller.endTripAndRequestPayment(),
      );
    } else if (currentStatus == RideRequestStatus.payment) {
      return _buildPrimaryCta(
        title: 'Confirm Payment (₹${fare.toStringAsFixed(2)})',
        icon: Iconsax.money_tick,
        onTap: () => controller.confirmPaymentAndFinish(true),
      );
    } else {
      return _buildPrimaryCta(
        title: 'Back to Radar / Next Ride',
        icon: Iconsax.refresh,
        onTap: () => controller.loadNewRequest(),
      );
    }
  }

  Widget _buildPrimaryCta({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepForestGreen.withValues(alpha: 0.3),
              blurRadius: 16.r,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18.sp, color: Colors.white),
              SizedBox(width: 8.w),
              Text(
                title,
                style: AppTypography.primaryButton.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

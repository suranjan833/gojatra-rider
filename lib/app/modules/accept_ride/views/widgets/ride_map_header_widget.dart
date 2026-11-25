import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/config/app_typography.dart';
import '../../controllers/accept_ride_controller.dart';
import 'painters/radar_map_painter.dart';

class RideMapHeaderWidget extends GetView<AcceptRideController> {
  const RideMapHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250.h,
      child: Stack(
        children: [
          // Background Map canvas
          Positioned.fill(
            child: Container(
              color: const Color(0xFFF2ECE1),
              child: Obx(
                () => CustomPaint(
                  painter: RadarMapPainter(
                    pulseProgress: controller.timerProgress.value,
                    isAccepted: controller.status.value == RideRequestStatus.accepted,
                  ),
                ),
              ),
            ),
          ),

          // Top Header Action Overlay
          Positioned(
            top: 48.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back / Close button
                InkWell(
                  onTap: () => Get.back(),
                  borderRadius: BorderRadius.circular(22.r),
                  child: Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      color: AppColors.softWhite,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.warmBeige, width: 1.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10.r,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Iconsax.arrow_left,
                        size: 20.sp,
                        color: AppColors.nearBlack,
                      ),
                    ),
                  ),
                ),

                // Duty Status Pill
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.softWhite,
                    borderRadius: BorderRadius.circular(999.r),
                    border: Border.all(color: AppColors.warmBeige, width: 1.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8.r,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: const BoxDecoration(
                          color: AppColors.freshGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'CAPTAIN ON DUTY',
                        style: AppTypography.recommendedBadge.copyWith(
                          color: AppColors.deepForestGreen,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),

                // Map Layer / Sound Toggle
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    color: AppColors.softWhite,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.warmBeige, width: 1.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10.r,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.routing,
                      size: 20.sp,
                      color: AppColors.deepForestGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Pickup ETA Tag floating on Map
          Positioned(
            bottom: 16.h,
            left: 20.w,
            child: Obx(() {
              final ride = controller.currentRide.value;
              if (ride == null) return const SizedBox.shrink();
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.forestCharcoal,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 10.r,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.timer_1,
                      size: 14.sp,
                      color: AppColors.champagneGold,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Pickup ${ride.pickupEtaMinutes} min (${ride.pickupDistanceKm} km)',
                      style: AppTypography.legalCopy.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

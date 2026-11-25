import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/config/app_typography.dart';
import '../../controllers/accept_ride_controller.dart';

class RideRouteCardWidget extends GetView<AcceptRideController> {
  const RideRouteCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ride = controller.currentRide.value;
      if (ride == null) return const SizedBox.shrink();

      return Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.warmBeige, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 14.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Pickup Location
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pickup Pin Indicator
                Column(
                  children: [
                    Container(
                      width: 20.r,
                      height: 20.r,
                      decoration: const BoxDecoration(
                        color: AppColors.freshGreen,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 8.r,
                          height: 8.r,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 2.w,
                      height: 38.h,
                      color: AppColors.warmBeige,
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                // Pickup Text Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'PICKUP LOCATION',
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.welcomeLabel.copyWith(
                                color: AppColors.freshGreen,
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              '${ride.pickupDistanceKm} km away',
                              style: AppTypography.recommendedBadge.copyWith(
                                color: AppColors.deepForestGreen,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        ride.pickupAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.locationTitle.copyWith(
                          fontSize: 13.5.sp,
                          color: AppColors.nearBlack,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        ride.pickupLandmark,
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
            ),

            // Row 2: Dropoff Location
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropoff Pin Indicator (Square)
                Container(
                  width: 20.r,
                  height: 20.r,
                  decoration: BoxDecoration(
                    color: AppColors.nearBlack,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: const BoxDecoration(
                        color: AppColors.champagneGold,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Dropoff Text Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'DROPOFF DESTINATION',
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.welcomeLabel.copyWith(
                                color: AppColors.softSlate,
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text(
                            '${ride.tripDistanceKm} km • ~${ride.tripDurationMinutes}m',
                            style: AppTypography.cardDetails.copyWith(
                              color: AppColors.softSlate,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.5.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        ride.dropoffAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.locationTitle.copyWith(
                          fontSize: 13.5.sp,
                          color: AppColors.nearBlack,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        ride.dropoffLandmark,
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
            ),
          ],
        ),
      );
    });
  }
}

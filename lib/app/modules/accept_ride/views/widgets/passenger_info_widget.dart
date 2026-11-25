import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/config/app_typography.dart';
import '../../controllers/accept_ride_controller.dart';

class PassengerInfoWidget extends GetView<AcceptRideController> {
  const PassengerInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ride = controller.currentRide.value;
      if (ride == null) return const SizedBox.shrink();

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.stone,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.warmBeige, width: 1.w),
        ),
        child: Row(
          children: [
            // Passenger Avatar
            Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                color: AppColors.surfaceWarm,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.warmBeige, width: 1.w),
              ),
              child: Center(
                child: Text(
                  ride.passengerName.isNotEmpty ? ride.passengerName[0] : 'U',
                  style: TextStyle(
                    color: AppColors.deepForestGreen,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),

            // Passenger Name, Rating & Trip Count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ride.passengerName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.rideName.copyWith(
                      fontSize: 13.5.sp,
                      color: AppColors.nearBlack,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      // Rating Pill
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 11.sp,
                              color: const Color(0xFFD97706),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              ride.passengerRating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 9.5.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFB45309),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          '${ride.passengerTripsCount} trips',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.cardDetails.copyWith(
                            fontSize: 10.sp,
                            color: AppColors.softSlate,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),

            // Payment Mode Pill
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.softWhite,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.warmBeige, width: 1.w),
              ),
              child: Text(
                ride.paymentMethod,
                style: AppTypography.recommendedBadge.copyWith(
                  color: AppColors.nearBlack,
                  fontSize: 9.5.sp,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

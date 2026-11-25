import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/config/app_typography.dart';
import '../../controllers/accept_ride_controller.dart';
import 'passenger_info_widget.dart';
import 'ride_action_buttons_widget.dart';
import 'ride_route_card_widget.dart';

class RideRequestSheetWidget extends GetView<AcceptRideController> {
  const RideRequestSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ride = controller.currentRide.value;
      if (ride == null) return const SizedBox.shrink();

      final remainingSec = controller.remainingSeconds.value;
      final progress = controller.timerProgress.value;

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          border: Border.all(color: AppColors.warmBeige, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 28.r,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            // Drag Handle
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

            // Animated Countdown Progress Line
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.timer_1,
                              size: 16.sp,
                              color: remainingSec <= 5 ? AppColors.error : AppColors.deepForestGreen,
                            ),
                            SizedBox(width: 6.w),
                            Flexible(
                              child: Text(
                                'Incoming Request',
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.welcomeLabel.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.nearBlack,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: remainingSec <= 5
                              ? AppColors.error.withValues(alpha: 0.12)
                              : AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          '${remainingSec}s left',
                          style: AppTypography.recommendedBadge.copyWith(
                            color: remainingSec <= 5 ? AppColors.error : AppColors.deepForestGreen,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 4.5.h,
                      backgroundColor: AppColors.stone,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        remainingSec <= 5 ? AppColors.error : AppColors.deepForestGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Fare & Ride Type Header Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ESTIMATED EARNING',
                          style: AppTypography.welcomeLabel.copyWith(
                            fontSize: 10.5.sp,
                            letterSpacing: 1.1,
                            color: AppColors.softSlate,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8.w,
                          children: [
                            Text(
                              '₹${ride.fare.toStringAsFixed(2)}',
                              style: AppTypography.fare.copyWith(
                                color: AppColors.nearBlack,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (ride.isSurge)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(6.r),
                                  border: Border.all(
                                    color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                                    width: 1.w,
                                  ),
                                ),
                                child: Text(
                                  '${ride.surgeMultiplier}x Surge',
                                  style: AppTypography.recommendedBadge.copyWith(
                                    color: const Color(0xFFB45309),
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Service Pill
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWarm,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.warmBeige, width: 1.w),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.car,
                          size: 16.sp,
                          color: AppColors.deepForestGreen,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          ride.serviceType,
                          style: AppTypography.recommendedBadge.copyWith(
                            color: AppColors.nearBlack,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),

            // Route Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const RideRouteCardWidget(),
            ),
            SizedBox(height: 12.h),

            // Passenger Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const PassengerInfoWidget(),
            ),
            SizedBox(height: 16.h),

            // Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const RideActionButtonsWidget(),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      );
    });
  }
}

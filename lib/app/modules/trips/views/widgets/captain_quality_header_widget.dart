import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import '../../controllers/trips_controller.dart';

class CaptainQualityHeaderWidget extends GetView<TripsController> {
  const CaptainQualityHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(20.r),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CAPTAIN PERFORMANCE SCORE',
                style: AppTypography.welcomeLabel.copyWith(
                  fontSize: 10.5.sp,
                  color: AppColors.softSlate,
                  letterSpacing: 1.0,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded, size: 13.sp, color: const Color(0xFFD97706)),
                    SizedBox(width: 3.w),
                    Obx(
                      () => Text(
                        '${controller.captainRating.value}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFB45309),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  title: 'Acceptance',
                  value: '${controller.acceptanceRate.value}%',
                  icon: Iconsax.tick_circle,
                  color: AppColors.deepForestGreen,
                ),
              ),
              Container(width: 1.w, height: 36.h, color: AppColors.warmBeige),
              Expanded(
                child: _buildMetricTile(
                  title: 'Cancellation',
                  value: '${controller.cancellationRate.value}%',
                  icon: Iconsax.close_circle,
                  color: AppColors.error,
                ),
              ),
              Container(width: 1.w, height: 36.h, color: AppColors.warmBeige),
              Expanded(
                child: _buildMetricTile(
                  title: 'On-Time',
                  value: '${controller.onTimePickupRate.value}%',
                  icon: Iconsax.timer_1,
                  color: AppColors.freshGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Constructive Coaching Tip
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Icon(Iconsax.lamp_on, size: 16.sp, color: AppColors.deepForestGreen),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Great job! Your acceptance rate is top 5% in Kolkata Salt Lake.',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.deepForestGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 16.sp, color: color),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.nearBlack,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 10.5.sp,
            color: AppColors.softSlate,
          ),
        ),
      ],
    );
  }
}

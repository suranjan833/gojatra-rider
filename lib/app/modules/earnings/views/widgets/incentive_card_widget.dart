import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/models/incentive_model.dart';
import '../../controllers/earnings_controller.dart';

class IncentiveCardWidget extends GetView<EarningsController> {
  final IncentiveTarget target;

  const IncentiveCardWidget({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: target.isAchieved ? AppColors.freshGreen.withValues(alpha: 0.5) : AppColors.warmBeige,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      target.isAchieved ? Iconsax.award : Iconsax.gift,
                      size: 18.sp,
                      color: target.isAchieved ? AppColors.freshGreen : AppColors.champagneGold,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        target.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.locationTitle.copyWith(
                          fontSize: 13.5.sp,
                          color: AppColors.nearBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  '+₹${target.bonusAmount.toInt()}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.deepForestGreen,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            target.description,
            style: AppTypography.cardDetails.copyWith(
              fontSize: 11.5.sp,
              color: AppColors.softSlate,
            ),
          ),
          SizedBox(height: 10.h),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: target.progressPercent,
              minHeight: 7.h,
              backgroundColor: AppColors.stone,
              valueColor: AlwaysStoppedAnimation<Color>(
                target.isAchieved ? AppColors.freshGreen : AppColors.deepForestGreen,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${target.completedRides} of ${target.targetRides} completed',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.nearBlack,
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                target.isAchieved ? 'Achieved & Credited' : 'In Progress',
                style: TextStyle(
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w700,
                  color: target.isAchieved ? AppColors.freshGreen : AppColors.softSlate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

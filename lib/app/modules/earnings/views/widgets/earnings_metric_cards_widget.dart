import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import '../../controllers/earnings_controller.dart';

class EarningsMetricCardsWidget extends GetView<EarningsController> {
  const EarningsMetricCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero Balance Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            gradient: AppColors.forestCharcoalGradient,
            borderRadius: BorderRadius.circular(22.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 18.r,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'GROSS EARNINGS',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.welcomeLabel.copyWith(
                        color: AppColors.champagneGold,
                        fontSize: 11.sp,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: AppColors.champagneGold.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'Live Settlement',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.champagneGold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Obx(
                () => Text(
                  '₹${controller.grossEarnings.value.toStringAsFixed(2)}',
                  style: AppTypography.brandTitle.copyWith(
                    color: Colors.white,
                    fontSize: 34.sp,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              const Divider(color: Color(0xFF233B2E), height: 1),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildSubStat(
                      label: 'Trips',
                      value: '${controller.completedTrips.value}',
                      icon: Iconsax.car,
                    ),
                  ),
                  Expanded(
                    child: _buildSubStat(
                      label: 'Online Hrs',
                      value: '${controller.onlineHours.value}h',
                      icon: Iconsax.clock,
                    ),
                  ),
                  Expanded(
                    child: _buildSubStat(
                      label: 'Cash In Hand',
                      value: '₹${controller.cashCollected.value.toInt()}',
                      icon: Iconsax.money_tick,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Split Details (Cash vs Digital vs Incentive)
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.softWhite,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.warmBeige, width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Earnings Breakdown',
                style: AppTypography.headingLarge.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.nearBlack,
                ),
              ),
              SizedBox(height: 12.h),
              _buildBreakdownRow('Digital Payments & UPI', controller.digitalEarnings.value, AppColors.deepForestGreen),
              SizedBox(height: 8.h),
              _buildBreakdownRow('Cash Collected by You', controller.cashCollected.value, const Color(0xFFD97706)),
              SizedBox(height: 8.h),
              _buildBreakdownRow('Incentive & Quests Bonus', controller.incentiveEarned.value, AppColors.champagneGold),
              SizedBox(height: 8.h),
              _buildBreakdownRow('Platform Service Fee', -controller.platformFeeTotal.value, AppColors.error),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubStat({required String label, required String value, required IconData icon}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: AppColors.champagneGold),
        SizedBox(width: 4.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownRow(String title, double amount, Color amountColor) {
    final isNegative = amount < 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.cardDetails.copyWith(
              fontSize: 12.5.sp,
              color: AppColors.nearBlack,
            ),
          ),
        ),
        Text(
          '${isNegative ? '-' : '+'}₹${amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: amountColor,
          ),
        ),
      ],
    );
  }
}

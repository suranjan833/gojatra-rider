import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import '../../controllers/earnings_controller.dart';

class PayoutSheetWidget extends GetView<EarningsController> {
  const PayoutSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.warmBeige, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payout & Withdrawal',
                style: AppTypography.headingLarge.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.nearBlack,
                ),
              ),
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    controller.payoutStatus.value,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepForestGreen,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: AppColors.surfaceWarm,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Iconsax.bank,
                  size: 20.sp,
                  color: AppColors.deepForestGreen,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.bankAccountMasked.value,
                        style: AppTypography.locationTitle.copyWith(
                          fontSize: 13.sp,
                          color: AppColors.nearBlack,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        'UPI: ${controller.upiId.value}',
                        style: AppTypography.cardDetails.copyWith(
                          fontSize: 11.sp,
                          color: AppColors.softSlate,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          InkWell(
            onTap: () {
              HapticFeedback.mediumImpact();
              controller.requestInstantPayout();
            },
            borderRadius: BorderRadius.circular(14.r),
            child: Container(
              width: double.infinity,
              height: 46.h,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.send_2, size: 16.sp, color: Colors.white),
                    SizedBox(width: 8.w),
                    Obx(
                      () => Text(
                        'Withdraw ₹${controller.netBalance.value.toStringAsFixed(2)}',
                        style: AppTypography.primaryButton.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

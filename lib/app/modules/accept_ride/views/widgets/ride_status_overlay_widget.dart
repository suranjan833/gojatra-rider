import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/config/app_typography.dart';
import '../../controllers/accept_ride_controller.dart';

class RideStatusOverlayWidget extends GetView<AcceptRideController> {
  const RideStatusOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final status = controller.status.value;
      if (status != RideRequestStatus.declined && status != RideRequestStatus.expired) {
        return const SizedBox.shrink();
      }

      final isExpired = status == RideRequestStatus.expired;

      return Container(
        width: double.infinity,
        margin: EdgeInsets.all(20.r),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: AppColors.warmBeige, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18.r,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50.r,
              height: 50.r,
              decoration: BoxDecoration(
                color: isExpired
                    ? AppColors.champagneGold.withValues(alpha: 0.15)
                    : AppColors.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isExpired ? Iconsax.timer_pause : Iconsax.close_circle,
                  size: 26.sp,
                  color: isExpired ? AppColors.champagneGold : AppColors.error,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              isExpired ? 'Request Timed Out' : 'Request Declined',
              style: AppTypography.headingLarge.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.nearBlack,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              isExpired
                  ? 'You did not respond to the incoming ride request in time.'
                  : 'You passed this ride request. Stay online for the next trip.',
              textAlign: TextAlign.center,
              style: AppTypography.cardDetails.copyWith(
                fontSize: 13.sp,
                color: AppColors.softSlate,
              ),
            ),
            SizedBox(height: 18.h),
            InkWell(
              onTap: () => controller.loadNewRequest(),
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                width: double.infinity,
                height: 48.h,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.refresh,
                        size: 18.sp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          'Simulate Next Ride',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.primaryButton.copyWith(
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w700,
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
    });
  }
}

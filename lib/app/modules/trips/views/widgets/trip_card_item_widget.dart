import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/models/trip_record_model.dart';
import '../../controllers/trips_controller.dart';

class TripCardItemWidget extends GetView<TripsController> {
  final TripRecord trip;
  final VoidCallback onTap;

  const TripCardItemWidget({
    super.key,
    required this.trip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCancelled = trip.status != TripStatus.completed;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isCancelled ? AppColors.error.withValues(alpha: 0.3) : AppColors.warmBeige,
          width: 1.w,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Service type & Fare
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: isCancelled ? const Color(0xFFFEE2E2) : AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        trip.serviceType,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: isCancelled ? AppColors.error : AppColors.deepForestGreen,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      trip.id,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                Text(
                  isCancelled ? 'Cancelled' : '₹${trip.captainPayout.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: isCancelled ? AppColors.error : AppColors.nearBlack,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // Route points
            _buildRoutePoint(
              isPickup: true,
              text: trip.pickupAddress,
            ),
            SizedBox(height: 6.h),
            _buildRoutePoint(
              isPickup: false,
              text: trip.dropAddress,
            ),
            SizedBox(height: 10.h),
            const Divider(color: AppColors.stone, height: 1),
            SizedBox(height: 8.h),

            // Footer: Passenger Name, distance, payment mode
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${trip.passengerName} • ${trip.tripDistanceKm} km',
                  style: AppTypography.cardDetails.copyWith(
                    fontSize: 11.5.sp,
                    color: AppColors.softSlate,
                  ),
                ),
                Text(
                  trip.paymentMode.label,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.deepForestGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoutePoint({required bool isPickup, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 3.h),
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(
            color: isPickup ? AppColors.freshGreen : AppColors.deepForestGreen,
            shape: isPickup ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isPickup ? null : BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.nearBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

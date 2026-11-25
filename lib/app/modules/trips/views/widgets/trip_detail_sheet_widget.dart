import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/models/trip_record_model.dart';
import '../../controllers/trips_controller.dart';

class TripDetailSheetWidget extends GetView<TripsController> {
  final TripRecord trip;

  const TripDetailSheetWidget({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trip Breakdown — ${trip.id}',
                style: AppTypography.headingLarge.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.nearBlack,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Payout Details
          _buildDetailRow('Total Customer Fare', '₹${trip.totalFare.toStringAsFixed(2)}'),
          _buildDetailRow('Platform Commission', '-₹${trip.platformFee.toStringAsFixed(2)}'),
          if (trip.incentiveBonus > 0)
            _buildDetailRow('Incentive / Rush Bonus', '+₹${trip.incentiveBonus.toStringAsFixed(2)}'),
          if (trip.tipAmount > 0)
            _buildDetailRow('Passenger Tip', '+₹${trip.tipAmount.toStringAsFixed(2)}'),
          const Divider(color: AppColors.warmBeige, height: 16),
          _buildDetailRow(
            'Captain Net Payout',
            '₹${trip.captainPayout.toStringAsFixed(2)}',
            isBold: true,
          ),
          SizedBox(height: 16.h),

          // Route & Customer
          Text(
            'Passenger: ${trip.passengerName} (Rating: ${trip.passengerRating} ★)',
            style: AppTypography.cardDetails.copyWith(
              fontSize: 12.sp,
              color: AppColors.softSlate,
            ),
          ),
          SizedBox(height: 16.h),

          // Action Buttons: Invoice & Support
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Get.back();
                    Get.snackbar('Invoice', 'Trip invoice shared via SMS / Email.');
                  },
                  icon: Icon(Iconsax.receipt, size: 16.sp),
                  label: const Text('Receipt'),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepForestGreen,
                  ),
                  onPressed: () {
                    Get.back();
                    Get.snackbar('Support', 'Support agent connected for ${trip.id}.');
                  },
                  icon: Icon(Iconsax.message_question, size: 16.sp, color: Colors.white),
                  label: const Text('Trip Support', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5.sp,
              color: isBold ? AppColors.nearBlack : AppColors.softSlate,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              color: isBold ? AppColors.deepForestGreen : AppColors.nearBlack,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/config/app_typography.dart';
import '../../../data/config/appcolor.dart';
import '../controllers/trips_controller.dart';
import 'widgets/captain_quality_header_widget.dart';
import 'widgets/trip_card_item_widget.dart';
import 'widgets/trip_detail_sheet_widget.dart';

class TripsView extends GetView<TripsController> {
  const TripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppBar(
        backgroundColor: AppColors.warmIvory,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Trips & Quality',
          style: AppTypography.headingLarge.copyWith(
            fontSize: 18.sp,
            color: AppColors.nearBlack,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 8.h,
            bottom: 96.h, // 96dp bottom padding per features.md
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Captain Performance & Quality Score
              const CaptainQualityHeaderWidget(),
              SizedBox(height: 18.h),

              // Filter Chips
              _buildFilterChips(),
              SizedBox(height: 14.h),

              // Trips History List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trip Activity',
                    style: AppTypography.headingLarge.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.nearBlack,
                    ),
                  ),
                  Obx(
                    () => Text(
                      '${controller.filteredTrips.length} Rides',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.softSlate,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Obx(() {
                final trips = controller.filteredTrips;
                if (trips.isEmpty) {
                  return Container(
                    padding: EdgeInsets.all(32.r),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Icon(Iconsax.car, size: 36.sp, color: AppColors.textMuted),
                        SizedBox(height: 8.h),
                        Text(
                          'No trips found for this filter.',
                          style: TextStyle(color: AppColors.softSlate, fontSize: 13.sp),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: trips.map((trip) {
                    return TripCardItemWidget(
                      trip: trip,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        controller.selectTrip(trip);
                        Get.bottomSheet(
                          TripDetailSheetWidget(trip: trip),
                          isScrollControlled: true,
                        );
                      },
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Obx(() {
      final current = controller.selectedFilter.value;
      return Row(
        children: [
          _buildChip('All Rides', TripsFilter.all, current == TripsFilter.all),
          SizedBox(width: 8.w),
          _buildChip('Completed', TripsFilter.completed, current == TripsFilter.completed),
          SizedBox(width: 8.w),
          _buildChip('Cancelled', TripsFilter.cancelled, current == TripsFilter.cancelled),
        ],
      );
    });
  }

  Widget _buildChip(String label, TripsFilter filter, bool isSelected) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        controller.setFilter(filter);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.deepForestGreen : AppColors.softWhite,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.deepForestGreen : AppColors.warmBeige,
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.softSlate,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import '../../controllers/profile_controller.dart';

class PreferencesSheetWidget extends GetView<ProfileController> {
  const PreferencesSheetWidget({super.key});

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
          Text(
            'Service Categories Allowed',
            style: AppTypography.headingLarge.copyWith(
              fontSize: 15.sp,
              color: AppColors.nearBlack,
            ),
          ),
          SizedBox(height: 10.h),
          Obx(
            () => _buildServiceSwitch(
              title: 'Go Bike Passenger Rides',
              subtitle: 'Accept standard 2-wheeler passenger bookings',
              value: controller.isBikeEnabled.value,
              onChanged: (val) => controller.toggleServiceType('bike', val),
            ),
          ),
          const Divider(color: AppColors.stone, height: 12),
          Obx(
            () => _buildServiceSwitch(
              title: 'Go Parcel Delivery',
              subtitle: 'Receive package pickup and drop requests',
              value: controller.isParcelEnabled.value,
              onChanged: (val) => controller.toggleServiceType('parcel', val),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.nearBlack,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.softSlate,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: AppColors.deepForestGreen,
          activeTrackColor: AppColors.primaryLight,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/models/safety_incident_model.dart';
import '../../controllers/safety_centre_controller.dart';

class IncidentReportDialogWidget extends GetView<SafetyCentreController> {
  const IncidentReportDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedType = IncidentType.unsafePickupDrop.obs;
    final textController = TextEditingController();

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
                'Report Safety Incident',
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
          Text(
            'Select Incident Category:',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Obx(
            () => Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: IncidentType.values.map((type) {
                final isSelected = selectedType.value == type;
                return ChoiceChip(
                  label: Text(type.title, style: TextStyle(fontSize: 11.sp)),
                  selected: isSelected,
                  selectedColor: AppColors.primaryLight,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.deepForestGreen : AppColors.softSlate,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  onSelected: (val) {
                    if (val) selectedType.value = type;
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 14.h),
          TextField(
            controller: textController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Briefly explain what occurred...',
              hintStyle: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.stone,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.deepForestGreen,
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
            ),
            onPressed: () {
              if (textController.text.trim().isEmpty) {
                Get.snackbar('Input Required', 'Please enter incident details.');
                return;
              }
              controller.submitIncidentReport(
                type: selectedType.value,
                details: textController.text.trim(),
              );
              Get.back();
            },
            child: Text(
              'Submit Report for Immediate Review',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

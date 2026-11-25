import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/models/document_compliance_model.dart';
import '../../controllers/kyc_documents_controller.dart';

class LearningModuleCardWidget extends GetView<KycDocumentsController> {
  final LearningModuleItem module;

  const LearningModuleCardWidget({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.warmBeige, width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: module.isCompleted ? AppColors.primaryLight : AppColors.surfaceWarm,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              module.isCompleted ? Iconsax.award : Iconsax.video_play,
              size: 18.sp,
              color: module.isCompleted ? AppColors.freshGreen : AppColors.deepForestGreen,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  module.title,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.nearBlack,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${module.durationMinutes} mins • ${module.summary}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardDetails.copyWith(
                    fontSize: 11.sp,
                    color: AppColors.softSlate,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),
          if (module.isCompleted)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                'Passed 100%',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepForestGreen,
                ),
              ),
            )
          else
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deepForestGreen,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                minimumSize: Size(0, 30.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              onPressed: () => controller.completeLearningQuiz(module.id),
              child: Text(
                'Take Quiz',
                style: TextStyle(fontSize: 10.5.sp, color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
        ],
      ),
    );
  }
}

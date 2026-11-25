import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/config/app_typography.dart';
import '../../../data/config/appcolor.dart';
import '../controllers/kyc_documents_controller.dart';
import 'widgets/document_item_card_widget.dart';
import 'widgets/learning_module_card_widget.dart';

class KycDocumentsView extends GetView<KycDocumentsController> {
  const KycDocumentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppBar(
        backgroundColor: AppColors.warmIvory,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Documents & Compliance',
          style: AppTypography.headingLarge.copyWith(
            fontSize: 18.sp,
            color: AppColors.nearBlack,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Compliance Status Summary Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  gradient: AppColors.forestCharcoalGradient,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42.r,
                      height: 42.r,
                      decoration: BoxDecoration(
                        color: AppColors.champagneGold.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(Iconsax.shield_security, color: AppColors.champagneGold, size: 22.sp),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Duty Eligible Status: Active',
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '1 document expiring soon. Keep your credentials up to date to prevent duty lockout.',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.stone,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Required Documents List
              Text(
                'Required Documents (4)',
                style: AppTypography.headingLarge.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.nearBlack,
                ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => Column(
                  children: controller.documentsList
                      .map((doc) => DocumentItemCardWidget(document: doc))
                      .toList(),
                ),
              ),
              SizedBox(height: 18.h),

              // Operational Training Modules
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Operational Learning Modules',
                    style: AppTypography.headingLarge.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.nearBlack,
                    ),
                  ),
                  Text(
                    '3 of 4 Passed',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.deepForestGreen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Obx(
                () => Column(
                  children: controller.learningModulesList
                      .map((module) => LearningModuleCardWidget(module: module))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

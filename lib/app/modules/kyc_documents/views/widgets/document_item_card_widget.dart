import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/models/document_compliance_model.dart';
import '../../controllers/kyc_documents_controller.dart';

class DocumentItemCardWidget extends GetView<KycDocumentsController> {
  final DocumentComplianceItem document;

  const DocumentItemCardWidget({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    Color badgeBg;
    Color badgeText;
    IconData statusIcon;

    switch (document.status) {
      case DocumentStatus.verified:
        badgeBg = AppColors.primaryLight;
        badgeText = AppColors.deepForestGreen;
        statusIcon = Iconsax.verify;
        break;
      case DocumentStatus.underReview:
        badgeBg = const Color(0xFFDBEAFE);
        badgeText = const Color(0xFF1D4ED8);
        statusIcon = Iconsax.clock;
        break;
      case DocumentStatus.expiringSoon:
        badgeBg = const Color(0xFFFEF3C7);
        badgeText = const Color(0xFFB45309);
        statusIcon = Iconsax.warning_2;
        break;
      case DocumentStatus.actionRequired:
        badgeBg = const Color(0xFFFEE2E2);
        badgeText = AppColors.error;
        statusIcon = Iconsax.close_circle;
        break;
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: document.status == DocumentStatus.expiringSoon
              ? const Color(0xFFF59E0B).withValues(alpha: 0.5)
              : AppColors.warmBeige,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  document.title,
                  style: AppTypography.headingLarge.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.nearBlack,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 12.sp, color: badgeText),
                    SizedBox(width: 4.w),
                    Text(
                      document.status.label,
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w700,
                        color: badgeText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            document.description,
            style: AppTypography.cardDetails.copyWith(
              fontSize: 11.sp,
              color: AppColors.softSlate,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Doc ID: ${document.documentNumber}',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.nearBlack,
                ),
              ),
              if (document.expiryDate != null)
                Text(
                  'Expires in ${document.daysUntilExpiry} days',
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w600,
                    color: document.daysUntilExpiry < 30 ? const Color(0xFFB45309) : AppColors.softSlate,
                  ),
                ),
            ],
          ),
          if (document.requiredActionNotice.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFFDE68A), width: 1.w),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.info_circle, size: 14.sp, color: const Color(0xFFB45309)),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      document.requiredActionNotice,
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        color: const Color(0xFF92400E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                side: BorderSide(color: AppColors.deepForestGreen, width: 1.w),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
              onPressed: () => controller.simulateDocumentUpload(document.id),
              icon: Icon(Iconsax.camera, size: 14.sp, color: AppColors.deepForestGreen),
              label: Text(
                'Update & Upload',
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepForestGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

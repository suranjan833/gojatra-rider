import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/config/app_typography.dart';
import '../../../data/config/appcolor.dart';
import '../../../data/models/safety_incident_model.dart';
import '../controllers/safety_centre_controller.dart';
import 'widgets/incident_report_dialog_widget.dart';
import 'widgets/sos_trigger_card_widget.dart';

class SafetyCentreView extends GetView<SafetyCentreController> {
  const SafetyCentreView({super.key});

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
          'Captain Safety Centre',
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
              // Emergency SOS Card
              const SosTriggerCardWidget(),
              SizedBox(height: 18.h),

              // Emergency Calling & Sharing Actions
              Text(
                'Quick Safety Assistance',
                style: AppTypography.headingLarge.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.nearBlack,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _buildActionTile(
                      title: 'Police 112',
                      subtitle: 'Emergency dial',
                      icon: Icons.local_police_rounded,
                      iconColor: AppColors.error,
                      onTap: () => controller.callEmergencyPolice(),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildActionTile(
                      title: 'Safety Ops',
                      subtitle: '24/7 Response',
                      icon: Iconsax.headphone,
                      iconColor: AppColors.deepForestGreen,
                      onTap: () => controller.callSafetyDesk(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              _buildActionTile(
                title: 'Share Live Trip with Emergency Contact',
                subtitle: 'Sunita Das (+91 98310 98765)',
                icon: Iconsax.share,
                iconColor: AppColors.deepForestGreen,
                onTap: () => controller.shareLiveLocationWithContact(),
              ),
              SizedBox(height: 20.h),

              // Report Incident Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Incident Cases & Reports',
                    style: AppTypography.headingLarge.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.nearBlack,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Get.bottomSheet(
                        const IncidentReportDialogWidget(),
                        isScrollControlled: true,
                      );
                    },
                    icon: Icon(Iconsax.add_circle, size: 16.sp, color: AppColors.deepForestGreen),
                    label: Text(
                      'Report Issue',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.deepForestGreen,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Cases List
              Obx(() {
                final list = controller.incidentsList;
                if (list.isEmpty) {
                  return Container(
                    padding: EdgeInsets.all(20.r),
                    alignment: Alignment.center,
                    child: Text(
                      'No safety incidents reported.',
                      style: TextStyle(color: AppColors.softSlate, fontSize: 12.sp),
                    ),
                  );
                }
                return Column(
                  children: list.map((incident) => _buildIncidentCard(incident)).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
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
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, size: 18.sp, color: iconColor),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.nearBlack,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      color: AppColors.softSlate,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentCard(SafetyIncident incident) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.warmBeige, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                incident.type.title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.nearBlack,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  incident.status,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFB45309),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            incident.details,
            style: AppTypography.cardDetails.copyWith(
              fontSize: 11.sp,
              color: AppColors.softSlate,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Case Ref: ${incident.caseId} • Trip: ${incident.tripId ?? 'N/A'}',
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/config/app_typography.dart';
import '../../../data/config/appcolor.dart';
import '../controllers/profile_controller.dart';
import 'widgets/preferences_sheet_widget.dart';
import 'widgets/profile_header_card_widget.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppBar(
        backgroundColor: AppColors.warmIvory,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Captain Profile & Settings',
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
              // Captain Profile & Vehicle Card
              const ProfileHeaderCardWidget(),
              SizedBox(height: 16.h),

              // Service Categories Allowed
              const PreferencesSheetWidget(),
              SizedBox(height: 16.h),

              // Account & Compliance List
              _buildSectionHeader('Compliance & Safety'),
              _buildMenuCard([
                _buildMenuItem(
                  title: 'Documents & Verification',
                  subtitle: 'RC, Driving Licence, Commercial Insurance',
                  icon: Iconsax.document_text,
                  iconColor: AppColors.deepForestGreen,
                  onTap: () => controller.openDocuments(),
                ),
                const Divider(color: AppColors.stone, height: 1),
                _buildMenuItem(
                  title: 'Safety Centre & SOS',
                  subtitle: 'Emergency hotline, trusted contacts & incident reports',
                  icon: Iconsax.shield_tick,
                  iconColor: AppColors.freshGreen,
                  onTap: () => controller.openSafetyCentre(),
                ),
              ]),
              SizedBox(height: 16.h),

              // App Preferences
              _buildSectionHeader('Preferences'),
              _buildMenuCard([
                Obx(
                  () => _buildMenuItem(
                    title: 'Navigation App Preference',
                    subtitle: controller.selectedNavigation.value,
                    icon: Iconsax.map,
                    iconColor: AppColors.deepForestGreen,
                    onTap: () => _showNavigationDialog(context),
                  ),
                ),
                const Divider(color: AppColors.stone, height: 1),
                Obx(
                  () => _buildMenuItem(
                    title: 'App Language',
                    subtitle: controller.selectedLanguage.value,
                    icon: Iconsax.language_square,
                    iconColor: AppColors.deepForestGreen,
                    onTap: () => _showLanguageDialog(context),
                  ),
                ),
              ]),
              SizedBox(height: 16.h),

              // Help & Legal
              _buildSectionHeader('Support & Legal'),
              _buildMenuCard([
                _buildMenuItem(
                  title: 'Help & 24/7 Captain Support',
                  subtitle: 'FAQs, ticket history and phone callback',
                  icon: Iconsax.headphone,
                  iconColor: AppColors.deepForestGreen,
                  onTap: () {
                    Get.snackbar('Support', '24/7 Captain Support Desk: 1800-GO-JATRA');
                  },
                ),
                const Divider(color: AppColors.stone, height: 1),
                _buildMenuItem(
                  title: 'Terms of Service & Captain Policies',
                  subtitle: 'Standard operational guidelines and fare policies',
                  icon: Iconsax.info_circle,
                  iconColor: AppColors.softSlate,
                  onTap: () {
                    Get.snackbar('Policies', 'GO JATRA Captain Operational Policy v2.4');
                  },
                ),
              ]),
              SizedBox(height: 20.h),

              // Logout Button
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48.h),
                  side: const BorderSide(color: AppColors.error),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                ),
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  controller.logout();
                },
                icon: Icon(Iconsax.logout, size: 18.sp, color: AppColors.error),
                label: Text(
                  'Log Out of Captain Account',
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 2.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.softSlate,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.warmBeige, width: 1.w),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem({
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
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
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
            SizedBox(width: 12.w),
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
            Icon(Icons.arrow_forward_ios_rounded, size: 13.sp, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  void _showNavigationDialog(BuildContext context) {
    Get.dialog(
      SimpleDialog(
        title: const Text('Choose Navigation App'),
        children: ['Google Maps', 'Apple Maps', 'Waze'].map((app) {
          return SimpleDialogOption(
            onPressed: () {
              controller.setNavigationApp(app);
              Get.back();
            },
            child: Text(app),
          );
        }).toList(),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    Get.dialog(
      SimpleDialog(
        title: const Text('Choose App Language'),
        children: ['English', 'বাংলা (Bengali)', 'हिन्दी (Hindi)'].map((lang) {
          return SimpleDialogOption(
            onPressed: () {
              controller.setLanguage(lang);
              Get.back();
            },
            child: Text(lang),
          );
        }).toList(),
      ),
    );
  }
}

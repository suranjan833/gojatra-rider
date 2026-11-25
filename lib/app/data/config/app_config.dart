import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'appcolor.dart';
import 'app_typography.dart';

class AppConfig {
  AppConfig._();

  static const String appName = 'Go Jatra Rider';
  static const String appVersion = '1.0.0';

  static void showSuccess({
    required String title,
    required String message,
  }) {
    _showCustomSnackbar(
      title: title,
      message: message,
      iconData: Iconsax.tick_circle,
      accentColor: AppColors.freshGreen,
    );
  }

  static void showError({
    required String title,
    required String message,
  }) {
    _showCustomSnackbar(
      title: title,
      message: message,
      iconData: Iconsax.close_circle,
      accentColor: AppColors.error,
    );
  }

  static void showWarning({
    required String title,
    required String message,
  }) {
    _showCustomSnackbar(
      title: title,
      message: message,
      iconData: Iconsax.info_circle,
      accentColor: AppColors.champagneGold,
    );
  }

  static void showInfo({
    required String title,
    required String message,
  }) {
    _showCustomSnackbar(
      title: title,
      message: message,
      iconData: Iconsax.information,
      accentColor: AppColors.info,
    );
  }

  static void _showCustomSnackbar({
    required String title,
    required String message,
    required IconData iconData,
    required Color accentColor,
  }) {
    if (Get.context == null) return;

    double horizontalMargin = 24;
    double verticalMargin = 16;
    double horizontalPadding = 16;
    double verticalPadding = 14;
    double radius = 16;
    double iconBoxSize = 36;
    double iconSize = 20;

    try {
      horizontalMargin = 24.w;
      verticalMargin = 16.h;
      horizontalPadding = 16.w;
      verticalPadding = 14.h;
      radius = 16.r;
      iconBoxSize = 36.r;
      iconSize = 20.sp;
    } catch (_) {}

    Get.rawSnackbar(
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: verticalMargin),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      backgroundColor: Colors.white,
      borderRadius: radius,
      borderColor: const Color(0xFFEBE6DC),
      borderWidth: 1.0,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ],
      icon: Container(
        width: iconBoxSize,
        height: iconBoxSize,
        decoration: BoxDecoration(
          color: accentColor.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            iconData,
            size: iconSize,
            color: accentColor,
          ),
        ),
      ),
      titleText: Text(
        title,
        style: AppTypography.locationTitle.copyWith(
          color: AppColors.nearBlack,
          fontWeight: FontWeight.w700,
        ),
      ),
      messageText: Text(
        message,
        style: AppTypography.legalCopy.copyWith(
          color: AppColors.softSlate,
        ),
      ),
      duration: const Duration(seconds: 3),
    );
  }
}

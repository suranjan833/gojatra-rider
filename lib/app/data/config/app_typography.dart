import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import 'appcolor.dart';

class AppTypography {
  AppTypography._();

  static double _sp(double size) {
    try {
      return size.sp;
    } catch (_) {
      return size;
    }
  }

  static TextStyle get brandTitle => GoogleFonts.manrope(
        fontSize: _sp(44),
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
        color: AppColors.nearBlack,
      );

  static TextStyle get splashTitle => brandTitle;

  static TextStyle get mainHeadline => GoogleFonts.manrope(
        fontSize: _sp(36),
        fontWeight: FontWeight.w700,
        height: 44 / 36,
        letterSpacing: -0.5,
        color: AppColors.nearBlack,
      );

  static TextStyle get destinationQuestion => GoogleFonts.manrope(
        fontSize: _sp(30),
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.5,
        color: AppColors.nearBlack,
      );

  static TextStyle get fare => GoogleFonts.manrope(
        fontSize: _sp(28),
        fontWeight: FontWeight.w800,
        letterSpacing: -0.6,
        color: AppColors.nearBlack,
      );

  static TextStyle get sectionTitle => GoogleFonts.manrope(
        fontSize: _sp(24),
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: AppColors.nearBlack,
      );

  static TextStyle get headingLarge => GoogleFonts.manrope(
        fontSize: _sp(22),
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: AppColors.nearBlack,
      );

  static TextStyle get logoWordmark => GoogleFonts.manrope(
        fontSize: _sp(20),
        fontWeight: FontWeight.w700,
        height: 24 / 20,
        letterSpacing: 0.5,
        color: AppColors.nearBlack,
      );

  static TextStyle get primaryButton => GoogleFonts.manrope(
        fontSize: _sp(18),
        fontWeight: FontWeight.w700,
        height: 24 / 18,
        color: Colors.white,
      );

  static TextStyle get inputText => GoogleFonts.manrope(
        fontSize: _sp(18),
        fontWeight: FontWeight.w500,
        height: 24 / 18,
        color: AppColors.nearBlack,
      );

  static TextStyle get supportingCopy => GoogleFonts.manrope(
        fontSize: _sp(17),
        fontWeight: FontWeight.w500,
        height: 25 / 17,
        color: AppColors.softSlate,
      );

  static TextStyle get rideName => GoogleFonts.manrope(
        fontSize: _sp(17),
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: AppColors.nearBlack,
      );

  static TextStyle get secondaryAction => GoogleFonts.manrope(
        fontSize: _sp(16),
        fontWeight: FontWeight.w600,
        height: 24 / 16,
        color: AppColors.nearBlack,
      );

  static TextStyle get locationTitle => GoogleFonts.manrope(
        fontSize: _sp(14),
        fontWeight: FontWeight.w700,
        color: AppColors.nearBlack,
      );

  static TextStyle get welcomeLabel => GoogleFonts.manrope(
        fontSize: _sp(13),
        fontWeight: FontWeight.w700,
        height: 18 / 13,
        letterSpacing: 1.2,
        color: AppColors.softSlate,
      );

  static TextStyle get cardDetails => GoogleFonts.manrope(
        fontSize: _sp(13),
        fontWeight: FontWeight.w500,
        letterSpacing: -0.1,
        color: AppColors.softSlate,
      );

  static TextStyle get legalCopy => GoogleFonts.manrope(
        fontSize: _sp(12),
        fontWeight: FontWeight.w500,
        height: 18 / 12,
        color: AppColors.textMuted,
      );

  static TextStyle get recommendedBadge => GoogleFonts.manrope(
        fontSize: _sp(11),
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
        color: AppColors.nearBlack,
      );
}

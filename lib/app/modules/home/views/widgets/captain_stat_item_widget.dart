import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import '../../controllers/home_controller.dart';

class CaptainStatItemWidget extends GetView<HomeController> {
  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;

  const CaptainStatItemWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 14.sp,
              color: iconColor ?? AppColors.deepForestGreen,
            ),
            SizedBox(width: 4.w),
            Flexible(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.locationTitle.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.nearBlack,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTypography.cardDetails.copyWith(
            fontSize: 11.sp,
            color: AppColors.softSlate,
          ),
        ),
      ],
    );
  }
}

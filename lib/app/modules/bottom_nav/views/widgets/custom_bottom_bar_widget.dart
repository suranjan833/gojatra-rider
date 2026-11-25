import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/app_typography.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import '../../controllers/bottom_nav_controller.dart';

class CustomBottomBarWidget extends GetView<BottomNavController> {
  const CustomBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16.r,
            offset: const Offset(0, -4),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: AppColors.warmBeige,
            width: 1.w,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        top: 8.h,
        bottom: 12.h,
        left: 12.w,
        right: 12.w,
      ),
      child: Obx(() {
        final current = controller.currentIndex.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: _buildNavItem(
                index: 0,
                isSelected: current == 0,
                icon: Iconsax.home_2,
                activeIcon: Iconsax.home,
                label: 'Home',
              ),
            ),
            Expanded(
              child: _buildNavItem(
                index: 1,
                isSelected: current == 1,
                icon: Iconsax.wallet_2,
                activeIcon: Iconsax.wallet_3,
                label: 'Earnings',
              ),
            ),
            Expanded(
              child: _buildNavItem(
                index: 2,
                isSelected: current == 2,
                icon: Iconsax.routing,
                activeIcon: Iconsax.routing_2,
                label: 'Trips',
              ),
            ),
            Expanded(
              child: _buildNavItem(
                index: 3,
                isSelected: current == 3,
                icon: Iconsax.user,
                activeIcon: Iconsax.user_edit,
                label: 'Profile',
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildNavItem({
    required int index,
    required bool isSelected,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        controller.changeTab(index);
      },
      borderRadius: BorderRadius.circular(16.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 14.w : 10.w,
          vertical: 6.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 22.sp,
              color: isSelected ? AppColors.deepForestGreen : AppColors.softSlate,
            ),
            SizedBox(height: 3.h),
            Text(
              label,
              style: AppTypography.cardDetails.copyWith(
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.deepForestGreen : AppColors.softSlate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

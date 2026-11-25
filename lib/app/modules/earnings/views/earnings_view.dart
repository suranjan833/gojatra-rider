import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/config/app_typography.dart';
import '../../../data/config/appcolor.dart';
import '../controllers/earnings_controller.dart';
import 'widgets/earnings_metric_cards_widget.dart';
import 'widgets/incentive_card_widget.dart';
import 'widgets/payout_sheet_widget.dart';

class EarningsView extends GetView<EarningsController> {
  const EarningsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppBar(
        backgroundColor: AppColors.warmIvory,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Earnings & Payouts',
          style: AppTypography.headingLarge.copyWith(
            fontSize: 18.sp,
            color: AppColors.nearBlack,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.document_download, color: AppColors.deepForestGreen, size: 22.sp),
            onPressed: () {
              HapticFeedback.selectionClick();
              Get.snackbar(
                'Statement Download',
                'Your PDF weekly settlement statement has been saved.',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
          SizedBox(width: 8.w),
        ],
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
              // Timeframe Selector Chips
              _buildTimeframeSelector(),
              SizedBox(height: 16.h),

              // Metrics & Breakdown
              const EarningsMetricCardsWidget(),
              SizedBox(height: 16.h),

              // Payout card
              const PayoutSheetWidget(),
              SizedBox(height: 20.h),

              // Incentives & Quests
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Incentives & Quests',
                    style: AppTypography.headingLarge.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.nearBlack,
                    ),
                  ),
                  Text(
                    '3 Available',
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
                  children: controller.incentivesList
                      .map((target) => IncentiveCardWidget(target: target))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return Obx(() {
      final selected = controller.selectedTimeframe.value;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildChip('Today', EarningsTimeframe.today, selected == EarningsTimeframe.today),
            SizedBox(width: 8.w),
            _buildChip('This Week', EarningsTimeframe.thisWeek, selected == EarningsTimeframe.thisWeek),
            SizedBox(width: 8.w),
            _buildChip('This Month', EarningsTimeframe.thisMonth, selected == EarningsTimeframe.thisMonth),
          ],
        ),
      );
    });
  }

  Widget _buildChip(String label, EarningsTimeframe timeframe, bool isSelected) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        controller.setTimeframe(timeframe);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.deepForestGreen : AppColors.softWhite,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.deepForestGreen : AppColors.warmBeige,
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.softSlate,
          ),
        ),
      ),
    );
  }
}

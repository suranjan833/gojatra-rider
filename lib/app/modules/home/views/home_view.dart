import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/config/appcolor.dart';
import '../../../data/config/app_typography.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'widgets/captain_stat_item_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppBar(
        title: Text(
          'Go Jatra Captain',
          style: AppTypography.logoWordmark,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Iconsax.notification, size: 22.sp, color: AppColors.nearBlack),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 16.h,
            bottom: 96.h, // 96dp padding for bottom navigation per features.md
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pre-flight check row
              Obx(() {
                final isOnline = controller.isOnline.value;
                if (isOnline) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.gps, size: 14.sp, color: AppColors.deepForestGreen),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'GPS Heartbeat Active • Battery-friendly tracking',
                            style: TextStyle(
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepForestGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.stone,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPreflightItem('GPS', controller.isGpsEnabled.value),
                        _buildPreflightItem('Network', controller.isNetworkConnected.value),
                        _buildPreflightItem('Docs', controller.isDocumentsValid.value),
                        _buildPreflightItem('Vehicle', controller.isVehicleSelected.value),
                      ],
                    ),
                  );
                }
              }),
              // 1. Captain Online / Offline Duty Card
              Obx(() {
                final isOnline = controller.isOnline.value;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    gradient: isOnline
                        ? AppColors.forestCharcoalGradient
                        : const LinearGradient(
                            colors: [Color(0xFF333835), Color(0xFF222624)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 16.r,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12.r,
                        height: 12.r,
                        decoration: BoxDecoration(
                          color: isOnline ? AppColors.freshGreen : AppColors.softSlate,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isOnline ? 'YOU ARE ONLINE' : 'YOU ARE OFFLINE',
                              style: AppTypography.welcomeLabel.copyWith(
                                color: isOnline ? AppColors.champagneGold : AppColors.textMuted,
                                fontSize: 10.5.sp,
                                letterSpacing: 1.1,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              isOnline ? 'Ready for Incoming Rides' : 'Turn Online to Receive Rides',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.headingLarge.copyWith(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Duty Switch
                      Switch(
                        value: isOnline,
                        activeColor: AppColors.freshGreen,
                        activeTrackColor: AppColors.primaryMuted,
                        inactiveThumbColor: AppColors.warmBeige,
                        inactiveTrackColor: AppColors.softSlate.withValues(alpha: 0.4),
                        onChanged: (_) => controller.toggleDuty(),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 16.h),

              // 2. Today's Performance & Earnings Summary Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.softWhite,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.warmBeige, width: 1.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 14.r,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'TODAY\'S EARNINGS',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.welcomeLabel.copyWith(
                              fontSize: 11.sp,
                              color: AppColors.softSlate,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            'Captain Tier 1',
                            style: AppTypography.recommendedBadge.copyWith(
                              fontSize: 10.sp,
                              color: AppColors.deepForestGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => Text(
                        '₹${controller.todayEarnings.value.toStringAsFixed(2)}',
                        style: AppTypography.fare.copyWith(
                          color: AppColors.nearBlack,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    const Divider(color: AppColors.warmBeige, height: 1),
                    SizedBox(height: 14.h),

                    // Stats Row
                    Row(
                      children: [
                        Expanded(
                          child: CaptainStatItemWidget(
                            label: 'Completed',
                            value: '${controller.completedTrips.value} trips',
                            icon: Iconsax.car,
                          ),
                        ),
                        Container(width: 1.w, height: 32.h, color: AppColors.warmBeige),
                        Expanded(
                          child: CaptainStatItemWidget(
                            label: 'Rating',
                            value: '${controller.captainRating.value} ★',
                            icon: Icons.star_rounded,
                            iconColor: const Color(0xFFD97706),
                          ),
                        ),
                        Container(width: 1.w, height: 32.h, color: AppColors.warmBeige),
                        Expanded(
                          child: CaptainStatItemWidget(
                            label: 'Acceptance',
                            value: controller.acceptanceRate.value,
                            icon: Iconsax.tick_circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // 3. High Demand Area Alert
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWarm,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.warmBeige, width: 1.w),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEF3C7),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Iconsax.flash_1,
                          size: 18.sp,
                          color: const Color(0xFFD97706),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Salt Lake Sector V',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.locationTitle.copyWith(
                                    fontSize: 13.5.sp,
                                    color: AppColors.nearBlack,
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  '1.3x Surge',
                                  style: TextStyle(
                                    fontSize: 9.5.sp,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'High ride demand • 1.2 km away from your location',
                            style: AppTypography.cardDetails.copyWith(
                              fontSize: 11.sp,
                              color: AppColors.softSlate,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // 4. Primary CTA to Open Accept Ride View
              InkWell(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.toNamed(Routes.ACCEPT_RIDE);
                },
                borderRadius: BorderRadius.circular(18.r),
                child: Container(
                  width: double.infinity,
                  height: 54.h,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.deepForestGreen.withValues(alpha: 0.35),
                        blurRadius: 16.r,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.routing,
                            size: 19.sp,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: Text(
                              'Open Accept Ride View',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.primaryButton.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreflightItem(String label, bool isOk) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isOk ? Icons.check_circle_rounded : Icons.cancel_rounded,
          size: 13.sp,
          color: isOk ? AppColors.freshGreen : AppColors.error,
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.nearBlack,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/data/config/app_typography.dart';
import '../../controllers/accept_ride_controller.dart';

class RideActionButtonsWidget extends GetView<AcceptRideController> {
  const RideActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isAccepting = controller.status.value == RideRequestStatus.accepting;

      return Row(
        children: [
          // 1. Pass / Decline Button
          SizedBox(
            width: 80.w,
            height: 54.h,
            child: InkWell(
              onTap: isAccepting ? null : () => controller.declineRide(),
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.45),
                    width: 1.2.w,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.close_circle,
                        size: 16.sp,
                        color: const Color(0xFFDC2626),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Pass',
                        style: AppTypography.secondaryAction.copyWith(
                          color: const Color(0xFFDC2626),
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // 2. Interactive Swipe to Accept Slider Track
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final trackWidth = constraints.maxWidth;
                final thumbSize = 44.r;
                final maxDragDistance = trackWidth - thumbSize - 8.w;

                return Container(
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
                  child: isAccepting
                      ? const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            // Shimmering / Fading Text Track in center
                            Center(
                              child: Obx(() {
                                final textOpacity = (1.0 - (controller.swipeProgress.value * 1.6))
                                    .clamp(0.0, 1.0);
                                return Opacity(
                                  opacity: textOpacity,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 36.w, right: 10.w),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Swipe to Accept',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTypography.primaryButton.copyWith(
                                              fontSize: 13.5.sp,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 0.3,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Icon(
                                          Iconsax.arrow_right_3,
                                          size: 14.sp,
                                          color: Colors.white.withValues(alpha: 0.7),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),

                            // Draggable Slider Thumb
                            Obx(() {
                              final currentLeft = 4.w + (controller.swipeProgress.value * maxDragDistance);

                              return Positioned(
                                left: currentLeft,
                                top: 5.h,
                                child: GestureDetector(
                                  onTap: () {
                                    // Tap also supported to accept
                                    HapticFeedback.lightImpact();
                                    controller.acceptRide();
                                  },
                                  onHorizontalDragUpdate: (details) {
                                    final currentPos = (controller.swipeProgress.value * maxDragDistance) + details.delta.dx;
                                    final newRatio = (currentPos / maxDragDistance).clamp(0.0, 1.0);
                                    if ((controller.swipeProgress.value < 0.5 && newRatio >= 0.5) ||
                                        (controller.swipeProgress.value < 0.8 && newRatio >= 0.8)) {
                                      HapticFeedback.selectionClick();
                                    }
                                    controller.updateSwipeProgress(newRatio);
                                  },
                                  onHorizontalDragEnd: (details) {
                                    if (controller.swipeProgress.value >= 0.65) {
                                      controller.acceptRide();
                                    } else {
                                      controller.resetSwipe();
                                      HapticFeedback.lightImpact();
                                    }
                                  },
                                  child: Container(
                                    width: thumbSize,
                                    height: thumbSize,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.22),
                                          blurRadius: 10.r,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Iconsax.arrow_right_3,
                                        size: 19.sp,
                                        color: AppColors.deepForestGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

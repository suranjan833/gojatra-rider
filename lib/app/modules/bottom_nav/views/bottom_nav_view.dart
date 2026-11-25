import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/config/appcolor.dart';
import '../../earnings/views/earnings_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../trips/views/trips_view.dart';
import '../controllers/bottom_nav_controller.dart';
import 'widgets/custom_bottom_bar_widget.dart';

class BottomNavView extends GetView<BottomNavController> {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      body: Stack(
        children: [
          // Indexed tabs view
          Obx(
            () => IndexedStack(
              index: controller.currentIndex.value,
              children: const [
                HomeView(),
                EarningsView(),
                TripsView(),
                ProfileView(),
              ],
            ),
          ),

          // Fixed bottom bar outside scroll view
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomBarWidget(),
          ),
        ],
      ),
    );
  }
}

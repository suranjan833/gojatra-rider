import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import '../../../data/config/appcolor.dart';
import '../controllers/accept_ride_controller.dart';
import 'widgets/ride_accepted_view_widget.dart';
import 'widgets/ride_map_header_widget.dart';
import 'widgets/ride_request_sheet_widget.dart';
import 'widgets/ride_status_overlay_widget.dart';

class AcceptRideView extends GetView<AcceptRideController> {
  const AcceptRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      body: Stack(
        children: [
          // 1. Top Simulated Map & Live Radar Route Area
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: RideMapHeaderWidget(),
          ),

          // 2. Dynamic Content Area based on Ride Request Lifecycle
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(() {
              final status = controller.status.value;

              switch (status) {
                case RideRequestStatus.incoming:
                case RideRequestStatus.accepting:
                  return const RideRequestSheetWidget();

                case RideRequestStatus.accepted:
                case RideRequestStatus.navigating:
                case RideRequestStatus.arrived:
                case RideRequestStatus.inTrip:
                case RideRequestStatus.payment:
                case RideRequestStatus.completed:
                  return const RideAcceptedViewWidget();

                case RideRequestStatus.declined:
                case RideRequestStatus.expired:
                  return const RideStatusOverlayWidget();
              }
            }),
          ),
        ],
      ),
    );
  }
}

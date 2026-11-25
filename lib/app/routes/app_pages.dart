import 'package:get/get.dart';

import '../modules/accept_ride/bindings/accept_ride_binding.dart';
import '../modules/accept_ride/views/accept_ride_view.dart';
import '../modules/bottom_nav/bindings/bottom_nav_binding.dart';
import '../modules/bottom_nav/views/bottom_nav_view.dart';
import '../modules/earnings/bindings/earnings_binding.dart';
import '../modules/earnings/views/earnings_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kyc_documents/bindings/kyc_documents_binding.dart';
import '../modules/kyc_documents/views/kyc_documents_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/safety_centre/bindings/safety_centre_binding.dart';
import '../modules/safety_centre/views/safety_centre_view.dart';
import '../modules/trips/bindings/trips_binding.dart';
import '../modules/trips/views/trips_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.BOTTOM_NAV;

  static final routes = [
    GetPage(
      name: _Paths.BOTTOM_NAV,
      page: () => const BottomNavView(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ACCEPT_RIDE,
      page: () => const AcceptRideView(),
      binding: AcceptRideBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.EARNINGS,
      page: () => const EarningsView(),
      binding: EarningsBinding(),
    ),
    GetPage(
      name: _Paths.TRIPS,
      page: () => const TripsView(),
      binding: TripsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.KYC_DOCUMENTS,
      page: () => const KycDocumentsView(),
      binding: KycDocumentsBinding(),
    ),
    GetPage(
      name: _Paths.SAFETY_CENTRE,
      page: () => const SafetyCentreView(),
      binding: SafetyCentreBinding(),
    ),
  ];
}

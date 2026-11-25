import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:gojatrarider/app/modules/accept_ride/bindings/accept_ride_binding.dart';
import 'package:gojatrarider/app/modules/accept_ride/controllers/accept_ride_controller.dart';
import 'package:gojatrarider/app/modules/accept_ride/views/accept_ride_view.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableApp() {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AcceptRideBinding(),
          localizationsDelegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: const AcceptRideView(),
        );
      },
    );
  }

  group('AcceptRideController & View Tests', () {
    tearDown(() {
      Get.reset();
    });

    testWidgets('Initial state loads mock ride and starts incoming countdown', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2.0;

      await tester.pumpWidget(buildTestableApp());
      await tester.pump();

      final controller = Get.find<AcceptRideController>();
      expect(controller.status.value, RideRequestStatus.incoming);
      expect(controller.currentRide.value, isNotNull);
      expect(controller.currentRide.value!.passengerName, 'Mera passenger');

      expect(find.text('SBS rider'), findsOneWidget);
      expect(find.text('₹245.50'), findsOneWidget);
      expect(find.text('PICKUP LOCATION'), findsOneWidget);
      expect(find.text('DROPOFF DESTINATION'), findsOneWidget);
      expect(find.text('Swipe to Accept'), findsOneWidget);
      expect(find.text('Pass'), findsOneWidget);

      controller.onClose();
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets(
      'acceptRide() transitions to accepted via swipe and shows OTP sheet',
      (tester) async {
        tester.view.physicalSize = const Size(720, 1600);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(buildTestableApp());
        await tester.pump();

        final controller = Get.find<AcceptRideController>();

        // Swipe / Drag the slider thumb to accept
        final thumbFinder = find.byType(GestureDetector).last;
        await tester.drag(thumbFinder, const Offset(200, 0));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 900));

        expect(controller.status.value, RideRequestStatus.accepted);
        expect(find.text('Head to customer pickup location'), findsOneWidget);
        expect(find.text('Pickup OTP Pin:'), findsOneWidget);
        expect(find.text('5824'), findsOneWidget);
        expect(find.text('Start Navigation'), findsOneWidget);

        controller.onClose();
        await tester.pump(const Duration(seconds: 4));
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      },
    );

    testWidgets('declineRide() transitions to declined state', (tester) async {
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2.0;

      await tester.pumpWidget(buildTestableApp());
      await tester.pump();

      final controller = Get.find<AcceptRideController>();

      // Tap Pass
      await tester.tap(find.text('Pass'));
      await tester.pump();

      expect(controller.status.value, RideRequestStatus.declined);
      expect(find.text('Request Declined'), findsOneWidget);
      expect(find.text('Simulate Next Ride'), findsOneWidget);

      controller.onClose();
      await tester.pump(const Duration(seconds: 4));
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('loadNewRequest() cycles to secondary mock request', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2.0;

      await tester.pumpWidget(buildTestableApp());
      await tester.pump();

      final controller = Get.find<AcceptRideController>();
      controller.loadNewRequest();
      await tester.pump();

      expect(controller.currentRide.value!.passengerName, 'Rahul Banerjee');
      expect(find.text('Rahul Banerjee'), findsOneWidget);
      expect(find.text('₹110.00'), findsOneWidget);

      controller.onClose();
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}

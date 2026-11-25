import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:gojatrarider/app/modules/home/bindings/home_binding.dart';
import 'package:gojatrarider/app/modules/home/controllers/home_controller.dart';
import 'package:gojatrarider/app/modules/home/views/home_view.dart';
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
          initialBinding: HomeBinding(),
          localizationsDelegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: const HomeView(),
        );
      },
    );
  }

  group('HomeView & Controller Tests', () {
    tearDown(() {
      Get.reset();
    });

    test('HomeController initializes and toggles duty', () {
      final controller = HomeController();
      expect(controller.isOnline.value, isTrue);
      expect(controller.todayEarnings.value, 1420.50);

      controller.toggleDuty();
      expect(controller.isOnline.value, isFalse);

      controller.toggleDuty();
      expect(controller.isOnline.value, isTrue);
    });

    testWidgets('HomeView renders duty status and stats card', (tester) async {
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(buildTestableApp());
      await tester.pumpAndSettle();

      expect(find.text('Go Jatra Captain'), findsOneWidget);
      expect(find.text('YOU ARE ONLINE'), findsOneWidget);
      expect(find.text('TODAY\'S EARNINGS'), findsOneWidget);
      expect(find.text('₹1420.50'), findsOneWidget);
      expect(find.text('Salt Lake Sector V'), findsOneWidget);
      expect(find.text('Open Accept Ride View'), findsOneWidget);
    });
  });
}

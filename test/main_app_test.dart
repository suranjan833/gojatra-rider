import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:gojatrarider/app/data/config/appcolor.dart';
import 'package:gojatrarider/app/modules/bottom_nav/views/widgets/custom_bottom_bar_widget.dart';
import 'package:gojatrarider/app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App boots with BottomNavView without No MaterialLocalizations found error', (tester) async {
    tester.view.physicalSize = const Size(720, 1600);
    tester.view.devicePixelRatio = 2.0;

    bool hasLocalizationError = false;
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exception.toString().contains('No MaterialLocalizations found')) {
        hasLocalizationError = true;
      }
    };

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: "Go Jatra Rider",
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            localizationsDelegates: const [
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            builder: (context, widgetChild) {
              final theme = ThemeData(
                useMaterial3: true,
                textTheme: GoogleFonts.manropeTextTheme(),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primary,
                  primary: AppColors.primary,
                  secondary: AppColors.champagneGold,
                  surface: AppColors.surface,
                ),
                scaffoldBackgroundColor: AppColors.background,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(color: AppColors.textPrimary),
                ),
              );
              return Theme(
                data: theme,
                child: widgetChild ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );

    await tester.pumpAndSettle();

    expect(hasLocalizationError, isFalse);
    expect(find.text('Go Jatra Captain'), findsOneWidget);
    expect(find.byType(CustomBottomBarWidget), findsOneWidget);

    FlutterError.onError = originalOnError;
    Get.reset();
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

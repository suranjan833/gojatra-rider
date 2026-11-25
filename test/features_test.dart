import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:gojatrarider/app/data/models/document_compliance_model.dart';
import 'package:gojatrarider/app/data/models/safety_incident_model.dart';
import 'package:gojatrarider/app/data/models/trip_record_model.dart';
import 'package:gojatrarider/app/modules/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:gojatrarider/app/modules/earnings/controllers/earnings_controller.dart';
import 'package:gojatrarider/app/modules/kyc_documents/controllers/kyc_documents_controller.dart';
import 'package:gojatrarider/app/modules/profile/controllers/profile_controller.dart';
import 'package:gojatrarider/app/modules/safety_centre/controllers/safety_centre_controller.dart';
import 'package:gojatrarider/app/modules/trips/controllers/trips_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GO JATRA Features.md Feature Set Verification', () {
    tearDown(() {
      Get.reset();
    });

    test(
      '1. BottomNavController switches across all 4 primary destinations',
      () {
        final controller = BottomNavController();
        expect(controller.currentIndex.value, 0);

        controller.changeTab(1);
        expect(controller.currentIndex.value, 1);

        controller.changeTab(2);
        expect(controller.currentIndex.value, 2);

        controller.changeTab(3);
        expect(controller.currentIndex.value, 3);

        controller.changeTab(99); // Out of bounds guard
        expect(controller.currentIndex.value, 3);
      },
    );

    test('2. EarningsController supports timeframes, balance & incentives', () {
      final controller = EarningsController();
      controller.onInit();
      expect(controller.selectedTimeframe.value, EarningsTimeframe.today);
      expect(controller.grossEarnings.value, 1420.50);
      expect(controller.incentivesList.length, 3);

      controller.setTimeframe(EarningsTimeframe.thisWeek);
      expect(controller.grossEarnings.value, 9840.00);
      expect(controller.completedTrips.value, 68);

      controller.requestInstantPayout();
      expect(controller.payoutStatus.value, 'Processing');
    });

    test(
      '3. TripsController filters trips and displays captain quality metrics',
      () {
        final controller = TripsController();
        controller.onInit();
        expect(controller.tripsList.isNotEmpty, isTrue);
        expect(controller.captainRating.value, 4.92);
        expect(controller.acceptanceRate.value, 96.4);

        controller.setFilter(TripsFilter.completed);
        expect(
          controller.filteredTrips.every(
            (t) => t.status == TripStatus.completed,
          ),
          isTrue,
        );

        controller.setFilter(TripsFilter.cancelled);
        expect(
          controller.filteredTrips.every(
            (t) => t.status != TripStatus.completed,
          ),
          isTrue,
        );
      },
    );

    test('4. ProfileController manages vehicle, services and preferences', () {
      final controller = ProfileController();
      expect(controller.captainProfile.value.name, 'SBS');
      expect(
        controller.captainProfile.value.vehicle.registrationNumber,
        'WB 02 AJ 4492',
      );

      expect(controller.isBikeEnabled.value, isTrue);
      controller.toggleServiceType('bike', false);
      expect(controller.isBikeEnabled.value, isFalse);

      controller.setNavigationApp('Waze');
      expect(controller.selectedNavigation.value, 'Waze');

      controller.setLanguage('বাংলা (Bengali)');
      expect(controller.selectedLanguage.value, 'বাংলা (Bengali)');
    });

    test(
      '5. KycDocumentsController tracks expiry dates, uploads, and quizzes',
      () {
        final controller = KycDocumentsController();
        controller.onInit();
        expect(controller.documentsList.length, 4);
        expect(controller.learningModulesList.length, 4);

        final insuranceDoc = controller.documentsList.firstWhere(
          (d) => d.id == 'insurance',
        );
        expect(insuranceDoc.status, DocumentStatus.expiringSoon);

        controller.completeLearningQuiz('parcel_4');
        final parcelModule = controller.learningModulesList.firstWhere(
          (m) => m.id == 'parcel_4',
        );
        expect(parcelModule.isCompleted, isTrue);
        expect(parcelModule.quizScorePercent, 100);
      },
    );

    test('6. SafetyCentreController handles SOS, contact sharing, and incident logging', () {
      final controller = SafetyCentreController();
      controller.onInit();
      expect(controller.isSosTriggered.value, isFalse);

      controller.triggerSos();
      expect(controller.isSosTriggered.value, isTrue);

      controller.shareLiveLocationWithContact();
      expect(controller.trustedContactShared.value, isTrue);

      final initialCases = controller.incidentsList.length;
      controller.submitIncidentReport(
        type: IncidentType.passengerMisconduct,
        details: 'Passenger was verbally aggressive regarding shortcut.',
      );
      expect(controller.incidentsList.length, initialCases + 1);
      expect(
        controller.incidentsList.first.type,
        IncidentType.passengerMisconduct,
      );
    });
  });
}

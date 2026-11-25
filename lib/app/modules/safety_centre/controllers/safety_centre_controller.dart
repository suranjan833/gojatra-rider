import 'package:get/get.dart';
import '../../../data/config/app_config.dart';
import '../../../data/models/safety_incident_model.dart';

class SafetyCentreController extends GetxController {
  final incidentsList = <SafetyIncident>[].obs;
  final isSosTriggered = false.obs;
  final trustedContactShared = false.obs;

  @override
  void onInit() {
    super.onInit();
    incidentsList.assignAll(SafetyIncident.mockList());
  }

  void triggerSos() {
    isSosTriggered.value = true;
    AppConfig.showError(
      title: 'EMERGENCY SOS BROADCASTED',
      message: 'Live coordinates dispatched to Go Jatra Safety Ops & nearest response unit.',
    );
  }

  void callEmergencyPolice() {
    AppConfig.showInfo(title: 'Calling Emergency Services', message: 'Dialing 112...');
  }

  void callSafetyDesk() {
    AppConfig.showInfo(title: 'Calling Go Jatra Safety Response', message: 'Connecting to 24/7 Captain Safety Desk...');
  }

  void shareLiveLocationWithContact() {
    trustedContactShared.value = true;
    AppConfig.showSuccess(title: 'Location Shared', message: 'Live tracking link sent via SMS to Sunita Das (+91 98310 98765).',
    );
  }

  void submitIncidentReport({
    required IncidentType type,
    required String details,
    String? tripId,
  }) {
    final caseId = 'CASE-SAF-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final incident = SafetyIncident(
      caseId: caseId,
      type: type,
      details: details,
      tripId: tripId ?? 'TRIP-ACTIVE',
      reportedAt: DateTime.now(),
      status: 'Under Investigation',
    );
    incidentsList.insert(0, incident);
    AppConfig.showSuccess(title: 'Incident Reported', message: 'Case #$caseId recorded. Safety team will contact you within 15 minutes.',
    );
  }
}

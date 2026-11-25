enum IncidentType {
  unsafePickupDrop,
  passengerMisconduct,
  accidentCollision,
  vehicleBreakdown,
  paymentDispute,
  other,
}

extension IncidentTypeExt on IncidentType {
  String get title {
    switch (this) {
      case IncidentType.unsafePickupDrop:
        return 'Unsafe Pickup or Drop Area';
      case IncidentType.passengerMisconduct:
        return 'Passenger Misconduct';
      case IncidentType.accidentCollision:
        return 'Accident or Collision';
      case IncidentType.vehicleBreakdown:
        return 'Vehicle Breakdown';
      case IncidentType.paymentDispute:
        return 'Payment / Fare Dispute';
      case IncidentType.other:
        return 'Other Safety Issue';
    }
  }
}

class SafetyIncident {
  final String caseId;
  final IncidentType type;
  final String details;
  final String? tripId;
  final DateTime reportedAt;
  final String status; // 'Under Investigation', 'Resolved', 'Assigned'

  const SafetyIncident({
    required this.caseId,
    required this.type,
    required this.details,
    this.tripId,
    required this.reportedAt,
    this.status = 'Under Investigation',
  });

  static List<SafetyIncident> mockList() {
    return [
      SafetyIncident(
        caseId: 'CASE-SAF-4401',
        type: IncidentType.unsafePickupDrop,
        details: 'Narrow unlit alleyway near waterlogged canal. Requested safer drop point.',
        tripId: 'TRIP-9921',
        reportedAt: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'Under Investigation',
      ),
    ];
  }
}

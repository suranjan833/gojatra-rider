enum VehicleServiceType { bike, auto, cab, parcel }

extension VehicleServiceTypeExt on VehicleServiceType {
  String get label {
    switch (this) {
      case VehicleServiceType.bike:
        return 'Go Bike';
      case VehicleServiceType.auto:
        return 'Go Auto';
      case VehicleServiceType.cab:
        return 'Go Cab';
      case VehicleServiceType.parcel:
        return 'Go Parcel';
    }
  }

  String get iconName {
    switch (this) {
      case VehicleServiceType.bike:
        return 'motorbike';
      case VehicleServiceType.auto:
        return 'auto_rickshaw';
      case VehicleServiceType.cab:
        return 'car';
      case VehicleServiceType.parcel:
        return 'box';
    }
  }
}

class VehicleInfo {
  final String modelName;
  final String registrationNumber;
  final String color;
  final VehicleServiceType serviceType;

  const VehicleInfo({
    required this.modelName,
    required this.registrationNumber,
    required this.color,
    required this.serviceType,
  });
}

class EmergencyContact {
  final String name;
  final String relationship;
  final String phone;

  const EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phone,
  });
}

class CaptainProfile {
  final String id;
  final String name;
  final String phone;
  final String email;
  final double rating;
  final int totalTrips;
  final String tier;
  final VehicleInfo vehicle;
  final EmergencyContact emergencyContact;
  final String preferredNavigation; // 'Google Maps', 'Apple Maps', 'Waze'
  final String preferredLanguage; // 'English', 'Bengali', 'Hindi'

  const CaptainProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.rating,
    required this.totalTrips,
    required this.tier,
    required this.vehicle,
    required this.emergencyContact,
    this.preferredNavigation = 'Google Maps',
    this.preferredLanguage = 'English',
  });

  static CaptainProfile mock() {
    return const CaptainProfile(
      id: 'CPT-77291',
      name: 'SBS Rider ',
      phone: '+91 98301 11111',
      email: 'sbst@gojatra.com',
      rating: 4.92,
      totalTrips: 1248,
      tier: 'Diamond Captain Tier 1',
      vehicle: VehicleInfo(
        modelName: 'Bajaj Pulsar 150',
        registrationNumber: 'WB 02 AJ 4492',
        color: 'Forest Green',
        serviceType: VehicleServiceType.bike,
      ),
      emergencyContact: EmergencyContact(
        name: 'Mera emergency',
        relationship: 'Spouse',
        phone: '+91 98310 98765',
      ),
      preferredNavigation: 'Google Maps',
      preferredLanguage: 'English',
    );
  }
}

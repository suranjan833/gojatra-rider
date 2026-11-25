enum TripStatus { completed, cancelledByCaptain, cancelledByPassenger }

enum PaymentMode { cash, upi, onlineWallet }

extension PaymentModeExt on PaymentMode {
  String get label {
    switch (this) {
      case PaymentMode.cash:
        return 'Cash on Drop';
      case PaymentMode.upi:
        return 'UPI Transfer';
      case PaymentMode.onlineWallet:
        return 'Go Jatra Wallet';
    }
  }
}

class TripRecord {
  final String id;
  final String passengerName;
  final String serviceType;
  final String pickupAddress;
  final String dropAddress;
  final double tripDistanceKm;
  final int tripDurationMin;
  final double totalFare;
  final double captainPayout;
  final double platformFee;
  final double incentiveBonus;
  final double tipAmount;
  final PaymentMode paymentMode;
  final TripStatus status;
  final DateTime timestamp;
  final double passengerRating;

  const TripRecord({
    required this.id,
    required this.passengerName,
    required this.serviceType,
    required this.pickupAddress,
    required this.dropAddress,
    required this.tripDistanceKm,
    required this.tripDurationMin,
    required this.totalFare,
    required this.captainPayout,
    required this.platformFee,
    this.incentiveBonus = 0.0,
    this.tipAmount = 0.0,
    required this.paymentMode,
    required this.status,
    required this.timestamp,
    this.passengerRating = 5.0,
  });

  static List<TripRecord> mockList() {
    final now = DateTime.now();
    return [
      TripRecord(
        id: 'TRIP-9921',
        passengerName: 'Mera Passeneger ',
        serviceType: 'Go Bike',
        pickupAddress: 'Salt Lake Sector V, College More',
        dropAddress: 'Eco Space Business Park, New Town',
        tripDistanceKm: 6.8,
        tripDurationMin: 22,
        totalFare: 148.00,
        captainPayout: 126.00,
        platformFee: 22.00,
        incentiveBonus: 20.00,
        tipAmount: 10.00,
        paymentMode: PaymentMode.cash,
        status: TripStatus.completed,
        timestamp: now.subtract(const Duration(hours: 1, minutes: 15)),
        passengerRating: 5.0,
      ),
      TripRecord(
        id: 'TRIP-9920',
        passengerName: 'Rahul Banerjee',
        serviceType: 'Go Auto',
        pickupAddress: 'Karunamoyee Central Bus Terminus',
        dropAddress: 'City Centre 1, Salt Lake DC Block',
        tripDistanceKm: 4.2,
        tripDurationMin: 14,
        totalFare: 84.00,
        captainPayout: 71.50,
        platformFee: 12.50,
        paymentMode: PaymentMode.upi,
        status: TripStatus.completed,
        timestamp: now.subtract(const Duration(hours: 3, minutes: 40)),
        passengerRating: 4.8,
      ),
      TripRecord(
        id: 'TRIP-9919',
        passengerName: 'Debolina Roy',
        serviceType: 'Go Bike',
        pickupAddress: 'Ultadanga Railway Station Gate 2',
        dropAddress: 'Shyambazar Five Point Crossing',
        tripDistanceKm: 3.5,
        tripDurationMin: 11,
        totalFare: 62.00,
        captainPayout: 53.00,
        platformFee: 9.00,
        paymentMode: PaymentMode.onlineWallet,
        status: TripStatus.completed,
        timestamp: now.subtract(const Duration(hours: 5, minutes: 20)),
        passengerRating: 5.0,
      ),
      TripRecord(
        id: 'TRIP-9918',
        passengerName: 'Suman Chatterjee',
        serviceType: 'Go Parcel',
        pickupAddress: 'Sealdah Commercial Hub',
        dropAddress: 'Park Street Metro Station',
        tripDistanceKm: 4.0,
        tripDurationMin: 16,
        totalFare: 95.00,
        captainPayout: 81.00,
        platformFee: 14.00,
        incentiveBonus: 15.00,
        paymentMode: PaymentMode.cash,
        status: TripStatus.completed,
        timestamp: now.subtract(const Duration(days: 1, hours: 2)),
        passengerRating: 5.0,
      ),
      TripRecord(
        id: 'TRIP-9917',
        passengerName: 'Vikram Mehta',
        serviceType: 'Go Bike',
        pickupAddress: 'Howrah Railway Station Platform 1',
        dropAddress: 'BBD Bagh Heritage Walkway',
        tripDistanceKm: 3.1,
        tripDurationMin: 18,
        totalFare: 55.00,
        captainPayout: 0.00,
        platformFee: 0.00,
        paymentMode: PaymentMode.cash,
        status: TripStatus.cancelledByPassenger,
        timestamp: now.subtract(const Duration(days: 1, hours: 4)),
        passengerRating: 0.0,
      ),
    ];
  }
}

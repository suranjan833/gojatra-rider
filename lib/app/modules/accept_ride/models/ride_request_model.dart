class RideRequestModel {
  final String id;
  final String passengerName;
  final String passengerPhone;
  final double passengerRating;
  final int passengerTripsCount;
  final String? passengerAvatar;
  final String serviceType;
  final double fare;
  final double tripDistanceKm;
  final int tripDurationMinutes;
  final String pickupAddress;
  final String pickupLandmark;
  final double pickupDistanceKm;
  final int pickupEtaMinutes;
  final String dropoffAddress;
  final String dropoffLandmark;
  final String paymentMethod;
  final String otp;
  final bool isSurge;
  final double surgeMultiplier;
  final int timeoutSeconds;

  String get pickupOtp => otp;
  String get dropAddress => dropoffAddress;
  double get fareAmount => fare;

  const RideRequestModel({
    required this.id,
    required this.passengerName,
    required this.passengerPhone,
    required this.passengerRating,
    required this.passengerTripsCount,
    this.passengerAvatar,
    required this.serviceType,
    required this.fare,
    required this.tripDistanceKm,
    required this.tripDurationMinutes,
    required this.pickupAddress,
    required this.pickupLandmark,
    required this.pickupDistanceKm,
    required this.pickupEtaMinutes,
    required this.dropoffAddress,
    required this.dropoffLandmark,
    required this.paymentMethod,
    required this.otp,
    this.isSurge = false,
    this.surgeMultiplier = 1.0,
    this.timeoutSeconds = 20,
  });

  factory RideRequestModel.mockDefault() {
    return const RideRequestModel(
      id: 'GJ-84920',
      passengerName: 'mera passenger',
      passengerPhone: '+91 98301 22849',
      passengerRating: 4.88,
      passengerTripsCount: 142,
      serviceType: 'Go Comfort',
      fare: 245.50,
      tripDistanceKm: 7.8,
      tripDurationMinutes: 22,
      pickupAddress: 'Salt Lake Sector V, Webel More',
      pickupLandmark: 'Opposite RDB Cinema, Gate 2',
      pickupDistanceKm: 1.1,
      pickupEtaMinutes: 4,
      dropoffAddress: 'Park Street Metro Station',
      dropoffLandmark: 'Exit Gate 1, Jawaharlal Nehru Rd',
      paymentMethod: 'Cash on Drop',
      otp: '5824',
      isSurge: true,
      surgeMultiplier: 1.25,
      timeoutSeconds: 20,
    );
  }

  factory RideRequestModel.mockSecondary() {
    return const RideRequestModel(
      id: 'GJ-91823',
      passengerName: 'Rahul Banerjee',
      passengerPhone: '+91 98310 99412',
      passengerRating: 4.95,
      passengerTripsCount: 88,
      serviceType: 'Go Bike',
      fare: 110.00,
      tripDistanceKm: 4.2,
      tripDurationMinutes: 14,
      pickupAddress: 'Ultadanga Crossing, Auto Stand',
      pickupLandmark: 'Near VIP Road Underpass',
      pickupDistanceKm: 0.6,
      pickupEtaMinutes: 2,
      dropoffAddress: 'City Centre 1, Salt Lake',
      dropoffLandmark: 'Block DC, Entry Gate 3',
      paymentMethod: 'Go Wallet (Paid)',
      otp: '3190',
      isSurge: false,
      surgeMultiplier: 1.0,
      timeoutSeconds: 20,
    );
  }
}

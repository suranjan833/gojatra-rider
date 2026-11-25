class IncentiveTarget {
  final String id;
  final String title;
  final String description;
  final int completedRides;
  final int targetRides;
  final double bonusAmount;
  final DateTime expiresAt;
  final bool isClaimed;

  const IncentiveTarget({
    required this.id,
    required this.title,
    required this.description,
    required this.completedRides,
    required this.targetRides,
    required this.bonusAmount,
    required this.expiresAt,
    this.isClaimed = false,
  });

  double get progressPercent => (completedRides / targetRides).clamp(0.0, 1.0);
  bool get isAchieved => completedRides >= targetRides;

  static List<IncentiveTarget> mockList() {
    return [
      IncentiveTarget(
        id: 'inc_peak_rush',
        title: 'Morning Rush Hour Quest',
        description: 'Complete 8 trips between 08:00 AM – 12:00 PM in Salt Lake / New Town.',
        completedRides: 5,
        targetRides: 8,
        bonusAmount: 180.0,
        expiresAt: DateTime.now().add(const Duration(hours: 3)),
      ),
      IncentiveTarget(
        id: 'inc_weekend_hero',
        title: 'Weekend Champion Bonus',
        description: 'Complete 25 trips this weekend across any vehicle category.',
        completedRides: 19,
        targetRides: 25,
        bonusAmount: 650.0,
        expiresAt: DateTime.now().add(const Duration(days: 1, hours: 8)),
      ),
      IncentiveTarget(
        id: 'inc_rainy_day',
        title: 'Rain Surge Protection',
        description: 'Earn an extra ₹30 flat bonus on every completed ride during rain alerts.',
        completedRides: 3,
        targetRides: 3,
        bonusAmount: 90.0,
        expiresAt: DateTime.now().add(const Duration(hours: 6)),
        isClaimed: true,
      ),
    ];
  }
}

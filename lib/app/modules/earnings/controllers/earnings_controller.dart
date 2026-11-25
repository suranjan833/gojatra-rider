import 'package:get/get.dart';

import '../../../data/config/app_config.dart';
import '../../../data/models/incentive_model.dart';

enum EarningsTimeframe { today, thisWeek, thisMonth }

class EarningsController extends GetxController {
  final selectedTimeframe = EarningsTimeframe.today.obs;

  // Key metrics
  final grossEarnings = 1420.50.obs;
  final completedTrips = 9.obs;
  final onlineHours = 6.4.obs;
  final cashCollected = 540.00.obs;
  final digitalEarnings = 880.50.obs;
  final incentiveEarned = 180.00.obs;
  final platformFeeTotal = 210.00.obs;
  final netBalance = 1210.50.obs;

  // Bank & UPI payout info
  final upiId = 'sbs@okhdfcbank'.obs;
  final bankAccountMasked = 'HDFC Bank •••• 4892'.obs;
  final payoutStatus = 'Ready for Settlement'
      .obs; // 'Processing', 'Paid', 'Ready for Settlement'

  // Incentives
  final incentivesList = <IncentiveTarget>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadIncentives();
  }

  void loadIncentives() {
    incentivesList.assignAll(IncentiveTarget.mockList());
  }

  void setTimeframe(EarningsTimeframe timeframe) {
    selectedTimeframe.value = timeframe;
    if (timeframe == EarningsTimeframe.today) {
      grossEarnings.value = 1420.50;
      completedTrips.value = 9;
      onlineHours.value = 6.4;
      netBalance.value = 1210.50;
    } else if (timeframe == EarningsTimeframe.thisWeek) {
      grossEarnings.value = 9840.00;
      completedTrips.value = 68;
      onlineHours.value = 41.5;
      netBalance.value = 8420.00;
    } else {
      grossEarnings.value = 38450.00;
      completedTrips.value = 282;
      onlineHours.value = 176.0;
      netBalance.value = 33100.00;
    }
  }

  void requestInstantPayout() {
    if (netBalance.value <= 0) {
      AppConfig.showWarning(
        title: 'No Balance',
        message: 'Available payout balance is ₹0.',
      );
      return;
    }
    payoutStatus.value = 'Processing';
    AppConfig.showSuccess(
      title: 'Payout Initiated',
      message:
          '₹${netBalance.value.toStringAsFixed(2)} transfer initiated to $bankAccountMasked.',
    );
  }
}

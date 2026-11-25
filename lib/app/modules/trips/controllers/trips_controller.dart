import 'package:get/get.dart';
import '../../../data/models/trip_record_model.dart';

enum TripsFilter {
  all,
  completed,
  cancelled,
}

class TripsController extends GetxController {
  final tripsList = <TripRecord>[].obs;
  final selectedFilter = TripsFilter.all.obs;
  final selectedTrip = Rxn<TripRecord>();

  // Quality metrics
  final captainRating = 4.92.obs;
  final totalTrips = 1248.obs;
  final acceptanceRate = 96.4.obs;
  final cancellationRate = 1.8.obs;
  final onTimePickupRate = 98.2.obs;

  @override
  void onInit() {
    super.onInit();
    loadTrips();
  }

  void loadTrips() {
    tripsList.assignAll(TripRecord.mockList());
  }

  void setFilter(TripsFilter filter) {
    selectedFilter.value = filter;
  }

  List<TripRecord> get filteredTrips {
    if (selectedFilter.value == TripsFilter.completed) {
      return tripsList.where((t) => t.status == TripStatus.completed).toList();
    } else if (selectedFilter.value == TripsFilter.cancelled) {
      return tripsList.where((t) => t.status != TripStatus.completed).toList();
    }
    return tripsList;
  }

  void selectTrip(TripRecord trip) {
    selectedTrip.value = trip;
  }
}

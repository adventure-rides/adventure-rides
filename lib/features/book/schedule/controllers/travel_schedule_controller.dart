import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/trip_details_repository.dart'; // Adjust the import as necessary

class TravelScheduleController {
  final TextEditingController pickupLocationController = TextEditingController();
  final TextEditingController pickupDateController = TextEditingController();
  final TextEditingController pickupTimeController = TextEditingController();
  final TextEditingController dropoffLocationController = TextEditingController();
  final TextEditingController dropoffDateController = TextEditingController();
  final TextEditingController dropoffTimeController = TextEditingController();

  // State variable to track if the trip is a round trip
  ValueNotifier<bool> isRoundTrip = ValueNotifier<bool>(false);
  final TravelRepository travelRepository = TravelRepository();

  TravelScheduleController() {
    loadSavedSchedule(); // Load saved schedule when the controller is created
  }

  void clearFields() {
    pickupLocationController.clear();
    pickupDateController.clear();
    pickupTimeController.clear();
    dropoffLocationController.clear();
    dropoffDateController.clear();
    dropoffTimeController.clear();
    isRoundTrip.value = false; // Reset round trip state
  }

  Map<String, dynamic> getTravelDetails() {
    return {
      'pickupLocation': pickupLocationController.text,
      'pickupDate': pickupDateController.text,
      'pickupTime': pickupTimeController.text,
      'dropoffLocation': dropoffLocationController.text,
      'dropoffDate': dropoffDateController.text,
      'dropoffTime': dropoffTimeController.text,
      'isRoundTrip': isRoundTrip.value, // Include round trip status
    };
  }

  bool validateFields() {
    // Validate all required fields
    return pickupLocationController.text.isNotEmpty &&
        pickupDateController.text.isNotEmpty &&
        pickupTimeController.text.isNotEmpty &&
        dropoffLocationController.text.isNotEmpty &&
        dropoffDateController.text.isNotEmpty &&
        dropoffTimeController.text.isNotEmpty;
  }

  Future<void> loadSavedSchedule() async {
    try {
      final savedDetails = await travelRepository.getLastTravelDetails();
      if (savedDetails != null) {
        pickupLocationController.text = savedDetails.pickupLocation;
        pickupDateController.text = savedDetails.pickupDate;
        pickupTimeController.text = savedDetails.pickupTime;
        dropoffLocationController.text = savedDetails.dropoffLocation;
        dropoffDateController.text = savedDetails.dropoffDate;
        dropoffTimeController.text = savedDetails.dropoffTime;
        isRoundTrip.value = savedDetails.isRoundTrip;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading saved schedule: $e');
      }
    }
  }
}
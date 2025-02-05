import 'package:adventure_rides/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';
import '../controllers/travel_schedule_controller.dart';

class ScheduleTravelDialog extends StatelessWidget {
  final TravelScheduleController controller;
  final Function(Map<String, dynamic>) onSchedule;
  final ValueNotifier<bool> isRoundTripNotifier;

  const ScheduleTravelDialog({super.key,
    required this.controller,
    required this.onSchedule,
    required this.isRoundTripNotifier,
  });

  void _selectPickupDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.pickupDateController.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  void _selectPickupTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.pickupTimeController.text = "${picked.hour}:${picked.minute.toString().padLeft(2, '0')}";
    }
  }

  void _selectDropoffDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.dropoffDateController.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  void _selectDropoffTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.dropoffTimeController.text = "${picked.hour}:${picked.minute.toString().padLeft(2, '0')}";
    }
  }

  String? _validateFields() {
    if (controller.pickupLocationController.text.isEmpty) {
      return "Pickup location is required.";
    }
    if (controller.pickupDateController.text.isEmpty) {
      return "Pickup date is required.";
    }
    if (controller.pickupTimeController.text.isEmpty) {
      return "Pickup time is required.";
    }
    if (controller.dropoffLocationController.text.isEmpty) {
      return "Dropoff location is required.";
    }
    if (controller.dropoffDateController.text.isEmpty) {
      return "Dropoff date is required.";
    }
    if (controller.dropoffTimeController.text.isEmpty) {
      return "Dropoff time is required.";
    }
    return null; // No validation errors
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400, // dialog width
        constraints: BoxConstraints(
          maxHeight: 600, // maximum height for the dialog
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Schedule Travel", style: Theme.of(context).textTheme.headlineSmall),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: controller.pickupLocationController,
                      decoration: InputDecoration(labelText: "Pickup Location"),
                    ),
                    SizedBox(height: SSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectPickupDate(context),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: controller.pickupDateController,
                                decoration: InputDecoration(labelText: "Pickup Date"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: SSizes.spaceBtwItems),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectPickupTime(context),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: controller.pickupTimeController,
                                decoration: InputDecoration(labelText: "Pickup Time"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SSizes.spaceBtwInputFields),
                    TextField(
                      controller: controller.dropoffLocationController,
                      decoration: InputDecoration(labelText: "Dropoff Location"),
                    ),
                    SizedBox(height: SSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDropoffDate(context),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: controller.dropoffDateController,
                                decoration: InputDecoration(labelText: "Dropoff Date"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: SSizes.spaceBtwItems),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDropoffTime(context),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: controller.dropoffTimeController,
                                decoration: InputDecoration(labelText: "Dropoff Time"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: isRoundTripNotifier,
                      builder: (context, isRoundTrip, child) {
                        return Row(
                          children: [
                            Checkbox(
                              value: isRoundTrip,
                              onChanged: (bool? value) {
                                isRoundTripNotifier.value = value ?? false;
                              },
                            ),
                            Text("Round Trip"),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            OverflowBar(
              children: [
                TextButton(
                  onPressed: () {
                    controller.clearFields();
                    Navigator.of(context).pop();
                    },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    String? validationError = _validateFields();
                    if (validationError != null) {
                      // Show validation error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(validationError)),
                      );
                      return;
                    }
                    final travelDetails = controller.getTravelDetails();
                    travelDetails['isRoundTrip'] = isRoundTripNotifier.value; // Include round trip status
                    onSchedule(travelDetails); // Call the onSchedule callback
                    controller.clearFields();
                    Navigator.of(context).pop();
                  },
                  child: Text("Schedule"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
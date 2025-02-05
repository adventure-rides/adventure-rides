import 'package:adventure_rides/features/personalization/controllers/schedule_controller.dart';
import 'package:adventure_rides/utils/constraints/sizes.dart';
import 'package:adventure_rides/utils/validators/validation.dart';
import 'package:flutter/material.dart';

class AddNewScheduleScreen extends StatelessWidget {
  final ScheduleController controller;
  final Function(Map<String, dynamic>) onSchedule;
  final ValueNotifier<bool> isRoundTripNotifier;

  const AddNewScheduleScreen({
    super.key,
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
      controller.pickupDate.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  void _selectPickupTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.pickupTime.text = formatTimeOfDay(picked);
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
      controller.dropoffDate.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  void _selectDropoffTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.dropoffTime.text = formatTimeOfDay(picked);
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hours = time.hour;
    final minutes = time.minute.toString().padLeft(2, '0');
    final period = hours >= 12 ? 'PM' : 'AM';
    final formattedHours = hours % 12 == 0 ? 12 : hours % 12; // Convert to 12-hour format
    return '$formattedHours:$minutes $period';
  }

  String? _validateFields() {
    if (controller.pickupLocation.text.isEmpty) {
      return "Pickup location is required.";
    }
    if (controller.pickupDate.text.isEmpty) {
      return "Pickup date is required.";
    }
    if (controller.pickupTime.text.isEmpty) {
      return "Pickup time is required.";
    }
    if (controller.dropoffLocation.text.isEmpty) {
      return "Dropoff location is required.";
    }
    if (controller.dropoffDate.text.isEmpty) {
      return "Dropoff date is required.";
    }
    if (controller.dropoffTime.text.isEmpty) {
      return "Dropoff time is required.";
    }
    return null; // No validation errors
  }

  @override
  Widget build(BuildContext context) {
    final controller = ScheduleController.instance;
    return Material(
      elevation: 8.0,  // Apply a shadow effect with elevation
      borderRadius: BorderRadius.circular(12.0),  // Optional: rounded corners
      child: Form(
        key: controller.scheduleFormKey,
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
                    TextFormField(
                      controller: controller.pickupLocation,
                      validator: (value) => SValidator.validateEmptyText('Pickup Location', value),
                      decoration: InputDecoration(labelText: "Pickup Location"),
                    ),
                    SizedBox(height: SSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectPickupDate(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                validator: (value) => SValidator.validateEmptyText('Pickup Date', value),
                                controller: controller.pickupDate,
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
                              child: TextFormField(
                                controller: controller.pickupTime,
                                validator: (value) => SValidator.validateEmptyText('Pickup Time', value),
                                decoration: InputDecoration(labelText: "Pickup Time"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.dropoffLocation,
                      validator: (value) => SValidator.validateEmptyText('Dropoff Location', value),
                      decoration: InputDecoration(labelText: "Dropoff Location"),
                    ),
                    SizedBox(height: SSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDropoffDate(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: controller.dropoffDate,
                                validator: (value) => SValidator.validateEmptyText('Dropoff Date', value),
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
                              child: TextFormField(
                                controller: controller.dropoffTime,
                                validator: (value) => SValidator.validateEmptyText('Dropoff Time', value),
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
            Row( //OverflowButton
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    controller.resetFormFields();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    String? validationError = _validateFields();
                    if (validationError != null) {
                      // Show validation error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(validationError)),
                      );
                      return;
                    }
                    final scheduleDetails = controller.getScheduleDetails();
                    scheduleDetails['isRoundTrip'] = isRoundTripNotifier.value; // Include round trip status

                    // Call Firebase save function
                    await controller.addNewSchedule();
                    SnackBar(content: Text("Schedule saved successfully!"));

                    onSchedule(scheduleDetails); // Call the onSchedule callback
                    controller.resetFormFields();
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
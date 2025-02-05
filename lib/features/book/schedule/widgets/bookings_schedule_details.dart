import 'package:adventure_rides/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';
import '../controllers/travel_schedule_controller.dart';

class ScheduleDetails extends StatelessWidget {
  final TravelScheduleController controller;
  final Function(Map<String, dynamic>) onSchedule;
  final ValueNotifier<bool> isRoundTripNotifier;

  const ScheduleDetails({
    super.key,
    required this.controller,
    required this.onSchedule,
    required this.isRoundTripNotifier,
  });

  // Date & Time Picker Methods
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = formatTimeOfDay(picked);
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hours = time.hour;
    final minutes = time.minute.toString().padLeft(2, '0');
    final period = hours >= 12 ? 'PM' : 'AM';
    final formattedHours = hours % 12 == 0 ? 12 : hours % 12;
    return '$formattedHours:$minutes $period';
  }

  String? _validateFields() {
    if (controller.pickupLocationController.text.isEmpty) return "Pickup location is required.";
    if (controller.pickupDateController.text.isEmpty) return "Pickup date is required.";
    if (controller.pickupTimeController.text.isEmpty) return "Pickup time is required.";
    if (controller.dropoffLocationController.text.isEmpty) return "Dropoff location is required.";
    if (controller.dropoffDateController.text.isEmpty) return "Dropoff date is required.";
    if (controller.dropoffTimeController.text.isEmpty) return "Dropoff time is required.";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(12.0),
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
                  _buildTextField(controller.pickupLocationController, "Pickup Location"),
                  SizedBox(height: SSizes.spaceBtwInputFields),
                  _buildDateAndTimeFields(context, controller.pickupDateController, controller.pickupTimeController, "Pickup"),
                  SizedBox(height: SSizes.spaceBtwInputFields),
                  _buildTextField(controller.dropoffLocationController, "Dropoff Location"),
                  SizedBox(height: SSizes.spaceBtwInputFields),
                  _buildDateAndTimeFields(context, controller.dropoffDateController, controller.dropoffTimeController, "Dropoff"),
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
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _buildDateAndTimeFields(BuildContext context, TextEditingController dateController, TextEditingController timeController, String label) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDate(context, dateController),
            child: AbsorbPointer(
              child: _buildTextField(dateController, "$label Date"),
            ),
          ),
        ),
        SizedBox(width: SSizes.spaceBtwItems),
        Expanded(
          child: GestureDetector(
            onTap: () => _selectTime(context, timeController),
            child: AbsorbPointer(
              child: _buildTextField(timeController, "$label Time"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            controller.clearFields();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            String? validationError = _validateFields();
            if (validationError != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(validationError)));
              return;
            }
            final travelDetails = controller.getTravelDetails();
            travelDetails['isRoundTrip'] = isRoundTripNotifier.value;
            onSchedule(travelDetails);
            controller.clearFields();
          },
          child: Text("Schedule"),
        ),
      ],
    );
  }
}
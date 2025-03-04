import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/car_model.dart';
import 'availability_calendar_desktop.dart';
import '../../../../../../utils/popups/loaders.dart';

class AvailabilityCalendarDialog extends StatelessWidget {
  const AvailabilityCalendarDialog({super.key, required this.car});
  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          _showAvailabilityDialog(context);
        },
        child: const Text(
          "Show Availability Calendar",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showAvailabilityDialog(BuildContext context) {
    DateTime? selectedDate; // Local variable for storing selection

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Check Availability Status"),
          content: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: AvailabilityCalendarDesktop(
              bookedDates: car.bookedDates,
              onDateSelected: (DateTime date) {
                selectedDate = date;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: () {
                if (selectedDate == null) {
                  SLoaders.customToast(message: "❌ Please select a date first.");
                } else {
                  SLoaders.customToast(
                      message: "✅ Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}");
                  Navigator.of(context).pop(); // Close the dialog after confirmation
                }
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
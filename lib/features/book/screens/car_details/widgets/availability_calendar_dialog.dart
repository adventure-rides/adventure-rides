import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/car_model.dart';
import 'availability_calendar_desktop.dart';

class AvailabilityCalendarDialog extends StatelessWidget {
  const AvailabilityCalendarDialog({
    super.key,
    required this.car,
  });

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
          // Show the availability calendar in a dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Check Availability Status"),
                content: SizedBox(
                  width: double.maxFinite, // Make dialog width flexible
                  height: double.maxFinite, // Make dialog width flexible
                  child: AvailabilityCalendarDesktop(bookedDates: car.bookedDates, onDateSelected: (DateTime ) {  },),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text("Close"),
                  ),
                ],
              );
            },
          );
        },
        child: const Text(
          "Show Availability Calendar",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
import 'package:adventure_rides/features/book/schedule/repository/trip_details_repository.dart';
import 'package:adventure_rides/features/book/schedule/widgets/schedule_travel_dialog.dart';
import 'package:flutter/material.dart';
import 'controllers/travel_schedule_controller.dart';

class ScheduleButton extends StatelessWidget {
  final TravelScheduleController controller;
  final ValueNotifier<bool> isRoundTripNotifier = ValueNotifier<bool>(false);

  ScheduleButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ScheduleTravelDialog(
            controller: controller,
            onSchedule: (travelDetails) {
              // Handle the scheduled travel details here
              TravelRepository().saveTravelDetails(travelDetails);
            },
            isRoundTripNotifier: isRoundTripNotifier,
          ),
        );
      },
      child: Text("Schedule Travel"),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../utils/constraints/sizes.dart';

class AvailabilityCalendar extends StatefulWidget {
  final List<DateTime> bookedDates;

  const AvailabilityCalendar({super.key, required this.bookedDates});

  @override
  _AvailabilityCalendarState createState() => _AvailabilityCalendarState();
}

class _AvailabilityCalendarState extends State<AvailabilityCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Check Availability",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime.now(), // Start from today
          lastDay: DateTime.utc(2030, 12, 31),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          enabledDayPredicate: (day) {
            return day.isAfter(DateTime.now().subtract(const Duration(days: 1))); // Disable past dates
          },
          calendarFormat: CalendarFormat.month,
          availableGestures: AvailableGestures.all,
          eventLoader: (day) {
            return widget.bookedDates.contains(day) ? ['Booked'] : [];
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(height: SSizes.spaceBtwItems/2),
        const Text(
          "Red dots indicate booked dates",
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
      ],
    );
  }
}

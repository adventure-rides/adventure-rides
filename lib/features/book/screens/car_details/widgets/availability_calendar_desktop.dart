import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../utils/constraints/sizes.dart';

class AvailabilityCalendarDesktop extends StatefulWidget {
  final List<DateTime> bookedDates;
  final Function(DateTime) onDateSelected;

  const AvailabilityCalendarDesktop({super.key, required this.bookedDates, required this.onDateSelected});

  @override
  _AvailabilityCalendarDesktopState createState() => _AvailabilityCalendarDesktopState();
}

class _AvailabilityCalendarDesktopState extends State<AvailabilityCalendarDesktop> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030, 12, 31),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            widget.onDateSelected(selectedDay); // Pass selected date back to parent widget
          },
          enabledDayPredicate: (day) {
            return day.isAfter(DateTime.now().subtract(const Duration(days: 1)));
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
        SizedBox(height: SSizes.spaceBtwItems/4),
        const Text(
          "Red dots indicate booked dates",
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
      ],
    );
  }
}

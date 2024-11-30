// ignore_for_file: must_be_immutable

import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import 'package:adventure_rides/features/book/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingScreenMobile extends StatelessWidget {
  final String title;
  final Query? query;
  final Future<List<BookingModel>>? futureMethod;

  BookingScreenMobile({
    super.key,
    required this.title,
    required this.query,
    this.futureMethod,
  });

  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> additionalGuests = [];

  // Form fields
  String pickupLocation = '';
  String destination = '';
  DateTime? startDate;
  DateTime? endDate;
  int numberOfGuests = 1;

  // Controllers for Start and End Date Fields
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  // Fields for additional guests
  String tempFullName = '';
  String tempEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FixedScreenAppbar(),
      body: Row(
        children: [Text('data')],
      ),
    );
  }
}

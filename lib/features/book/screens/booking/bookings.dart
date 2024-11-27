import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  // Booking fields
  String pickupLocation = '';
  String destination = '';
  DateTime? startDate;
  DateTime? endDate;
  int numberOfGuests = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pickup Location

                TextFormField(
                  decoration: InputDecoration(labelText: 'Pickup Location'),
                  onSaved: (value) => pickupLocation = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a pickup location' : null,
                ),
                SizedBox(height: 16),

                // Destination
                TextFormField(
                  decoration: InputDecoration(labelText: 'Destination'),
                  onSaved: (value) => destination = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a destination' : null,
                ),
                SizedBox(height: 16),

                // Start Date
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  controller: TextEditingController(
                    text: startDate != null
                        ? DateFormat('yyyy-MM-dd').format(startDate!)
                        : '',
                  ),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        startDate = selectedDate;
                      });
                    }
                  },
                  validator: (value) =>
                      startDate == null ? 'Please select a start date' : null,
                ),
                SizedBox(height: 16),

                // End Date
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  controller: TextEditingController(
                    text: endDate != null
                        ? DateFormat('yyyy-MM-dd').format(endDate!)
                        : '',
                  ),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        endDate = selectedDate;
                      });
                    }
                  },
                  validator: (value) {
                    if (endDate == null) {
                      return 'Please select an end date';
                    } else if (startDate != null &&
                        endDate!.isBefore(startDate!)) {
                      return 'End date must be after the start date';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Number of Guests
                TextFormField(
                  decoration: InputDecoration(labelText: 'Number of Guests'),
                  keyboardType: TextInputType.number,
                  initialValue: numberOfGuests.toString(),
                  onSaved: (value) =>
                      numberOfGuests = int.tryParse(value ?? '1') ?? 1,
                  validator: (value) {
                    int? guests = int.tryParse(value ?? '');
                    if (guests == null || guests <= 0) {
                      return 'Please enter a valid number of guests';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: _submitForm,
                  child: Text('Submit Booking'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create the booking object
      final booking = {
        'pickupLocation': pickupLocation,
        'destination': destination,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'numberOfGuests': numberOfGuests,
      };

      // Save to Firestore
      FirebaseFirestore.instance.collection('bookings').add(booking);

      // Notify user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking Submitted!')),
      );

      // Reset the form
      _formKey.currentState!.reset();
      setState(() {
        startDate = null;
        endDate = null;
        numberOfGuests = 1;
      });
    }
  }
}

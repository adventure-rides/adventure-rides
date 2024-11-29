import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import 'package:adventure_rides/features/book/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:adventure_rides/features/book/screens/cart/widgets/cart_items.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingScreen extends StatefulWidget {
  final String? userId;
  final User? user = FirebaseAuth.instance.currentUser;

  BookingScreen({super.key, this.userId});

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<Map<String, String>> fetchUserDetails(String userId) async {
    final userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userSnapshot.exists) {
      final data = userSnapshot.data()!;
      return {
        'name': data['name'] as String,
        'email': data['email'] as String,
      };
    } else {
      throw Exception('User not found');
    }
  }

  // Booking fields
  String pickupLocation = '';
  String destination = '';
  DateTime? startDate;
  DateTime? endDate;
  int numberOfGuests = 1;
  String? userName;
  String? userEmail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Check if userId is null before calling the function
    if (widget.userId != null) {
      fetchUserDetails(
          widget.userId!); // Force unwrapping, assuming userId is non-null here
    } else {
      print("User ID is null");
      setState(() {
        isLoading = false;
      });
    }
  }

  void saveBooking() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final DateTime safeStartDate = startDate ?? DateTime.now();
      final DateTime safeEndDate =
          endDate ?? DateTime.now().add(Duration(days: 1));

      final booking = BookingModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: widget.userId ?? "guest",
        startDate: safeStartDate,
        endDate: safeEndDate,
        pickupLocation: pickupLocation,
        destination: destination,
        numberOfGuests: numberOfGuests,
      );
      FirebaseFirestore.instance
          .collection('bookings')
          .doc(booking.id)
          .set(booking.toJson());
      print('Booking saved');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FixedScreenAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1: User Name and Email
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Name: $userName\nEmail: $userEmail',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Row 2: Pickup Location and Destination
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Pickup Location',
                        ),
                        onSaved: (value) => pickupLocation = value ?? '',
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a pickup location'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Destination',
                        ),
                        onSaved: (value) => destination = value ?? '',
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a destination'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Row 3: Start Date and End Date
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
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
                        validator: (value) => startDate == null
                            ? 'Please select a start date'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
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
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Number of Guests
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Number of Guests'),
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
                const SizedBox(height: 16),

                //Gari lililochaguliwa
                const SingleChildScrollView(
                  child: Column(
                    children: const [
                      /// Items in bookings

                      SCartItems(),

                      /// Additional Widgets if needed
                      SizedBox(height: 30), // Example spacing or additional UI
                    ],
                  ),
                ),

                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => _submitForm(),
                  child: const Text('Submit Booking'),
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
        'userId': '',
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:adventure_rides/features/book/screens/cart/widgets/cart_items.dart';
import '../../../../data/repositories/authentication/general_auth_repository.dart';
import '../../../authentication/screens/Login/login.dart';
import '../checkout/checkout.dart';
import 'package:get/get.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> checkAuthenticationAndRedirect() async {
    if (!Get.isRegistered<GeneralAuthRepository>()) {
      Get.put(GeneralAuthRepository());
    }

    final authRepo = GeneralAuthRepository.instance;
    //final user = authRepo._auth.currentUser;

    final user = authRepo.currentUser;

    // Check if the user is authenticated
    if (user == null || !user.emailVerified) {
      // If not authenticated, prompt login or registration
      await Get.to(() => const LoginScreen());
    } else {
      // Proceed to the checkout if authenticated
      Get.to(() => const CheckoutScreen());
    }
  }

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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    //First action
                    _submitForm();
                    //Second action
                    checkAuthenticationAndRedirect();
                  },
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
        'userId': '',
      };

      // Save to Firestore
      FirebaseFirestore.instance.collection('bookings').add(booking);
      //user authentication
      checkAuthenticationAndRedirect;
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

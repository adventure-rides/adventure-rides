import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../cart/cart.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class BookingScreenDesktop extends StatefulWidget {
  final String? userId;

  BookingScreenDesktop({Key? key, this.userId}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreenDesktop> {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Center(
                      child: Text(
                        'MANAGE BOOKING',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Pickup Location and Destination
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
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
                              border: UnderlineInputBorder(),
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

                    // Start Date and End Date
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: startDateController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Start Date',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
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
                                  startDateController.text =
                                      "${startDate!.year}-${startDate!.month}-${startDate!.day}";
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
                            controller: endDateController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'End Date',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: startDate ?? DateTime.now(),
                                firstDate: startDate ?? DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  endDate = selectedDate;
                                  endDateController.text =
                                      "${endDate!.year}-${endDate!.month}-${endDate!.day}";
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

                    // Full-Name and Email Fields
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Full Name'),
                            onChanged: (value) => tempFullName = value,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Email'),
                            onChanged: (value) => tempEmail = value,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                          ),
                          onPressed: () {
                            if (tempFullName.isNotEmpty &&
                                tempEmail.isNotEmpty) {
                              setState(() {
                                additionalGuests.add({
                                  'fullName': tempFullName,
                                  'email': tempEmail,
                                });
                                tempFullName = '';
                                tempEmail = '';
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // List of Guests
                    Text(
                      'List of Guests',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: additionalGuests.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(additionalGuests[index]['fullName']!),
                            subtitle: Text(additionalGuests[index]['email']!),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  additionalGuests.removeAt(index);
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Submit Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // Save to Firestore
                          FirebaseFirestore.instance
                              .collection('bookings')
                              .add({
                            'pickupLocation': pickupLocation,
                            'destination': destination,
                            'startDate': startDate?.toIso8601String(),
                            'endDate': endDate?.toIso8601String(),
                            'numberOfGuests': numberOfGuests,
                            'additionalGuests': additionalGuests,
                          });

                          // Notify user
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Reservation Submitted!')),
                          );

                          // Reset the form
                          _formKey.currentState!.reset();
                          startDateController.clear();
                          endDateController.clear();
                          setState(() {
                            startDate = null;
                            endDate = null;
                            numberOfGuests = 1;
                            additionalGuests.clear();
                          });
                          // Navigate to the cart screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()),
                          );
                        }
                      },
                      child: Text('Confirm Reservation'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../screens/cart/cart.dart';
import '../reservation_header/reservation_header.dart';
import '../reservation_works/reservation_works.dart';

class ReservationDesktop extends StatelessWidget {
  final String? userId;

  ReservationDesktop({super.key, this.userId});

  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> additionalGuests = [];
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  String pickupLocation = '';
  String destination = '';
  DateTime? startDate;
  DateTime? endDate;

  String tempFullName = '';
  String tempEmail = '';

  @override
  Widget build(BuildContext context) {
    final bool dark = SHelperFunctions().isDarkMode(context); // Detect theme
    return Scaffold(
      appBar: FixedScreenAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                HeaderWidget(
                  title: "Welcome to Adventure Rides",
                  subtitle: "Reserve for some booking",
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 700),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: dark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Row(
                          children: [
                            Expanded(
                              child: _buildDateField(
                                context,
                                controller: startDateController,
                                label: 'Start Date',
                                onDateSelected: (selectedDate) {
                                  startDate = selectedDate;
                                  startDateController.text =
                                  "${startDate!.year}-${startDate!.month}-${startDate!.day}";
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDateField(
                                context,
                                controller: endDateController,
                                label: 'End Date',
                                onDateSelected: (selectedDate) {
                                  endDate = selectedDate;
                                  endDateController.text =
                                  "${endDate!.year}-${endDate!.month}-${endDate!.day}";
                                },
                                startDate: startDate,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Full Name',
                                ),
                                onChanged: (value) => tempFullName = value,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                ),
                                onChanged: (value) => tempEmail = value,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildGuestList(context),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 30,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                            ),
                            onPressed: () {
                              _submitReservation(context);
                            },
                            child: Text(
                              'Confirm Reservation',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReservationHowItWorksRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, {required TextEditingController controller, required String label, required Function(DateTime) onDateSelected, DateTime? startDate}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: startDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (selectedDate != null) {
          onDateSelected(selectedDate);
        }
      },
      validator: (value) => controller.text.isEmpty
          ? 'Please select a $label'
          : null,
    );
  }

  Widget _buildGuestList(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Guest List:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            if (tempFullName.isNotEmpty && tempEmail.isNotEmpty) {
              additionalGuests.add({
                'fullName': tempFullName,
                'email': tempEmail,
              });
              tempFullName = ''; // Clear input after adding
              tempEmail = '';
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please enter both name and email.'),
                ),
              );
            }
          },
        ),
        const SizedBox(height: 8),
        if (additionalGuests.isNotEmpty)
          ListView.builder(
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
                    additionalGuests.removeAt(index);
                  },
                ),
              );
            },
          )
        else
          Text(
            'No guests added yet.',
            style: TextStyle(color: Colors.grey),
          ),
      ],
    );
  }

  void _submitReservation(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      FirebaseFirestore.instance.collection('bookings').add({
        'pickupLocation': pickupLocation,
        'destination': destination,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'additionalGuests': additionalGuests,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reservation Submitted!')),
      );

      _formKey.currentState!.reset();
      startDateController.clear();
      endDateController.clear();
      additionalGuests.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartScreen()),
      );
    }
  }
}
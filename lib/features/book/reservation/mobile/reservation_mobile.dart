import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../screens/cart/cart.dart';
import '../reservation_header/reservation_header.dart';
import '../reservation_works/reservation_works.dart';

class ReservationMobile extends StatelessWidget {
  final String? userId;

  const ReservationMobile({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    final bool dark = SHelperFunctions().isDarkMode(context); // Detect theme
    final formKey = GlobalKey<FormState>();
    final List<Map<String, String>> additionalGuests = [];
    String pickupLocation = '';
    String destination = '';
    DateTime? startDate;
    DateTime? endDate;

    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();

    String tempFullName = '';
    String tempEmail = '';

    return Scaffold(
      appBar: FixedScreenAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            Column(
              children: [
                HeaderWidget(
                  title: "Welcome to Adventure Rides",
                  subtitle: "Reserve for some booking",
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Form Section with BoxDecoration
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
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pickup Location
                        _buildTextFormField(
                          label: 'Pickup Location',
                          onSaved: (value) => pickupLocation = value ?? '',
                          validator: (value) => value!.isEmpty
                              ? 'Please enter a pickup location'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Destination
                        _buildTextFormField(
                          label: 'Destination',
                          onSaved: (value) => destination = value ?? '',
                          validator: (value) => value!.isEmpty
                              ? 'Please enter a destination'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Start Date
                        _buildDateFormField(
                          context,
                          controller: startDateController,
                          label: 'Start Date',
                          onDateSelected: (selectedDate) {
                            startDate = selectedDate;
                            startDateController.text =
                            "${startDate!.year}-${startDate!.month}-${startDate!.day}";
                          },
                        ),
                        const SizedBox(height: 16),

                        // End Date
                        _buildDateFormField(
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
                        const SizedBox(height: 16),

                        // Guest Information
                        _buildTextFormField(
                          label: 'Full Name',
                          onChanged: (value) => tempFullName = value,
                        ),
                        const SizedBox(height: 16),

                        _buildTextFormField(
                          label: 'Email',
                          onChanged: (value) => tempEmail = value,
                        ),
                        const SizedBox(height: 16),

                        // List of Guests
                        _buildGuestList(context, additionalGuests, tempFullName, tempEmail),
                        const SizedBox(height: 16),

                        // Confirm Button
                        _buildConfirmButton(
                          context,
                          formKey,
                          pickupLocation,
                          destination,
                          startDate,
                          endDate,
                          additionalGuests,
                          startDateController,
                          endDateController,
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

  Widget _buildTextFormField({
    required String label,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildDateFormField(
      BuildContext context, {
        required TextEditingController controller,
        required String label,
        required void Function(DateTime) onDateSelected,
        DateTime? startDate,
      }) {
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
          initialDate: DateTime.now(),
          firstDate: startDate ?? DateTime.now(),
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

  Widget _buildGuestList(BuildContext context, List<Map<String, String>> additionalGuests, String tempFullName, String tempEmail) {
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
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please enter both name and email.'),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildConfirmButton(
      BuildContext context,
      GlobalKey<FormState> formKey,
      String pickupLocation,
      String destination,
      DateTime? startDate,
      DateTime? endDate,
      List<Map<String, String>> additionalGuests,
      TextEditingController startDateController,
      TextEditingController endDateController,
      ) {
    return Center(
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
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();

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

            formKey.currentState!.reset();
            startDateController.clear();
            endDateController.clear();
            additionalGuests.clear();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          }
        },
        child: Text(
          'Confirm Reservation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
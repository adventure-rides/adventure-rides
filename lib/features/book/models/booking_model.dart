import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String id; // Unique identifier for the booking
  final DateTime startDate; // Start date of the booking
  final DateTime endDate; // End date of the booking
  final String pickupLocation; // Pickup location for the booking
  final String destination; // Destination for the booking
  final int numberOfGuests; // Number of guests for the booking

  BookingModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.pickupLocation,
    required this.destination,
    required this.numberOfGuests,
  });

  // Convert BookingModel to JSON for saving to Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'pickupLocation': pickupLocation,
      'destination': destination,
      'numberOfGuests': numberOfGuests,
    };
  }

  // Factory method to create BookingModel from Firestore document
  factory BookingModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return BookingModel(
      id: data['id'] as String,
      startDate: DateTime.parse(data['startDate'] as String),
      endDate: DateTime.parse(data['endDate'] as String),
      pickupLocation: data['pickupLocation'] as String,
      destination: data['destination'] as String,
      numberOfGuests: data['numberOfGuests'] as int,
    );
  }
}

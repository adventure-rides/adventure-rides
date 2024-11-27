import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/booking_model.dart';

class BookingController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new booking
  Future<void> addBooking({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
    required String pickupLocation,
    required String destination,
    required int numberOfGuests,
  }) async {
    try {
      final booking = BookingModel(
        id: id,
        startDate: startDate,
        endDate: endDate,
        pickupLocation: pickupLocation,
        destination: destination,
        numberOfGuests: numberOfGuests,
      );

      await _firestore.collection('bookings').doc(id).set(booking.toJson());

      print("Booking added successfully!");
    } catch (e) {
      print("Error adding booking: $e");
    }
  }

  // Get booking by ID
  Future<BookingModel?> getBookingById(String id) async {
    try {
      final docSnapshot = await _firestore.collection('bookings').doc(id).get();

      if (docSnapshot.exists) {
        return BookingModel.fromSnapshot(docSnapshot);
      } else {
        print("Booking not found.");
        return null;
      }
    } catch (e) {
      print("Error getting booking: $e");
      return null;
    }
  }

  // Update an existing booking
  Future<void> updateBooking({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
    required String pickupLocation,
    required String destination,
    required int numberOfGuests,
  }) async {
    try {
      final booking = BookingModel(
        id: id,
        startDate: startDate,
        endDate: endDate,
        pickupLocation: pickupLocation,
        destination: destination,
        numberOfGuests: numberOfGuests,
      );

      await _firestore.collection('bookings').doc(id).update(booking.toJson());

      print("Booking updated successfully!");
    } catch (e) {
      print("Error updating booking: $e");
    }
  }

  // Delete a booking
  Future<void> deleteBooking(String id) async {
    try {
      await _firestore.collection('bookings').doc(id).delete();
      print("Booking deleted successfully!");
    } catch (e) {
      print("Error deleting booking: $e");
    }
  }

  // Get all bookings
  Future<List<BookingModel>> getAllBookings() async {
    try {
      final querySnapshot = await _firestore.collection('bookings').get();

      return querySnapshot.docs
          .map((doc) => BookingModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      print("Error getting all bookings: $e");
      return [];
    }
  }
}

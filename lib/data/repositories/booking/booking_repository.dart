import 'package:adventure_rides/data/repositories/authentication/general_auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../features/book/models/booking_model.dart';

class BookingRepository extends GetxController {
  static BookingRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  //Functions
  Future<List<BookingModel>> fetchUserBookings() async {
    try {
      final userId = GeneralAuthRepository.instance.authUser.uid;
      if(userId.isEmpty) throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Bookings').get();
      return result.docs.map((documentSnapshot) => BookingModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error in fetchUserBookings: $e');
      } // Log the actual error for debugging
      throw 'Something went wrong. Please try again';
    }
  }
  ///Store new user booking
  Future<void> bookingOrder(BookingModel booking, String userId) async {
    try{
      await _db.collection('Users').doc(userId).collection('Bookings').add(booking.toJson());
    }catch (e){
      throw 'Something went wrong while saving Booking information. Try again later';
    }
  }
}



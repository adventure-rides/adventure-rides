import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/book/models/booking_model.dart';
import '../authentication/authentication_repository.dart';

class BookingRepository extends GetxController {
  static BookingRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  //Functions
  Future<List<BookingModel>> fetchUserBookings() async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      if(userId.isEmpty) throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Bookings').get();
      return result.docs.map((documentSnapshot) => BookingModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e) {
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



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/trip_details_model.dart';

class TravelRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveTravelDetails(Map<String, dynamic> travelDetails) async {
    await _firestore.collection('Travels').add(travelDetails);
  }

  Future<TravelDetails?> getLastTravelDetails() async {
    try{
      final snapshot = await _firestore.collection('Travels').get();
      if (snapshot.docs.isNotEmpty){
        final doc = snapshot.docs.last; //To get the last document
        return TravelDetails(
          pickupLocation: doc['pickupLocation'],
          pickupDate: doc['pickupDate'],
          pickupTime: doc['pickupTime'],
          dropoffLocation: doc['dropoffLocation'],
          dropoffDate: doc['dropoffDate'],
          dropoffTime: doc['dropoffTime'],
          isRoundTrip: doc['isRoundTrip'], // Include round trip in model
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching last travel details');
      }
    }
    return null; // Return null if no travel details are found
  }
}
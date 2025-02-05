
import 'package:adventure_rides/features/authentication/screens/emergency_details/model/emergency_contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyRepository {
  List<EmergencyContactModel> contacts = [];

  void addContact(EmergencyContactModel contact) {
    contacts.add(contact);
  }

  List<EmergencyContactModel> getContacts() {
    return contacts;
  }

  void _updateUserLocation() {
    FirebaseFirestore.instance.collection('userLocations').doc('userId').set({
      //'latitude': _currentPosition.latitude,
      //'longitude': _currentPosition.longitude,
      //'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
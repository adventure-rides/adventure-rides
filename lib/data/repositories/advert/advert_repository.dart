import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/book/models/advert_model.dart';

class AdvertRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch adverts from Firestore
  Future<List<AdvertModel>> fetchAdverts() async {
    final snapshot = await _firestore.collection('Adverts').get();
    final adverts = snapshot.docs.map((doc) {
      final advert = AdvertModel.fromFirestore(doc.id, doc.data());
      return advert;
    }).toList();
    return adverts;
  }

  // Log a click and calculate revenue
  Future<void> logClick(String advertId, double clickValue) async {
    await _firestore.collection('Adverts').doc(advertId).update({
      'clicks': FieldValue.increment(1),
      'revenue': FieldValue.increment(clickValue),
    });
  }

  // Log an impression and calculate revenue
  Future<void> logImpression(String advertId, double impressionValue) async {
    await _firestore.collection('Adverts').doc(advertId).update({
      'impressions': FieldValue.increment(1),
      'revenue': FieldValue.increment(impressionValue),
    });
  }
}
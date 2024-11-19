import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/platform_exception.dart';

/// Repository for managing tour guide-related data and operations.
class GuideRepository extends GetxController {
  static GuideRepository get instance => Get.find();

  /// Firestore instance for database interactions
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get a limited number of available tour guides
  Future<List<TourGuideModel>> getAvailableGuides() async {
    try {
      final snapshot = await _firestore.collection('Guides').limit(4).get();
      return snapshot.docs.map((e) => TourGuideModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all available tour guides
  Future<List<TourGuideModel>> getAllAvailableGuides() async {
    final snapshot = await _firestore.collection('Guides').get();
    return snapshot.docs.map((querySnapshot) => TourGuideModel.fromSnapshot(querySnapshot)).toList();
  }

  /// Fetch tour guides based on a query
  Future<List<TourGuideModel>> fetchGuidesByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) => TourGuideModel.fromQuerySnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get experienced tour guides based on a list of guide IDs
  Future<List<TourGuideModel>> getExperiencedGuides(List<String> guideIds) async {
    try {
      final snapshot = await _firestore.collection('Guides')
          .where(FieldPath.documentId, whereIn: guideIds).get();
      return snapshot.docs.map((querySnapshot) => TourGuideModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get favorite guides based on a list of guide IDs
  Future<List<TourGuideModel>> getFavouriteGuides(List<String> guideIds) async {
    try {
      final snapshot = await _firestore.collection('Guides')
          .where(FieldPath.documentId, whereIn: guideIds).get();
      return snapshot.docs.map((querySnapshot) => TourGuideModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Search for tour guides with multiple filters
  Future<List<TourGuideModel>> searchTGuides(String query, {String? categoryId, String? brandId, double? minPrice, double? maxPrice, int? minExperience}) async {
    try {
      CollectionReference guidesCollection = _firestore.collection('Guides');
      Query queryRef = guidesCollection;

      if (query.isNotEmpty) {
        queryRef = queryRef
            .where('Name', isGreaterThanOrEqualTo: query)
            .where('Name', isLessThanOrEqualTo: '$query\uf8ff');
      }
      if (minExperience != null) {
        queryRef = queryRef.where('Experience', isGreaterThanOrEqualTo: minExperience);
      }
      if (minPrice != null) {
        queryRef = queryRef.where('Price', isGreaterThanOrEqualTo: minPrice);
      }
      if (maxPrice != null) {
        queryRef = queryRef.where('Price', isLessThanOrEqualTo: maxPrice);
      }

      final querySnapshot = await queryRef.get();
      return querySnapshot.docs.map((doc) => TourGuideModel.fromQuerySnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Add a rating to the guide's record and update average rating
  Future<void> addRatingToGuide(String guideId, GuideRating rating) async {
    try {
      DocumentReference guideRef = _firestore.collection('Guides').doc(guideId);
      DocumentSnapshot guideSnapshot = await guideRef.get();

      //cast guideSnapshot to the expected type (DocumentSnapshot<Map<String, dynamic>>) when passing it to TourGuideModel.fromSnapshot:
      if (guideSnapshot.exists) {
        TourGuideModel guide = TourGuideModel.fromSnapshot(guideSnapshot as DocumentSnapshot<Map<String, dynamic>>);
        guide.ratings.add(rating);
        guide.averageRating = guide.ratings.fold(0.0, (sum, r) => sum + r.rating) / guide.ratings.length;

        await guideRef.update({
          'Ratings': guide.ratings.map((e) => e.toMap()).toList(),
          'AverageRating': guide.averageRating,
        });
      } else {
        throw Exception('Guide not found');
      }
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}

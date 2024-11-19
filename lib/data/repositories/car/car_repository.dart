import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features/book/models/car_model.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/platform_exception.dart';

///Repository for managing car-related data and operations.
class CarRepository extends GetxController {
  static CarRepository get instance => Get.find();

  ///Firestore instance for database interactions
  final _db = FirebaseFirestore.instance;

  ///Get limited featured cars
  Future<List<CarModel>> getFeaturedCars() async {
    try {
      //final snapshot = await _db.collection('Cars').where('IsFeatured', isEqualTo: true).limit(4).get();
      final snapshot = await _db.collection('Cars').limit(4).get();
      return snapshot.docs.map((e) => CarModel.fromSnapshot(e)).toList();

    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///Get all featured cars
  /// Get all featured cars using Stream.
  Future<List<CarModel>> getAllFeaturedCarS() async {
    final snapshot = await _db.collection('Cars').get();
    //final snapshot = await _db.collection('Cars').where('NoAvailable', isNull: false).get();
    return snapshot.docs.map((querySnapshot) => CarModel.fromSnapshot(querySnapshot)).toList();
  }

  ///Get cars based on the query
  Future<List<CarModel>> fetchCarsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<CarModel> carList = querySnapshot.docs.map((doc) => CarModel.fromQuerySnapshot(doc)).toList();
      return carList;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///Get cars based on a list of car IDs.
  Future<List<CarModel>> getFavouriteCars(List<String> carIds) async {
    try {
      final snapshot = await _db.collection('Cars').where(FieldPath.documentId, whereIn: carIds).get();
      return snapshot.docs.map((querySnapshot) => CarModel.fromSnapshot(querySnapshot)).toList();

    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

///Get cars based on the brand
  Future<List<CarModel>> getCarsForBrand({required String brandId, int limit = -1}) async {
    try {
       final querySnapshot = limit == -1 ? await _db.collection('Cars').where('Brand.Id', isEqualTo: brandId).get() :
       await _db.collection('Cars').where('Brand.Id', isEqualTo: brandId).limit(limit).get();

       //Map cars
       final cars = querySnapshot.docs.map((doc) => CarModel.fromSnapshot(doc)).toList();
       return cars;

    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  Future<List<CarModel>> getCarsForCategory({required String categoryId, int limit = 6}) async {
    try {
      //Query to get all documents where carId matches the provided categoryId & fetch limited or unlimited based on limit
      QuerySnapshot carCategoryQuery = limit == -1
          ? await _db.collection('CarCategory').where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection('CarCategory').where('categoryId', isEqualTo: categoryId).limit(limit).get();

      //Extract productions from the documents
      List<String> carIds = carCategoryQuery.docs.map((doc) => doc['carId'] as String).toList();

      //Query to get all documents where the brandIds is in the list of brandIds, FieldPath, documentId to query documents in collection
      final carsQuery = await _db.collection('Cars').where(FieldPath.documentId, whereIn: carIds).get();

      //Extract brand names or other relevant data from the documents
      List<CarModel> cars = carsQuery.docs.map((doc) => CarModel.fromSnapshot(doc)).toList();

      return cars;

    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///Search Cars
  Future<List<CarModel>> searchCars(String query, {String? categoryId, String? brandId, double? minPrice, double? maxPrice}) async {
    try {
      // Reference to the 'cars' collection in Firestore
      CollectionReference carsCollection = FirebaseFirestore.instance.collection('Cars');

      // Start with a basic query to search for cars where the name contains the query
      Query queryRef = carsCollection;

      // Apply the search filter
      if (query.isNotEmpty) {
        queryRef = queryRef.where('Title', isGreaterThanOrEqualTo: query).where('Title', isLessThanOrEqualTo: '$query\uf8ff');
      }

      // Apply filters
      if (categoryId != null) {
        queryRef = queryRef.where('CategoryId', isEqualTo: categoryId);
      }

      if (brandId != null) {
        queryRef = queryRef.where('Brand.Id', isEqualTo: brandId);
      }

      if (minPrice != null) {
        queryRef = queryRef.where('Price', isGreaterThanOrEqualTo: minPrice);
      }

      if (maxPrice != null) {
        queryRef = queryRef.where('Price', isLessThanOrEqualTo: maxPrice);
      }

      // Execute the query
      QuerySnapshot querySnapshot = await queryRef.get();

      // Map the documents to CarModel objects
      final cars = querySnapshot.docs.map((doc) => CarModel.fromQuerySnapshot(doc)).toList();

      return cars;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

///Upload dummy data to the cloud firebase


}

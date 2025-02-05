import 'package:cloud_firestore/cloud_firestore.dart';
import 'brand_model.dart';
import 'car_attribute_model.dart';
import 'car_variation_model.dart';

class CarModel {
  String id;
  int noAvailable;
  double price;
  String title;
  double bookingPrice;
  String thumbnail;
  BrandModel? brand;
  String? categoryId;
  String carType;
  String? description;
  List<String>? images;
  List<CarAttributeModel>? carAttributes;
  List<CarVariationModel>? carVariations;
  List<DateTime> bookedDates; // Store booked dates

  CarModel({
    required this.id,
    required this.title,
    required this.noAvailable,
    required this.price,
    required this.thumbnail,
    required this.carType,
    this.brand,
    this.bookingPrice = 0.0,
    this.categoryId,
    this.description,
    this.images,
    this.carAttributes,
    this.carVariations,
    this.bookedDates = const [],
  });

  /// Create Empty function
  static CarModel empty() => CarModel(
    id: '',
    title: '',
    noAvailable: 0,
    price: 0,
    thumbnail: '',
    carType: '',
    bookedDates: [],
  );

  /// Convert to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'NoAvailable': noAvailable,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'BookingPrice': bookingPrice,
      'CategoryId': categoryId,
      'Brand': brand?.toJson(),
      'Description': description,
      'CarType': carType,
      'CarAttributes': carAttributes?.map((e) => e.toJson()).toList() ?? [],
      'CarVariations': carVariations?.map((e) => e.toJson()).toList() ?? [],
      'BookedDates': bookedDates.map((date) => date.toIso8601String()).toList(),
    };
  }

  /// Convert from Firebase snapshot
  factory CarModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CarModel(
      id: document.id,
      title: data['Title'],
      price: double.parse((data['Price'] ?? 0.0).toString()),
      noAvailable: data['NoAvailable'] ?? 0,
      bookingPrice: double.parse((data['BookingPrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      carType: data['CarType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      carAttributes: data['CarAttributes'] != null
          ? (data['CarAttributes'] as List).map((e) => CarAttributeModel.fromJson(e)).toList()
          : [],
      carVariations: data['CarVariations'] != null
          ? (data['CarVariations'] as List).map((e) => CarVariationModel.fromJson(e)).toList()
          : [],
      bookedDates: data['BookedDates'] != null
          ? (data['BookedDates'] as List).map((date) => DateTime.parse(date)).toList()
          : [],
    );
  }

  /// Convert from Firebase Query Snapshot
  factory CarModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return CarModel(
      id: document.id,
      title: data['Title'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      noAvailable: data['NoAvailable'] ?? 0,
      bookingPrice: double.parse((data['BookingPrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      carType: data['CarType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      carAttributes: data['CarAttributes'] != null
          ? (data['CarAttributes'] as List).map((e) => CarAttributeModel.fromJson(e)).toList()
          : [],
      carVariations: data['CarVariations'] != null
          ? (data['CarVariations'] as List).map((e) => CarVariationModel.fromJson(e)).toList()
          : [],
      bookedDates: data['BookedDates'] != null
          ? (data['BookedDates'] as List).map((date) => DateTime.parse(date)).toList()
          : [],
    );
  }

  /// Add booked dates to the car
  Future<void> bookCar(String carId, DateTime startDate, DateTime endDate) async {
    var docRef = FirebaseFirestore.instance.collection('cars').doc(carId);
    var doc = await docRef.get();

    if (doc.exists) {
      List<dynamic> existingDates = doc.data()?['BookedDates'] ?? [];
      List<String> newDates = existingDates.map((d) => d.toString()).toList();

      for (DateTime d = startDate; d.isBefore(endDate) || d.isAtSameMomentAs(endDate); d = d.add(Duration(days: 1))) {
        newDates.add(d.toIso8601String());
      }

      await docRef.update({'BookedDates': newDates});
    }
  }

  /// Remove a booking (if a cancellation happens)
  Future<void> cancelBooking(String carId, DateTime startDate, DateTime endDate) async {
    var docRef = FirebaseFirestore.instance.collection('cars').doc(carId);
    var doc = await docRef.get();

    if (doc.exists) {
      List<dynamic> existingDates = doc.data()?['BookedDates'] ?? [];
      List<String> updatedDates = existingDates
          .map((d) => DateTime.parse(d))
          .where((date) => date.isBefore(startDate) || date.isAfter(endDate))
          .map((date) => date.toIso8601String())
          .toList();

      await docRef.update({'BookedDates': updatedDates});
    }
  }
}
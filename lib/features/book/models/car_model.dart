import 'package:cloud_firestore/cloud_firestore.dart';
import 'brand_model.dart';
import 'car_attribute_model.dart';
import 'car_variation_model.dart';

class CarModel {
  String id;
  int noAvailable;
  double price;
  String title;
  DateTime? date;
  double bookingPrice;
  String thumbnail;
  BrandModel? brand;
  String? categoryId;
  String carType;
  String? description;
  List<String>? images;
  List<CarAttributeModel>? carAttributes;
  List<CarVariationModel>? carVariations;

  CarModel({
    required this.id,
    required this.title,
    required this.noAvailable,
    required this.price,
    required this.thumbnail,
    required this.carType,
    this.brand,
    this.date,
    this.images,
    this.bookingPrice = 0.0,
    this.categoryId,
    this.description,
    this.carAttributes,
    this.carVariations,
  });

  /// Create Empty func for clean code
  static CarModel empty() => CarModel(id: '', title: '', noAvailable: 0, price: 0, thumbnail: '', carType: '');

  /// Json Format
  toJson() {
    return {
      'Title': title,
      'NoAvailable': noAvailable,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'BookingPrice': bookingPrice,
      'CategoryId': categoryId,
      'Brand': brand!.toJson(),
      'Description': description,
      'CarType': carType,
      'CarAttributes': carAttributes != null ? carAttributes!.map((e) => e.toJson()).toList() : [],
      'CarVariations': carVariations != null ? carVariations!.map((e) => e.toJson()).toList() : [],
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
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
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      carAttributes: (data['CarAttributes'] as List<dynamic>).map((e) => CarAttributeModel.fromJson(e)).toList(),
      carVariations: (data['CarVariations'] as List<dynamic>).map((e) => CarVariationModel.fromJson(e)).toList(),
    );
  }

  // Map Json-oriented document snapshot from Firebase to Model
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
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      carAttributes: (data['CarAttributes'] as List<dynamic>).map((e) => CarAttributeModel.fromJson(e)).toList(),
      carVariations: (data['CarVariations'] as List<dynamic>).map((e) => CarVariationModel.fromJson(e)).toList(),
    );
  }
}

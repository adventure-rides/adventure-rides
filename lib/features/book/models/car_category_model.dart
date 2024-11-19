import 'package:cloud_firestore/cloud_firestore.dart';

class CarCategoryModel {
  final String carId;
  final String categoryId;

  CarCategoryModel({
    required this.carId,
    required this.categoryId,
  });
  Map<String, dynamic> toJson(){
    return {
      'brandId': carId,
      'categoryId': categoryId,
    };
  }
  factory CarCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CarCategoryModel (
      carId: data['carId'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}
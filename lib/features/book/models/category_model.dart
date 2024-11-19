import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
      });
  ///Empty helper function
  static CategoryModel empty() => CategoryModel(id: '', image: '', name: '', isFeatured: true);

  ///Convert model to Json structure so that you can store data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Name' : name,
      'Image' : image,
      'ParentId' : parentId,
      'IsFeatured' : isFeatured,
    };
  }
  /// MAp Json printed document snapshot from firebase to userModel
  factory CategoryModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? true,
      );
    } else {
      //Return empty constructor - if it is null
      return CategoryModel.empty();
    }
  }
}
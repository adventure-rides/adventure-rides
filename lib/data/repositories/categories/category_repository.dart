import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../features/book/models/category_model.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/platform_exception.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;
  ///Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      //final snapshot = await _db.collection('Categories').where('parentId', isNull: true).get();
      //final snapshot = await _db.collection('Categories').where('ParentId', ).get();

      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapShot(document)).toList();
      return list;

    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///Get Sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db.collection('Categories').where('ParentId', isEqualTo: categoryId).get();
      final list = snapshot.docs.map((e) => CategoryModel.fromSnapShot(e)).toList();
      return list;

    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///Upload categories to the cloud firebase
    /// Upload Categories to the Cloud Firebase

}
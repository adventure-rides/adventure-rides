
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features/book/models/banner_model.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/platform_exception.dart';

class BannerRepository extends GetxController{
  static BannerRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  ///Get all booking related to current user
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db.collection('Banners').where('active', isEqualTo: true).get();
      return result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();

    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners';
    }
  }

/// Upload banners to the cloud firebase
  /// Upload Banners to the Cloud Firebase

}
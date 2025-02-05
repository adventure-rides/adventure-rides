import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../features/authentication/models/User/user_model.dart';
import '../../../../utils/exceptions/firebase_exception.dart';
import '../../../../utils/exceptions/format_exception.dart';
import '../../../../utils/exceptions/platform_exception.dart';
import 'package:adventure_rides/data/repositories/authentication/general_auth_repository.dart';

/// Repository class for user-related operations
class User1Repository extends GetxController {
  static User1Repository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _initializeAuthIfNeeded();
      return await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetch user details based on user ID from `GeneralAuthRepository`
  Future<UserModel> fetchUserDetails() async {
    try {
      await _initializeAuthIfNeeded();
      final currentUser = GeneralAuthRepository.instance.currentUser;
      if (currentUser == null) throw 'User not authenticated';

      final documentSnapshot = await _db.collection("Users").doc(currentUser.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapShot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update user data in Firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _initializeAuthIfNeeded();
      return await _db.collection("Users").doc(updateUser.id).update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update any field in a specific user's collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _initializeAuthIfNeeded();
      final currentUser = GeneralAuthRepository.instance.currentUser;
      if (currentUser == null) throw 'User not authenticated';

      return await _db.collection("Users").doc(currentUser.uid).update(json);
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Remove user data from Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _initializeAuthIfNeeded();
      return await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload an image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      await _initializeAuthIfNeeded();
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Helper function to initialize `GeneralAuthRepository` if not already initialized
  Future<void> _initializeAuthIfNeeded() async {
    if (!Get.isRegistered<GeneralAuthRepository>()) {
      Get.put(() => GeneralAuthRepository());
    }
  }
}
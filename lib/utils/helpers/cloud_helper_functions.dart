
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../exceptions/firebase_exception.dart';
import '../exceptions/platform_exception.dart';

class SCloudHelperFunctions {

  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if(!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data Found!'));
    }
    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong.'));
    }
    return null;
  }
  static Widget? checkMultiRecordState<T>({required AsyncSnapshot<List<T>> snapshot, Widget? loader, Widget? error, Widget? nothingFound}) {

    if (snapshot.connectionState == ConnectionState.waiting) {
      if(loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if(!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if(nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data Found!'));
    }
    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something went wrong.'));
    }
    return null;
  }
  /// Create a reference with an initial ile path and retrieve the download URL
  static Future<String> getURLFromFilePathAndName(String path) async {
    try {
      if (path.isEmpty) return '';
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;

    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

}
import 'package:adventure_rides/data/repositories/authentication/general_auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../features/personalization/models/schedule_model.dart';

class ScheduleRepository extends GetxController {
  static ScheduleRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ScheduleModel>> fetchUserSchedules() async {
    try {
      final userId = GeneralAuthRepository.instance.authUser.uid;
      if (userId
          .isEmpty) {
        throw "Unable to find user information. Try again in few minutes.";
      }

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Schedules')
          .get();

      // Map the documents to ScheduleModel objects
      return result.docs
          .map((documentSnapshot) =>
          ScheduleModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw "Something went wrong while fetching Schedule information. Sign in and Try Again";
    }
  }

  ///Clear the "selected" field for all schedules
  Future<void> updateSelectedField(String scheduleId, bool selected) async {
    try {
      final userId = GeneralAuthRepository.instance.authUser.uid;
      if (kDebugMode) {
        print('User ID: $userId, Schedule ID: $scheduleId');
      }
      await _db.collection('Users').doc(userId).collection('Schedules').doc(scheduleId).update(
            {'SelectedSchedule': selected});

    } catch (e) {
      throw 'Unable to update your schedule selection. Try again later: $e';
    }
  }

  /*
  Future<void> updateSelectedField(String scheduleId, bool selected) async {
    try {
      final userId = GeneralAuthRepository.instance.authUser.uid;
      print('User ID: $userId, Schedule ID: $scheduleId');
      await _db.collection('Users').doc(userId).collection('Schedules').doc(
          scheduleId).update(
          {'SelectedSchedule': selected});
    } catch (e) {
      throw 'Unable to update your schedule selection. Try again later: $e';
    }
  }
  */

  /// Store new user booking
  Future<String> addSchedule(ScheduleModel schedule) async {
    try {
      final userId = GeneralAuthRepository.instance.authUser.uid;
      debugPrint("Attempting to save schedule for User ID: $userId");

      final currentSchedule = await _db
          .collection('Users')
          .doc(userId)
          .collection('Schedules')
          .add(schedule.toJson());

      debugPrint("Schedule saved with ID: ${currentSchedule.id}");
      return currentSchedule.id;
    } catch (e) {
      debugPrint("Error in addSchedule: $e");
      throw 'Unable to add your schedule. Try again later';
    }
  }
}
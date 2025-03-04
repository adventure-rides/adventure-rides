import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleModel {
  String id;
  final String pickupLocation;
  final String pickupDate;
  final String pickupTime;
  final String dropoffLocation;
  final String dropoffDate;
  final String dropoffTime;
  final bool isRoundTrip;
  bool selectedSchedule;

  ScheduleModel({
    required this.id,
    required this.pickupLocation,
    required this.pickupDate,
    required this.pickupTime,
    required this.dropoffLocation,
    required this.dropoffDate,
    required this.dropoffTime,
    this.isRoundTrip = true,
    this.selectedSchedule = true,
  });

  /// Factory method to create an empty instance of `ScheduleModel`.
  static ScheduleModel empty() => ScheduleModel(
    id: '',
    pickupLocation: '',
    pickupDate: '',
    pickupTime: '',
    dropoffLocation: '',
    dropoffDate: '',
    dropoffTime: '',
  );

  /// Converts the model to JSON for Firestore or other storage.
  Map<String, dynamic> toJson() {
    return {
      //'id': id,
      'pickupLocation': pickupLocation,
      'pickupDate': pickupDate,
      'pickupTime': pickupTime,
      'dropoffLocation': dropoffLocation,
      'dropoffDate': dropoffDate, // Convert DateTime to String
      'dropoffTime': dropoffTime,
      'isRoundTrip': isRoundTrip,
      'SelectedSchedule': selectedSchedule,
    };
  }

  /// Creates an instance from a `Map<String, dynamic>` (Firestore data or others).
  factory ScheduleModel.fromMap(Map<String, dynamic> data) {
    return ScheduleModel(
      id: data['id'] ?? '',
      pickupLocation: data['pickupLocation'] ?? '',
      pickupDate: data['pickupDate'] ?? '',
      pickupTime: data['pickupTime'] ?? '',
      dropoffLocation: data['dropoffLocation'] ?? '',
      dropoffDate: data['dropoffDate'] ?? '',
      dropoffTime: data['dropoffTime'] ?? '',
      isRoundTrip: data['isRoundTrip'] is bool ? data['isRoundTrip'] : true,
      selectedSchedule: data['SelectedSchedule'] is bool ? data['SelectedSchedule'] : true,
    );
  }

  /// Creates an instance from a Firestore `DocumentSnapshot`.
  /// Factory constructor to create a ScheduleModel from a DocumentSnapshot
  factory ScheduleModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {}; //? ?? {} add immediately after dynamic closing tag
    return ScheduleModel(
      id: snapshot.id, // Get the document ID directly from the snapshot
      //id: data['id'] ?? '',
      pickupLocation: data['pickupLocation'] ?? '',
      pickupDate: data['pickupDate'] ?? '',
      pickupTime: data['pickupTime'] ?? '',
      dropoffLocation: data['dropoffLocation'] ?? '',
      dropoffDate: data['dropoffDate'] ?? '',
      dropoffTime: data['dropoffTime'] ?? '',
      isRoundTrip: data['isRoundTrip'] is bool ? data['isRoundTrip'] : true,
      selectedSchedule: data['SelectedSchedule'] is bool ? data['SelectedSchedule'] : true,
    );
  }

  @override
  String toString() {
    return 'Pickup: $pickupDate at $pickupTime\nDropoff: $dropoffDate at $dropoffTime\nRound Trip: ${isRoundTrip ? 'Yes' : 'No'}';
  }
/*
  @override
  String toString() {
    return '$pickupDate, $pickupTime, $dropoffDate $dropoffTime, $isRoundTrip';
  }
  */
}
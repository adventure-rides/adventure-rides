import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = false,
  });

  String get formattedPhoneNo => SFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
    dateTime: null,
    selectedAddress: false,
  );

  /// Converts the model into a JSON object (for Firestore or other storage).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateTime': dateTime?.toIso8601String(), // Convert to string if not null
      'selectedAddress': selectedAddress,
    };
  }

  /// Creates an instance from a `Map<String, dynamic>` (e.g., Firestore document data).
  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['id'] ?? '', // Fallback to an empty string if `id` is null
      name: data['name'] ?? '', // Fallback to empty string
      phoneNumber: data['phoneNumber'] ?? '', // Fallback to empty string
      street: data['street'] ?? '', // Fallback to empty string
      city: data['city'] ?? '', // Fallback to empty string
      state: data['state'] ?? '', // Fallback to empty string
      postalCode: data['postalCode'] ?? '', // Fallback to empty string
      country: data['country'] ?? '', // Fallback to empty string
      dateTime: data['dateTime'] != null
          ? (data['dateTime'] is Timestamp
          ? (data['dateTime'] as Timestamp).toDate()
          : DateTime.tryParse(data['dateTime']))
          : null, // Handle both Timestamp and String date formats
      selectedAddress: data['selectedAddress'] as bool? ?? false, // Default to `false` if null
    );
  }

  /// Creates an instance from a Firestore `DocumentSnapshot`.
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      postalCode: data['postalCode'] ?? '',
      country: data['country'] ?? '',
      dateTime: data['dateTime'] != null
          ? (data['dateTime'] is Timestamp
          ? (data['dateTime'] as Timestamp).toDate()
          : DateTime.tryParse(data['dateTime']))
          : null,
      selectedAddress: data['selectedAddress'] as bool? ?? false,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state $postalCode, $country';
  }
}

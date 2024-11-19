import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/formatters/formatter.dart';
import '../../../personalization/models/address_model.dart';

///Model class representing user data
class UserModel {
  //Keep the values final those that don't need update
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  final List<AddressModel>? addresses;

  ///Constructor for user model
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.addresses,
  });

  ///Helper functions to get the full name
  String get fullName => '$firstName $lastName';

  ///Helper functions to format Phone number
  String get formattedPhoneNo => SFormatter.formatPhoneNumber(phoneNumber);

  ///Static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  ///Static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // Combine first and lastname
    String usernameWithPrefix = "adr_$firstName$lastName"; // Add cwt prefix
    return usernameWithPrefix;
  }
  /// Static function
  static UserModel empty() => UserModel(id: '', firstName: '', lastName: '', username: '', email: '', phoneNumber: '', profilePicture: '');
  /// Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  ///Factory method to create a UserModel from a firebase document snapshot
  factory UserModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    }
    throw Exception("Document does not contain valid user data");
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String imageUrl;
  final String targetScreen;
  final bool active;
  final String title;        // Added title
  final String buttonText;   // Added button text
  final String buttonTargetScreen; // For the button press

  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
    required this.title,
    required this.buttonText,
    required this.buttonTargetScreen,
  });

  // Map converts data to JSON format
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'targetScreen': targetScreen,
      'active': active,
      'title': title,
      'buttonText': buttonText,
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      imageUrl: data['imageUrl'] ?? '',
      targetScreen: data['targetScreen'] ?? '',
      active: data['active'] ?? false,
      title: data['title'] ?? '',                // Added title
      buttonText: data['buttonText'] ?? '',
      buttonTargetScreen: data['buttonTargetScreen'] ?? '',      // Added button text
    );
  }
}
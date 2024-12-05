import 'package:cloud_firestore/cloud_firestore.dart';

class AdvertModel {
  final String id;
  final String advertTitle;
  final String imageUrl;
  final String redirectUrl;
  final bool isActive;
  final int clicks;
  final int impressions;
  final double revenue;
  final DateTime createdAt;

  AdvertModel({
    required this.id,
    required this.advertTitle,
    required this.imageUrl,
    required this.redirectUrl,
    required this.isActive,
    required this.clicks,
    required this.impressions,
    required this.revenue,
    required this.createdAt,
  });

  // Factory method to create an Advert object from Firestore data
  factory AdvertModel.fromFirestore(String id, Map<String, dynamic> data) {
    return AdvertModel(
      id: id,
      advertTitle: data['advertTitle'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      redirectUrl: data['redirectUrl'] ?? '',
      isActive: data['isActive'] ?? false,
      clicks: data['clicks'] ?? 0,
      impressions: data['impressions'] ?? 0,
      revenue: (data['revenue'] ?? 0.0).toDouble(),
      createdAt: (data['createdAt'] as Timestamp).toDate()
    );
  }

  // Convert the Advert object to a map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'advertTitle': advertTitle,
      'imageUrl': imageUrl,
      'redirectUrl': redirectUrl,
      'isActive': isActive,
      'clicks': clicks,
      'impressions': impressions,
      'revenue': revenue,
      'createdAt': createdAt,
    };
  }
}
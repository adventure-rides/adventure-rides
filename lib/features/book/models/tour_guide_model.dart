import 'package:cloud_firestore/cloud_firestore.dart';

class TourGuideModel {
  String id;
  int age;
  String guideRegNo;
  int experience;
  double averageRating;
  double guideFee;
  String image;
  String tName;
  DateTime? date;
  double guideRating;
  Map<String, String> languages;
  List<GuideRating> ratings;
  String? description;
  bool guideAvailability;

  TourGuideModel({
    required this.id,
    required this.tName,
    required this.guideRegNo,
    required this.age,
    required this.image,
    this.date,
    required this.guideRating,
    required this.experience,
    required this.languages,
    this.guideFee = 0.0,
    this.description,
    this.averageRating = 0.0,
    this.ratings = const [],
    this.guideAvailability = true,
  });

  /// Create an empty instance of TourGuideModel
  static TourGuideModel empty() => TourGuideModel(
    id: '',
    age: 0,
    image: '',
    guideRegNo: '',
    guideRating: 0,
    experience: 0,
    tName: '',
    languages: {},
  );

  /// Convert the model to JSON format for Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': tName,
      'GuideRegNo': guideRegNo,
      'Experience': experience,
      'Age': age,
      'Languages': languages,
      'Image': image,
      'GuideFee': guideFee,
      'Description': description,
      'GuideRating': guideRating,
      'AverageRating': averageRating,
      'Ratings': ratings.map((rating) => rating.toMap()).toList(),
      'GuideAvailability': guideAvailability,
    };
  }

  /// Map Firestore document snapshot to the model
  factory TourGuideModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TourGuideModel(
      id: document.id,
      tName: data['Name'] ?? '',
      guideRegNo: data['GuideRegNo'] ?? 0,
      languages: Map<String, String>.from(data['Languages'] ?? {}),
      age: data['Age'] ?? 0,
      guideFee: (data['GuideFee'] ?? 0.0).toDouble(),
      image: data['Image'] ?? '',
      experience: data['Experience'] ?? 0,
      description: data['Description'] ?? '',
      guideRating: (data['GuideRating'] ?? 0.0).toDouble(),
      averageRating: (data['AverageRating'] ?? 0.0).toDouble(),
      ratings: (data['Ratings'] as List<dynamic>?)
          ?.map((rating) => GuideRating.fromMap(rating as Map<String, dynamic>))
          .toList() ?? [],
      guideAvailability: data['GuideAvailability'] ?? true,
    );
  }

  /// Map query snapshot to the model
  factory TourGuideModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return TourGuideModel(
      id: document.id,
      tName: data['Name'] ?? '',
      guideRegNo: data['GuideRegNo'] ?? '',
      languages: Map<String, String>.from(data['Languages'] ?? {}),
      age: data['Age'] ?? 0,
      guideFee: (data['GuideFee'] ?? 0.0).toDouble(),
      image: data['Image'] ?? '',
      experience: data['Experience'] ?? 0,
      description: data['Description'] ?? '',
      guideRating: (data['GuideRating'] ?? 0.0).toDouble(),
      averageRating: (data['AverageRating'] ?? 0.0).toDouble(),
      ratings: (data['Ratings'] as List<dynamic>?)
          ?.map((rating) => GuideRating.fromMap(rating as Map<String, dynamic>))
          .toList() ?? [],
      guideAvailability: data['GuideAvailability'] ?? true,
    );
  }
  void addRating(GuideRating newRating) {
    ratings.add(newRating);  // Add new rating to the list of ratings
    _updateAverageRating();  // Recalculate the average rating
  }

  void _updateAverageRating() {
    if (ratings.isNotEmpty) {
      double total = 0.0;
      for (var rating in ratings) {
        total += rating.rating;
      }
      averageRating = total / ratings.length;
    } else {
      averageRating = 0.0; // Set to 0 if there are no ratings
    }
  }
}

class GuideRating {
  //String userId;
  double rating;
  String review;
  DateTime date;

  GuideRating({
    //required this.userId,
    required this.rating,
    required this.review,
    required this.date,
  });
  // Convert GuideRating to a Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      //'UserId': userId,
      'Rating': rating,
      'Review': review,
      'Date': date,
    };
  }

  // Create GuideRating from Firestore data
  factory GuideRating.fromMap(Map<String, dynamic> map) {
    return GuideRating(
      //userId: map['UserId'] ?? '',
      rating: (map['Rating'] ?? 0.0).toDouble(),
      review: map['Review'] ?? '',
      date: (map['Date'] as Timestamp).toDate(),
    );
  }
}
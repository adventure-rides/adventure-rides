class RatingModel {
  final double rating; // Star rating
  final String? review; // Optional review text
  final DateTime createdAt;

  RatingModel({
    required this.rating,
    this.review,
    required this.createdAt,
  });

  // You can use a method to serialize the rating model to a Map for saving in the database
  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'review': review,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Factory to create RatingModel from a Map (for reading from Firestore or other DB)
  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      rating: map['rating'],
      review: map['review'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

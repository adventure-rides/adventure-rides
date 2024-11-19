
class CarReviewModel {
  final String id;
  final String userId;
  final double rating;
  final String? comment;
  final String? userName;
  final DateTime timestamp;
  final String? userImageUrl;
  final String? companyComment;
  final DateTime? companyTimestamp;

  CarReviewModel({
    required this.id,
    required this.userId,
    required this.rating,
    required this.timestamp,
    this.comment,
    this.userName,
    this.userImageUrl,
    this.companyComment,
    this.companyTimestamp,
  });

  /// Create Empty func for clean code
  static CarReviewModel empty() => CarReviewModel(id: '', userId: '', rating: 5, timestamp: DateTime.now());

/// Map Json oriented document snapshot from Firebase to Model
}

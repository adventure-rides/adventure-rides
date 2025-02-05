class TravelDetails {
  final String pickupLocation;
  final String pickupDate;
  final String pickupTime;
  final String dropoffLocation;
  final String dropoffDate;
  final String dropoffTime;
  final bool isRoundTrip; // New field for round trip

  TravelDetails({
    required this.pickupLocation,
    required this.pickupDate,
    required this.pickupTime,
    required this.dropoffLocation,
    required this.dropoffDate,
    required this.dropoffTime,
    required this.isRoundTrip,
  });

  Map<String, dynamic> toJson() {
    return {
      'pickupLocation': pickupLocation,
      'pickupDate': pickupDate,
      'pickupTime': pickupTime,
      'dropoffLocation': dropoffLocation,
      'dropoffDate': dropoffDate,
      'dropoffTime': dropoffTime,
      'isRoundTrip': isRoundTrip, // Include round trip in JSON
    };
  }
}
class AddressModel {
  final String addressLine;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  AddressModel({
    required this.addressLine,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'addressLine': addressLine,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      addressLine: data['addressLine'] as String,
      city: data['city'] as String,
      state: data['state'] as String,
      zipCode: data['zipCode'] as String,
      country: data['country'] as String,
    );
  }
}

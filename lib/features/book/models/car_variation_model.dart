class CarVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int noAvailable;
  Map<String, String> attributeValues;

  CarVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.noAvailable = 0,
    required this.attributeValues,
  });

  /// Create Empty func for clean code
  static CarVariationModel empty() => CarVariationModel(id: '', attributeValues: {});

  /// Json Format
  toJson() {
    return {
      'Id': id,
      'Image': image,
      'Description': description,
      'Price': price,
      'BookingPrice': salePrice,
      'SKU': sku,
      'NoAvailable': noAvailable,
      'AttributeValues': attributeValues,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory CarVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if(data.isEmpty) return CarVariationModel.empty();
    return CarVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      noAvailable: data['NoAvailable'] ?? 0,
      salePrice: double.parse((data['BookingPrice'] ?? 0.0).toString()),
      image: data['Image'] ?? '',
      attributeValues: Map<String, String>.from(data['AttributeValues']),
    );
  }
}

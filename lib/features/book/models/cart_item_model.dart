class CartItemModel {
  String? carId;
  String? guideId;
  String itemId; // General ID to distinguish between car and guide
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;
  double? guideFee; // For guides
  String? guideName; // For guides
  double? rating; // For guides

  /// Constructor
  CartItemModel({
    this.carId,
    this.guideId,
    required this.itemId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
    this.selectedVariation,
    this.guideFee,
    this.guideName,
    this.rating,
  });

  /// Empty cart
  static CartItemModel empty() => CartItemModel(itemId: '', quantity: 0);

  /// Convert a cart item to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      //'guideId': guideId,
      'itemId': itemId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
      //'guideFee': guideFee,
      //'guideName': guideName,
      'rating': rating,
    };
  }

  /// Create a cart item from a JSON map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      carId: json['carId'],
      //guideId: json['guideId'],
      itemId: json['itemId'],
      title: json['title'],
      price: json['price']?.toDouble() ?? 0.0,
      image: json['image'],
      quantity: json['quantity'] ?? 1,
      variationId: json['variationId'] ?? '',
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'] != null ? Map<String, String>.from(json['selectedVariation']) : null,
      //guideFee: json['guideFee']?.toDouble(),
      //guideName: json['guideName'],
      rating: json['rating']?.toDouble(),
    );
  }
}
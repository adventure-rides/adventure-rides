import 'package:adventure_rides/features/book/controllers/car/variation_controller.dart';
import 'package:get/get.dart';
import '../../../../utils/constraints/enums.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/cart_item_model.dart';
import '../../models/car_model.dart';
import '../../models/tour_guide_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt itemQuantityInCart = 0.obs; // Generalized quantity for car or guide
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  get selectedPaymentMethod => null;

  // Add car or guide to cart
  void addToCart(dynamic item) {
    if (item is CarModel) {
      addCarToCart(item);
    } else if (item is TourGuideModel) {
      addGuideToCart(item);
    }
  }

  void addCarToCart(CarModel car) {
    if (itemQuantityInCart.value < 1) {
      SLoaders.customToast(message: 'Select Quantity');
      return;
    }
    if (car.carType == CarType.variables.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      SLoaders.customToast(message: 'Select variation');
      return;
    }
    if (car.carType == CarType.variables.toString()) {
      if (variationController.selectedVariation.value.noAvailable < 1) {
        SLoaders.warningSnackBar(message: 'Selected variation not available', title: 'Oh Snap!');
        return;
      }
    } else if (car.noAvailable < 1) {
      SLoaders.warningSnackBar(message: 'Car not available', title: 'Oh Snap!');
      return;
    }

    final selectedCartItem = convertToCartItem(car, itemQuantityInCart.value);

    int index = cartItems.indexWhere((cartItem) =>
    cartItem.carId == selectedCartItem.carId &&
        cartItem.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }
    updateCart();
    SLoaders.customToast(message: 'Car added to the bookings.');
  }

  void addGuideToCart(TourGuideModel guide) {
    if (itemQuantityInCart.value < 1) {
      SLoaders.customToast(message: 'Select Quantity');
      return;
    }
    if (!guide.guideAvailability) {
      SLoaders.warningSnackBar(message: 'Guide not available', title: 'Oh Snap!');
      return;
    }

    final selectedCartItem = convertToCartItemForGuide(guide, itemQuantityInCart.value);

    int index = cartItems.indexWhere((cartItem) =>
    cartItem.guideId == selectedCartItem.guideId);

    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }
    updateCart();
    SLoaders.customToast(message: 'Guide added to the bookings.');
  }

  /// Converts a CarModel to a BookingItemModel
  CartItemModel convertToCartItem(CarModel car, int quantity) {
    if (car.carType == CarType.single.toString()) {
      variationController.resetSelectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? (variation.salePrice > 0.0 ? variation.salePrice : variation.price)
        : (car.bookingPrice > 0.0 ? car.bookingPrice : car.price);

    return CartItemModel(
      carId: car.id,
      itemId: car.id, // Generalized item ID for cart items
      title: car.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : car.thumbnail,
      brandName: car.brand != null ? car.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  /// Converts a TourGuideModel to a BookingItemModel
  CartItemModel convertToCartItemForGuide(TourGuideModel guide, int quantity) {
    return CartItemModel(
      guideId: guide.id,
      itemId: guide.id, // Generalized item ID for cart items
      title: guide.tName,
      price: guide.guideFee,
      quantity: quantity,
      image: guide.image,
      guideName: guide.tName,
      guideFee: guide.guideFee,
      rating: guide.averageRating,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    SLocalStorage.instance().writeData('bookingItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings = SLocalStorage.instance().readData<List<dynamic>>('bookingItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }
  /// Method to update the quantity of a guide already added to the cart
  void updateAlreadyAddedGuideCount(TourGuideModel guide) {
    // Check if the guide already exists in the cart
    final existingGuide = cartItems.firstWhereOrNull((item) => item.guideId == guide.id);

    // Update the item quantity in cart for the specific guide
    itemQuantityInCart.value = existingGuide?.quantity ?? 0;
  }
  /// Method to update the quantity of a car already added to the cart
  void updateAlreadyAddedCarCount(CarModel car) {
    // Check if the car already exists in the cart
    final existingCar = cartItems.firstWhereOrNull((item) => item.carId == car.id);

    // Update the item quantity in cart for the specific guide
    itemQuantityInCart.value = existingCar?.quantity ?? 0;
  }
/// Additional methods for handling cart item quantities

// To get the car quantity in cart
  int getCarQuantityInCart(String carId) {
    // Sum up the quantity for all cart items with the specified car ID
    final foundQuantity = cartItems
        .where((item) => item.carId == carId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundQuantity;
  }

// To get the quantity of a specific variation of a car in the cart
  int getVariationQuantityInCart(String carId, String variationId) {
    // Find the specific car variation by carId and variationId
    final foundItem = cartItems.firstWhere(
          (item) => item.carId == carId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem.quantity;
  }

/// To get the guide quantity in cart
  int getGuideQuantityInCart(String guideId) {
    // Sum up the quantity for all cart items with the specified guide ID
    final foundQuantity = cartItems
        .where((item) => item.guideId == guideId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundQuantity;
  }

/// To clear the bookings
  void clearCart() {
    itemQuantityInCart.value = 0; // Reset item quantity to zero
    cartItems.clear(); // Clear all items from the cart
    updateCart(); // Update cart totals and save state
  }

}

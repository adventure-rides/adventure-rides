import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:get/get.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/cart_item_model.dart';

class BookGuideCartController extends GetxController {
  static BookGuideCartController get instance => Get.find();

  //Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt guideQuantityInCart = 0.obs; // Changed to guide quantity
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  BookGuideCartController() {
    loadCartItems();
  }

  //Add items to cart
  void addToCart(TourGuideModel guide) {
    //Quantity check
    if (guideQuantityInCart.value < 1) {
      SLoaders.customToast(message: 'Select Quantity');
      return;
    }

    //Convert the guide model to a cart item model with the given quantity
    final selectedCartItem = convertToCartItem(guide, guideQuantityInCart.value);

    //Check if already added in the cart
    int index = cartItems.indexWhere((cartItems) =>
    cartItems.guideId == selectedCartItem.guideId); // Assuming guideId exists

    if (index >= 0) {
      //This quantity is already added or updated/removed from the design (cart)
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }
    updateCart();
    SLoaders.customToast(message: 'Your booked guide has been added to the cart.');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItems) =>
    cartItems.guideId == item.guideId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItems) =>
    cartItems.guideId == item.guideId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      }
    } else {
      //Show dialog before completely removing
      cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems
          .removeAt(index);
    }
    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Guide',
      middleText: 'Are you sure you want to remove this guide?',
      onConfirm: () {
        //Remove the item from the cart
        cartItems.removeAt(index);
        updateCart();
        SLoaders.customToast(message: 'Guide removed from the cart.');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  //Initialize already added item's count in the cart
  void updateAlreadyAddedGuideCount(TourGuideModel guide) {
    guideQuantityInCart.value = getGuideQuantityInCart(guide.id);
  }

  //This function converts a TourGuideModel to a CartItemModel
  CartItemModel convertToCartItem(TourGuideModel guide, int quantity) {
    return CartItemModel(
      guideId: guide.id, // Assuming CartItemModel has guideId
      title: guide.tName, // Assuming TourGuideModel has a name
      price: guide.guideFee, // Assuming TourGuideModel has a fee
      quantity: quantity,
      image: guide.image, itemId: '', // Assuming TourGuideModel has an image
      // Add other necessary fields here...
    );
  }

  //Update cart values
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
    SLocalStorage.instance().writeData('guideCartItems', cartItemStrings); // Changed key
  }

  void loadCartItems() {
    final cartItemStrings = SLocalStorage.instance().readData<List<dynamic>>('guideCartItems'); // Changed key
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  //To get the guide quantity in cart
  int getGuideQuantityInCart(String guideId) {
    final foundItem =
    cartItems.where((item) => item.guideId == guideId).fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  void clearCart() {
    guideQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}

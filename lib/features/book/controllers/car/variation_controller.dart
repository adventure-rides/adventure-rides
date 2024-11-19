import 'package:get/get.dart';
import '../../models/car_model.dart';
import '../../models/car_variation_model.dart';
import 'cart_controller.dart';
import 'images_controller.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  ///variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<CarVariationModel> selectedVariation = CarVariationModel.empty().obs;

  ///Select attribute and variation
  void onAttributeSelected(CarModel product, attributeName, attributeValue) {
    //When attribute is selected we will first add that attribute to the selected attributes
    final selectedAttributes = Map<String, dynamic>.from(
        this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.carVariations!.firstWhere((
        variation) =>
        _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => CarVariationModel.empty(),
    );
    //Show the selected variation image as a main image
      if (selectedVariation.image.isNotEmpty) {
        ImageController.instance.selectedCarImage.value = selectedVariation.image;
      }
    // Show the selected variation quantity already in the cart
    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      // Fetch the quantity for the selected car variation in the cart
      cartController.itemQuantityInCart.value = cartController.getVariationQuantityInCart(product.id, selectedVariation.id);
    }
    //Assign selected variation
    this.selectedVariation.value = selectedVariation;

    //update selected product variation status
    getProductVariationStockStatus();
  }

    //Check if the selected attributes matches any variations
    bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
      //If selected attributes contains 3 attributes and current variation contains 2 then return
      if(variationAttributes.length != selectedAttributes.length) return false;

      //If any of the attributes is different then return, e.g [green, large] * [Green, Small]
      for(final key in variationAttributes.keys) {
        //Attribute [key] = value which could be [Green, Small, Cotton] etc
        if (variationAttributes[key] != selectedAttributes[key]) return false;
      }
      return true;

  }

 ///Check attribute availability / Stock in variation
  Set<String?> getAttributesAvailabilityInVariation(List<CarVariationModel> variations, String attributeName) {
    //Pass the variations to check which attributes are available and stock is not 0
    final availableVariationAttributeValues = variations
        .where((variation) =>
        //check empty / out of stock attributes
        variation.attributeValues[attributeName] != null && variation.attributeValues[attributeName]!.isNotEmpty && variation.noAvailable > 0)
        //Fetch all non-empty attributes of variations
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }
  String getVariationPrice(){
    return (selectedVariation.value.salePrice > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }

  ///Check product variation stock status
  void getProductVariationStockStatus(){
    variationStockStatus.value = selectedVariation.value.noAvailable > 0 ? 'In Stock ' : 'Out of Stock';
  }
  ///Reset selected attributes when switching products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = CarVariationModel.empty();
  }
}
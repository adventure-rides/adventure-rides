import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../common/widgets/Text/car_price_text.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../controllers/car/cart_controller.dart';
import '../add_remove_button.dart';
import '../cart_item.dart';

class SCartItems extends StatelessWidget {
  const SCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) =>
            const SizedBox(height: SSizes.spaceBtwSections),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx(
          () {
            final item = cartController.cartItems[index];
            return Column(
              children: [
                /// Cart item
                SCartItem(cartItem: item),
                if (showAddRemoveButtons)
                  const SizedBox(height: SSizes.spaceBtwItems),

                ///Add remove button row with total price
                if (showAddRemoveButtons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ///Extra space
                          const SizedBox(width: 70),

                          ///Add remove buttons
                          SCarQualityWithAddRemoveButton(
                            quantity: item.quantity,
                            add: () => cartController.addToCart(item),
                            remove: () {
                              // Decrease the item quantity in the cart, or remove it if quantity is zero
                              if (item.quantity > 1) {
                                // If there's more than 1, just decrease the quantity
                                item.quantity--;
                                cartController.updateCart(); // You may want to call a method to update cart totals
                              } else {
                                // Remove the item from the cart entirely
                                cartController.cartItems.removeWhere((cartItem) => cartItem.itemId == item.itemId);
                                cartController.updateCart(); // Update totals after removal
                              }
                            },
                          ),
                        ],
                      ),
                      ///Car total price
                      SCarPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                    ],
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/pricing_calculator.dart';
import '../../../controllers/car/cart_controller.dart';

class SBillingAmountSection extends StatelessWidget {
  const SBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        ///Car booking
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Car-Booking', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$$subTotal', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 2),
        ///Tour guide fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Guide fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${SPricingCalculator.calculateShippingCost(subTotal, 'US')}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 2),

        ///Insurance fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Insurance fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${SPricingCalculator.calculateTax(subTotal, 'US')}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 2),

        ///Total booking price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total Price', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${SPricingCalculator.calculateTotalPrice(subTotal, 'US')}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}

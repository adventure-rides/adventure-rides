import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/chips/choice_chips.dart';
import '../../../../../common/container/rounded_container.dart';
import '../../../../../common/widgets/Text/car_price_text.dart';
import '../../../../../common/widgets/Text/car_title_text.dart';
import '../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/car/variation_controller.dart';
import '../../../models/car_model.dart';

class SCarAttributes extends StatelessWidget {
  const SCarAttributes({super.key, required this.car});

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = SHelperFunctions().isDarkMode(context);

    return Obx(
      () => Column(
        children: [
          /// Selected attribute pricing & Description
          //Display variation price and stock when some variation is selected
          if(controller.selectedVariation.value.id.isNotEmpty)
          SRoundedContainer(
            backgroundColor: dark ? SColors.darkerGrey : SColors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Title, price and Stock status
                Column(
                  children: [
                    Row(
                      children: [
                        const SSectionHeading(title: 'Variation', showActionButton: false),
                        const SizedBox(width: SSizes.spaceBtwItems),

                        Column(

                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,// to align from the start
                              children: [
                                const SCarTitleText(title: 'Price', smallSize: true),

                                ///Actual price
                                if (controller.selectedVariation.value.salePrice > 0)
                                Text(
                                  '\$${controller.selectedVariation.value.price}',
                                  style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                                ),
                                const SizedBox(width: SSizes.spaceBtwItems),

                                ///Sale price
                                SCarPriceText(price: controller.getVariationPrice()),
                              ],
                            ),
                            /// Stock
                            Row(
                              children: [
                                const SCarTitleText(title: 'Stock : ', smallSize: true),
                                Text(controller.variationStockStatus.value, style: Theme.of(context).textTheme.titleMedium),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    /// Variation Description
                    SCarTitleText(
                        title: controller.selectedVariation.value.description ?? '',
                      smallSize: true,
                      maxLines: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: SSizes.spaceBtwItems),

          ///Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: car.carAttributes!.map((attribute) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SSectionHeading(title: attribute.name ?? '', showActionButton: false),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                Obx(
                  () =>  Wrap(
                    spacing: 8,
                    children: attribute.values!.map((attributeValue) {
                      final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                      final available = controller
                          .getAttributesAvailabilityInVariation(car.carVariations!, attribute.name!)
                          .contains(attributeValue);

                      return SChoiceChip(
                          text: attributeValue, selected: isSelected, onSelected: available ? (selected){
                            if(selected && available){
                              controller.onAttributeSelected(car, attribute.name ?? '', attributeValue);
                            }
                      } : null);
                    }).toList()),
                )
              ],
            )).toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/container/rounded_container.dart';
import '../../../../../common/widgets/Text/car_price_text.dart';
import '../../../../../common/widgets/Text/car_title_text.dart';
import '../../../../../common/widgets/Text/s_brand_title_text.dart';
import '../../../../../common/widgets/images/s_circular_image.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/enums.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/car/car_controller.dart';
import '../../../models/car_model.dart';

class SCarsMetaData extends StatelessWidget {
  SCarsMetaData({super.key, required this.car}) {
    Get.put(CarController()); // Ensures the controller is available
  }

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    final controller = CarController.instance;
    final salePercentage = controller.calculateSalePercentage(car.price, car.bookingPrice);
    final darkMode = SHelperFunctions().isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Price & Sale Price
        Row(
          children: [
            ///Sale tag
            SRoundedContainer(
              radius: SSizes.sm,
              backgroundColor: SColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: SSizes.sm, vertical: SSizes.xs),
              child: Text('$salePercentage%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: SColors.black)),
            ),
            const SizedBox(width: SSizes.spaceBtwItems),
            ///Price tag
            if(car.carType == CarType.single.toString() && car.bookingPrice > 0)
            Text('\$${car.price}', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
            if(car.carType == CarType.single.toString() && car.bookingPrice > 0) const SizedBox(width: SSizes.spaceBtwItems),
            SCarPriceText(price: controller.getCarPrice(car), isLarge: true),
          ],
        ),
        const SizedBox(width: SSizes.spaceBtwItems / 1.5),

        ///Title
        SCarTitleText(title: car.title),
        const SizedBox(height: SSizes.spaceBtwItems / 1.5),

        ///Stock Status
        Row(
          children: [
            const SCarTitleText(title: 'Status'),
            const SizedBox(width: SSizes.spaceBtwItems),
            Text(controller.getCarNoAvailableStatus(car.noAvailable), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 1.5),
        ///Brand
        Row(
          children: [
            SCircularImage(image: car.brand != null ? car.brand!.image : '',
              width: 32,
              height: 32,
              overlayColor: darkMode ? SColors.white : SColors.dark,
            ),
            SBrandTitleText(title: car.brand != null ? car.brand!.name : '', brandTextSize: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}

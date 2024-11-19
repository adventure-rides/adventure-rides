import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/book/controllers/car/car_controller.dart';
import '../../../features/book/models/car_model.dart';
import '../../../features/book/screens/car_details/car_detail.dart';
import '../../../features/book/screens/cart/widgets/add_to_cart_button.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/enums.dart';
import '../../../utils/constraints/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../container/rounded_container.dart';
import '../../styles/shadows.dart';
import '../../widgets/Text/car_price_text.dart';
import '../../widgets/Text/car_title_text.dart';
import '../../widgets/Text/s_brand_title_text_with_verified_icon.dart';
import '../../widgets/images/s_rounded_image.dart';
import '../favourite_icon/favourite_icon.dart';

class SCarCardVertical extends StatelessWidget {
  const SCarCardVertical({super.key, required this.car});

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    final controller = CarController.instance;
    final salePercentage =
        controller.calculateSalePercentage(car.price, car.bookingPrice);
    final dark = SHelperFunctions().isDarkMode(context);

    ///container with side paddings, color, edges, radius and shadow
    return GestureDetector(
      onTap: () => Get.to(() => CarDetailScreen(car: car)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [SShadowStyle.verticalCarShadow],
          borderRadius: BorderRadius.circular(SSizes.carImageRadius),
          color: dark ? SColors.darkerGrey : SColors.white,
        ),
        child: Column(
          children: [
            ///Thumbnail, WishList Button, Discount Tag
            SRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(SSizes.sm),
              backgroundColor: dark ? SColors.dark : SColors.light,
              child: Stack(
                children: [
                  /// Thumbnail Image
                  Center(
                    child: SRoundedImage(
                        imageUrl: car.thumbnail,
                        applyImageRadius: true,
                        isNetworkImage: true),
                  ),

                  /// Sale tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: SRoundedContainer(
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
                    ),

                  ///Favourite icon button
                  Positioned(
                    top: 1,
                    right: 1,
                    child: SFavouriteIcon(carId: car.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections / 2),

            /// Details
            Padding(
              padding: const EdgeInsets.only(left: SSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SCarTitleText(title: car.title, smallSize: true),
                    const SizedBox(height: SSizes.spaceBtwItems / 2),
                    SBrandTitleWithVerifiedIcon(title: car.brand!.name, brandTextSize: TextSizes.small),
                  ],
                ),
              ),
            ),
            // Add Spacer() to keep the height of each box same in case 1 or 2 lines of headings
            const Spacer(),

            ///Price row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///price
                Flexible(
                  child: Column(
                    children: [
                      if (car.carType ==
                              CarType.single.toString() &&
                          car.bookingPrice > 3)
                        Padding(
                          padding: const EdgeInsets.only(left: SSizes.sm),
                          child: Text(
                            car.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),

                      ///Price, show sale price as main price if sale exist
                      Padding(
                        padding: const EdgeInsets.only(left: SSizes.sm),
                        child: SCarPriceText(
                            price: controller.getCarPrice(car)),
                      ),
                    ],
                  ),
                ),

                ///Add to cart Button
                CarCardAddToCartButton(car: car),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

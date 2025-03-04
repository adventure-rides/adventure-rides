import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../features/book/controllers/car/car_controller.dart';
import '../../../../features/book/models/car_model.dart';
import '../../../../features/book/screens/car_details/car_detail.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/enums.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../container/rounded_container.dart';
import '../../../styles/shadows.dart';
import '../../../widgets/Text/car_price_text.dart';
import '../../../widgets/Text/car_title_text.dart';
import '../../../widgets/Text/s_brand_title_text_with_verified_icon.dart';
import '../../../widgets/images/s_rounded_image.dart';
import '../../favourite_icon/favourite_icon.dart';

class DesktopCarCardVertical extends StatelessWidget {
  const DesktopCarCardVertical({super.key, required this.car, this.isSelected = false});

  final CarModel car;
  final bool isSelected; // New parameter


  @override
  Widget build(BuildContext context) {
    //final controller = CarController.instance;
    final controller = Get.put(CarController());
    final salePercentage =
    controller.calculateSalePercentage(car.price, car.bookingPrice);
    final dark = SHelperFunctions().isDarkMode(context);

    // Hover state managed by ValueNotifier
    final ValueNotifier<bool> isHovered = ValueNotifier<bool>(false);

    return GestureDetector(
      onTap: () => Get.to(() => CarDetailScreen(car: car), preventDuplicates: false),
      child: MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        child: ValueListenableBuilder<bool>(
          valueListenable: isHovered,
          builder: (context, hover, _) {
            return AnimatedScale(
              scale: hover ? 1.05 : 1.0, // Scale slightly on hover
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [SShadowStyle.verticalCarShadow],
                  borderRadius: BorderRadius.circular(SSizes.carImageRadius),
                  color: dark ? SColors.darkerGrey : SColors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Thumbnail and Wishlist Button
                    Flexible(
                      child: SRoundedContainer(
                        backgroundColor: dark ? SColors.dark : SColors.light,
                        child: Stack(
                          children: [
                            /// Thumbnail Image
                            Positioned.fill(
                              child: SRoundedImage(
                                imageUrl: car.thumbnail,
                                applyImageRadius: true,
                                isNetworkImage: true,
                                fit: BoxFit.fitWidth,
                              ),
                            ),

                            /// Favourite Icon
                            Positioned(
                              top: 1,
                              right: 1,
                              child: SFavouriteIcon(carId: car.id),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: SSizes.spaceBtwSections / 2),

                    /// Details Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SSizes.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SCarTitleText(title: car.title, smallSize: true),
                          SBrandTitleWithVerifiedIcon(
                            title: car.brand!.name,
                            brandTextSize: TextSizes.small,
                          ),
                        ],
                      ),
                    ),

                    /// Price Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SSizes.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Price Section
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (car.carType == CarType.single.toString() &&
                                    car.bookingPrice > 3)
                                  Text(
                                    car.price.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .apply(decoration: TextDecoration.lineThrough),
                                  ),
                                SCarPriceText(price: controller.getCarPrice(car)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
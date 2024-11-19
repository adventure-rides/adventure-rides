import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/book/controllers/car/car_controller.dart';
import '../../../features/book/models/car_model.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/enums.dart';
import '../../../utils/constraints/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../container/rounded_container.dart';
import '../../widgets/Text/car_price_text.dart';
import '../../widgets/Text/car_title_text.dart';
import '../../widgets/Text/s_brand_title_text_with_verified_icon.dart';
import '../../widgets/images/s_rounded_image.dart';
import '../favourite_icon/favourite_icon.dart';

class SCarCardHorizontal extends StatelessWidget {
  const SCarCardHorizontal({super.key, required this.car});

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    final controller = CarController.instance;
    final salePercentage = controller.calculateSalePercentage(car.price, car.bookingPrice);
    final dark = SHelperFunctions().isDarkMode(context);

    return Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SSizes.carImageRadius),
        color: dark ? SColors.darkerGrey : SColors.lightContainer,
    ),
      child: Row(
        children: [
          ///Thumbnail
          SRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(SSizes.md),
            backgroundColor: dark ? SColors.dark : SColors.light,
            child: Stack(
              children: [
                ///Thumbnail Image
                SizedBox(
                  height: 120,
                    width: 120,
                    child: SRoundedImage(imageUrl: car.thumbnail, applyImageRadius: true, isNetworkImage: true),
                ),

                /// Sale tag
                Positioned(
                  top: 12,
                  child: SRoundedContainer(
                    radius: SSizes.sm,
                    backgroundColor: SColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: SSizes.sm, vertical: SSizes.xs),
                    child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: SColors.black)),
                  ),
                ),

                ///Favourite icon button
                Positioned(
                  top: 0,
                  right: 0,
                  child: SFavouriteIcon(carId: car.id),
                ),
              ],

            ),
          ),
          ///Display the details
         Flexible(
           child: SizedBox( //to give a fixed width
             width: 172,
             child: Padding(
               padding: const EdgeInsets.only(top: SSizes.sm, left: SSizes.sm),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,//To push elements to the left side
                      children: [
                        SCarTitleText(title: car.title, smallSize: true),
                        const SizedBox(height: SSizes.spaceBtwItems / 2),
                        SBrandTitleWithVerifiedIcon(title: car.brand!.name),
                      ],
                    ),
           
                    const Spacer(), //Take all the remaining space at the center and push the items both downwards and upwards

                    ///Price row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        ///price
                        Flexible(
                          child: Column(
                            children: [
                              if(car.carType == CarType.single.toString() && car.bookingPrice > 3)
                                Padding(
                                  padding: const EdgeInsets.only(left: SSizes.sm),
                                  child: Text(
                                    car.price.toString(),
                                    style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                              ///Price, show sale price as main price if sale exist
                              Padding(
                                padding: const EdgeInsets.only(left: SSizes.sm),
                                child: SCarPriceText(price: controller.getCarPrice(car)),
                              ),
                            ],
                          ),
                        ),

                        ///Add to cart Button
                        Container(
                          decoration: const BoxDecoration(
                            color: SColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(SSizes.cardRadiusMd),
                              bottomRight:
                              Radius.circular(SSizes.carImageRadius),
                            ),
                          ),
                          child: const SizedBox(
                            width: SSizes.iconLg * 1.2,
                            height: SSizes.iconLg * 1.2,
                            child: Icon(Iconsax.add, color: SColors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
             ),
           ),
         )
        ],
      ),
    );
  }
}

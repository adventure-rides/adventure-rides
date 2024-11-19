import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/container/rounded_container.dart';
import '../features/Effects/shimmer.dart';
import '../features/book/models/brand_model.dart';
import '../features/book/screens/brand/brand_cars.dart';
import '../utils/constraints/colors.dart';
import '../utils/constraints/sizes.dart';
import '../utils/helpers/helper_functions.dart';
import 'brand_card.dart';

class SBrandShowcase extends StatelessWidget {
  const SBrandShowcase({
    super.key,
    required this.images, required this.brand,
  });
  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandCars(brand: brand)),
      child: SRoundedContainer(
        showBorder: true,
        borderColor: SColors.darkerGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(SSizes.md),
        margin: const EdgeInsets.only(bottom: SSizes.spaceBtwItems),
        child: Column(
          children: [
            ///Brands with products count
            SBrandCard(showBorder: false, brand: brand),
            const SizedBox(height: SSizes.spaceBtwItems),
            ///Brand top 3 product images
            Row(
              children: images.map((image) => brandTopProductImageWidget(image, context)).toList(),
      
            )
          ],
        ),
      ),
    );
  }
  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
        child: SRoundedContainer(
          height: 100,
          padding: const EdgeInsets.all(SSizes.md),
          margin: const EdgeInsets.only(right: SSizes.sm),
          backgroundColor: SHelperFunctions().isDarkMode(context) ? SColors.darkerGrey : SColors.light,
          child: CachedNetworkImage(
            fit: BoxFit.contain,
              imageUrl: image,
            progressIndicatorBuilder: (context, url, downloadProgress) => const SShimmerEffect(width: 100, height: 100),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
    );
  }
}


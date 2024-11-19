import 'package:adventure_rides/features/Effects/shimmer.dart';
import 'package:flutter/material.dart';

import '../../utils/constraints/sizes.dart';

class SHorizontalCarShimmer extends StatelessWidget {
  const SHorizontalCarShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: SSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: SSizes.spaceBtwItems),
          itemCount: itemCount,
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,

              children: [
                ///image
                SShimmerEffect(width: 120, height: 120),
                SizedBox(height: SSizes.spaceBtwItems),

                ///Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: SSizes.spaceBtwItems / 2),
                    SShimmerEffect(width: 160, height: 15),
                    SizedBox(height: SSizes.spaceBtwItems / 2),
                    SShimmerEffect(width: 110, height: 15),
                    SizedBox(height: SSizes.spaceBtwItems / 2),
                    SShimmerEffect(width: 80, height: 15),
                    Spacer(),
                  ],
                ),
              ],
          )
      ),

    );
  }
}

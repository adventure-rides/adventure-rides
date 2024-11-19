import 'package:adventure_rides/features/Effects/shimmer.dart';
import 'package:flutter/material.dart';

import '../../utils/constraints/sizes.dart';

class SListTileShimmer extends StatelessWidget {
  const SListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            SShimmerEffect(width: 100, height: 50, radius: 50),
            SizedBox(width: SSizes.spaceBtwItems),
            Column(
              children: [
                SShimmerEffect(width: 100, height: 15),
                SizedBox(width: SSizes.spaceBtwItems / 2),
                SShimmerEffect(width: 80, height: 12)
              ],
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:adventure_rides/features/Effects/shimmer.dart';
import 'package:flutter/material.dart';

import '../../utils/constraints/sizes.dart';

class SBoxesShimmer extends StatelessWidget {
  const SBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: SShimmerEffect(width: 150, height: 110)),
            SizedBox(width: SSizes.spaceBtwItems),
            Expanded(child: SShimmerEffect(width: 150, height: 110)),
            SizedBox(width: SSizes.spaceBtwItems),
            Expanded(child: SShimmerEffect(width: 150, height: 110)),
            SizedBox(width: SSizes.spaceBtwItems),
          ],
        )
      ],
    );
  }
}

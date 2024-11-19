import 'package:adventure_rides/features/Effects/shimmer.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/layouts/grid_layout.dart';

class SBrandsShimmer extends StatelessWidget {
  const SBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SGridLayout(
      mainAxisExtent: 80,
        itemCount: itemCount,
        itemBuilder: (_, __) => const SShimmerEffect(width: 300, height: 80),
    );
  }
}

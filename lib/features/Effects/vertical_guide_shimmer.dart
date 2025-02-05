import 'package:adventure_rides/features/Effects/shimmer.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../utils/constraints/sizes.dart';

class SVerticalGuideShimmer extends StatelessWidget {
  const SVerticalGuideShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) {
        return const SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///image
              SShimmerEffect(width: 180, height: 180),
              SizedBox(height: SSizes.spaceBtwItems),

              ///Text
              SShimmerEffect(width: 160, height: 15),
              SizedBox(height: SSizes.spaceBtwItems / 2),
              SShimmerEffect(width: 110, height: 15),
            ],
          ),
        );
      },
    );
  }
}
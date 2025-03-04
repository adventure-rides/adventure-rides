import 'package:flutter/material.dart';
import '../../../../utils/constraints/sizes.dart';

class GuideDesktopGridLayout extends StatelessWidget {
  const GuideDesktopGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 319,

  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: SSizes.gridViewSpacing,
          crossAxisSpacing: SSizes.gridViewSpacing,
          mainAxisExtent: mainAxisExtent, //adjust the value
        ),
        itemBuilder: itemBuilder,
    );
  }
}

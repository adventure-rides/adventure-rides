import 'package:flutter/material.dart';
import '../../../../../../common/widgets/Text/car_title_text.dart';
import '../../../../../../common/widgets/Text/s_brand_title_text_with_verified_icon.dart';
import '../../../../../../common/widgets/images/s_rounded_image.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../models/cart_item_model.dart';

class CartItemMobile extends StatelessWidget {
  const CartItemMobile({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    //final cartController = CartController.instance;
    return Row(
      children: [
        ///image
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                blurRadius: 8, // Softness of the shadow
                spreadRadius: 2, // How far the shadow spreads
                offset: Offset(0, 4), // Position of the shadow (x, y)
              ),
            ],
            borderRadius: BorderRadius.circular(SSizes.sm), // Match SRoundedImage rounding
          ),
          child: SRoundedImage(
            imageUrl: cartItem.image ?? '',
            width: 80,
            height: 80,
            isNetworkImage: true,
            fit: BoxFit.cover, // contain, cover, fill, or remove the fit property
            padding: EdgeInsets.all(SSizes.sm),
            backgroundColor: SHelperFunctions().isDarkMode(context)
                ? SColors.darkerGrey
                : SColors.light,
          ),
        ),
        const SizedBox(width: SSizes.spaceBtwItems),

        ///Title, Price, size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(
                  child: SCarTitleText(title: cartItem.title, maxLines: 1)),

              /// Attributes

              Text.rich(
                TextSpan(
                    children: (cartItem.selectedVariation ?? {})
                        .entries
                        .map((e) => TextSpan(children: [
                          TextSpan(text: ' ${e.key} ', style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(text: ' ${e.value} ', style: Theme.of(context).textTheme.bodyLarge),
                    ],
                    ),
                    ).toList(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

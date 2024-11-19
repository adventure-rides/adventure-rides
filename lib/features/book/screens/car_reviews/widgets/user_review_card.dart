import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../common/cars/ratings/rating_indicator.dart';
import '../../../../../common/container/rounded_container.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/image_strings.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(SImages.user1)),
                const SizedBox(width: SSizes.spaceBtwItems),
                Text('Seth Odwar',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems),

        ///Reviews
        Row(
          children: [
            const SRatingBarIndicator(rating: 4),
            const SizedBox(width: SSizes.spaceBtwItems),
            Text('01 Aug, 2024', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems),
        const ReadMoreText(
          'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less ',
          trimCollapsedText: ' show more ',
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: SColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: SColors.primary),
        ),
        const SizedBox(height: SSizes.spaceBtwItems),

        ///Company Review
        SRoundedContainer(
          backgroundColor: dark ? SColors.darkerGrey : SColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(SSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("E-Waste's Store",
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text('01 Aug, 2024',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                const ReadMoreText(
                  'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less ',
                  trimCollapsedText: ' show more ',
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: SColors.primary),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: SColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: SSizes.spaceBtwSections),
      ],
    );
  }
}

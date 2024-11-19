import 'package:adventure_rides/features/book/screens/car_reviews/widgets/rating_progress_indicator.dart';
import 'package:adventure_rides/features/book/screens/car_reviews/widgets/user_review_card.dart';
import 'package:flutter/material.dart';
import '../../../../common/appbar/appbar.dart';
import '../../../../common/cars/ratings/rating_indicator.dart';
import '../../../../utils/constraints/sizes.dart';

class CarReviewsScreen extends StatelessWidget {
  const CarReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Appbar
      appBar:
          const SAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and reviews are verified and are from people who use the same type of device that you use.'),
              const SizedBox(height: SSizes.spaceBtwItems),

              ///Overall Car Ratings
              const SOveralCarRating(),
              const SRatingBarIndicator(rating: 3.5),
              Text("12, 611", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: SSizes.spaceBtwSections),

              ///User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}

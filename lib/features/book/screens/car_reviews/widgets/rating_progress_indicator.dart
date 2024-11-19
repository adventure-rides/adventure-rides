import 'package:adventure_rides/features/book/screens/car_reviews/widgets/progress_indicator_and%20rating.dart';
import 'package:flutter/material.dart';

class SOveralCarRating extends StatelessWidget {
  const SOveralCarRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Text('4.8',
                style: Theme.of(context).textTheme.displayLarge)),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              SRatingProgressIdicator(text: '5', value: 1.0),
              SRatingProgressIdicator(text: '4', value: 0.8),
              SRatingProgressIdicator(text: '3', value: 0.6),
              SRatingProgressIdicator(text: '2', value: 0.4),
              SRatingProgressIdicator(text: '1', value: 0.2),
            ],
          ),
        )
      ],
    );
  }
}

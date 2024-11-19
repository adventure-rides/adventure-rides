import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:flutter/material.dart';
import '../../../../../common/container/rounded_container.dart';
import '../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SGuideAttributes extends StatelessWidget {
  const SGuideAttributes({super.key, required this.guide});

  final TourGuideModel guide;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);

    return Column(
      children: [
        /// Guide Details & Description
        SRoundedContainer(
          backgroundColor: dark ? SColors.darkerGrey : SColors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Guide Name, Fee, and Availability
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Guide's Name
                        SSectionHeading(title: guide.tName, showActionButton: false),
                        const SizedBox(height: SSizes.spaceBtwItems),

                        // Guide Fee
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fee: ',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              '\$${guide.guideFee}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: SSizes.spaceBtwItems / 2),

                        // Guide Availability
                        Row(
                          children: [
                            Text(
                              'Availability: ',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              guide.guideAvailability ? 'Available' : 'Unavailable',
                              style: TextStyle(
                                color: guide.guideAvailability ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: SSizes.spaceBtwItems),
                      ],
                    ),
                  ),

                  // Guide Rating
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Rating: ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        guide.averageRating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: SSizes.spaceBtwItems),

        /// Languages and Experience
        SRoundedContainer(
          backgroundColor: dark ? SColors.darkerGrey : SColors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SSectionHeading(title: 'Guide Details', showActionButton: false),
              const SizedBox(height: SSizes.spaceBtwItems / 2),

              // Guide Languages
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Languages:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Wrap(
                    spacing: 8,
                    children: guide.languages.entries.map((entry) {
                      return Chip(
                        label: Text('${entry.key} (${entry.value})'),
                        backgroundColor: SColors.lightGrey,
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: SSizes.spaceBtwItems),

              // Guide Experience
              Row(
                children: [
                  Text(
                    'Experience: ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '${guide.experience} years',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

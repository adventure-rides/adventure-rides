import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../models/tour_guide_model.dart';

class SRatingAndShare extends StatelessWidget {
  final String? guideId;

  const SRatingAndShare({
    super.key,
    this.guideId,
  });

  /// Function to stream guide ratings and comments from Firestore
  Stream<Map<String, dynamic>> _fetchGuideRatings() {
    return FirebaseFirestore.instance
        .collection('Guides')
        .doc(guideId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data != null) {
        return {
          'averageRating': data['AverageRating'] ?? 0.0,
          'ratings': data['Ratings'] ?? [],
        };
      } else {
        return {
          'averageRating': 0.0,
          'ratings': [],
        };
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _fetchGuideRatings(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        // Extract data
        final averageRating = snapshot.data!['averageRating'] as double;
        final ratings = snapshot.data!['ratings'] as List<dynamic>;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display average rating and total number of reviews
                Row(
                  children: [
                    const Icon(Iconsax.star5, color: Colors.amber, size: 24),
                    const SizedBox(width: SSizes.spaceBtwItems / 2),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: averageRating.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextSpan(
                            text: ' (${ratings.length})',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Share button
                IconButton(
                  onPressed: () {
                    // Implement share functionality here
                  },
                  icon: const Icon(Icons.share, size: SSizes.iconMd),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Display individual comments in the review section
            ...ratings.map((ratingData) {
              final rating = GuideRating.fromMap(ratingData as Map<String, dynamic>);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Iconsax.star5, color: Colors.amber, size: 20),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rating.review ?? 'No comment provided',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '- $rating',  //'- ${rating.userId}',  // Replace with actual user name if availableReplace with actual user name if available
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

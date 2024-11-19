import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../../data/repositories/tour_guide/guide_repository.dart';
import '../../../../models/tour_guide_model.dart';

class RatingGuide extends StatelessWidget {
  final String guideId;
  final GuideRepository guideRepository;

  const RatingGuide({super.key, 
    required this.guideId,
    required this.guideRepository,
  });

  @override
  Widget build(BuildContext context) {
    double rating = 0.0;
    String review = '';

    return Scaffold(
      appBar: AppBar(title: Text("Rate this Guide")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Rating bar widget
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              itemCount: 5,
              itemSize: 40,
              allowHalfRating: true,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                rating = newRating;
              },
            ),
            // Text field for review
            TextField(
              decoration: InputDecoration(
                labelText: 'Write a review (optional)',
              ),
              onChanged: (text) {
                review = text;
              },
            ),
            // Submit button
            ElevatedButton(
              onPressed: () async {
                // Create a GuideRating object
                GuideRating newRating = GuideRating(
                  rating: rating,
                  review: review,
                  date: DateTime.now(),
                );

                // Add rating to Firestore
                try {
                  await guideRepository.addRatingToGuide(guideId, newRating);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Rating submitted!")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error submitting rating")),
                  );
                }
              },
              child: Text('Submit Rating'),
            ),
          ],
        ),
      ),
    );
  }
}

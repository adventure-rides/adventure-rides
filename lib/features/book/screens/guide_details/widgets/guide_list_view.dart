import 'package:flutter/material.dart';
import '../../../../../common/tour_guide/guide_cards/Desktop/desktop_guide_card_vertical.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../controllers/tour_guide/guide_controller.dart';

class GuideListView extends StatelessWidget {
  final GuideController guideController;

  const GuideListView({super.key, required this.guideController});

  @override
  Widget build(BuildContext context) {
    // Create a ScrollController
    final ScrollController scrollController = ScrollController();

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 330, // Adjust based on the card height
          child: ListView.separated(
            controller: scrollController, // Assign the ScrollController
            scrollDirection: Axis.horizontal,
            itemCount: guideController.availableGuides.length,
            separatorBuilder: (_, index) => SizedBox(width: SSizes.defaultSpace), // Space between cards
            itemBuilder: (_, index) => DesktopGuideCardVertical(
              guide: guideController.availableGuides[index],
            ),
          ),
        ),
        Positioned(
          left: 10,
          child: FloatingActionButton(
            onPressed: () {
              // Scroll to the left
              scrollController.animateTo(
                scrollController.position.pixels - 200, // Adjust scroll amount
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Icon(Icons.arrow_left),
          ),
        ),
        Positioned(
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              // Scroll to the right
              scrollController.animateTo(
                scrollController.position.pixels + 200, // Adjust scroll amount
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Icon(Icons.arrow_right),
          ),
        ),
      ],
    );
  }
}
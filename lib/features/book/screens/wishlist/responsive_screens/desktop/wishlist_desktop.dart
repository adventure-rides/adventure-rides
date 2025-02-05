import 'package:adventure_rides/common/tour_guide/guide_cards/Desktop/desktop_guide_card_vertical.dart';
import 'package:adventure_rides/common/widgets/layouts/grids/desktop_grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/cars/cars_cards/desktop/desktop_wishlist_card_vertical.dart';
import '../../../../../../common/loaders/animation_loader.dart';
import '../../../../../../navigation_menu.dart';
import '../../../../../../utils/constraints/image_strings.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../Effects/vertical_car_shimmer.dart';
import '../../../../controllers/car/favourites_controller.dart';
import '../../../../models/car_model.dart';
import '../../../../models/tour_guide_model.dart';

class WishlistDesktop extends StatelessWidget {
  const WishlistDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());

    return Scaffold(

      body: SingleChildScrollView( // To make it scrollable
        child: Padding(
          padding: EdgeInsets.all(SSizes.defaultSpace),

          child: Obx(
                () => FutureBuilder(
                future: Future.wait([controller.favoriteCars(), controller.favoriteGuides()]),
                builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SVerticalCarShimmer(itemCount: 6); // Loading animation
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                // Combine both lists into a single widget display
                final cars = snapshot.data![0] as List<CarModel>;
                final guides = snapshot.data![1] as List<TourGuideModel>;

                if (cars.isEmpty && guides.isEmpty) {
                  return SAnimationLoaderWidget(
                    text: 'Whoops! Wishlist is Empty...',
                    animation: SImages.pencilAnimation,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionPressed: () => Get.off(() => const NavigationMenu()),
                  );
                }

                return DesktopGridLayout(
                  itemCount: cars.length + guides.length,
                  itemBuilder: (_, index) {
                    // Display cars and guides in the grid
                    if (index < cars.length) {
                      return DesktopWishlistCardVertical(car: cars[index]);
                    } else {
                      return DesktopGuideCardVertical(guide: guides[index - cars.length]);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
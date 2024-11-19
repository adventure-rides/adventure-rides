import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/appbar/appbar.dart';
import '../../../../common/cars/cars_cards/car_card_vertical.dart';
import '../../../../common/icons/s_circular_icon.dart';
import '../../../../common/loaders/animation_loader.dart';
import '../../../../common/tour_guide/guide_cards/guide_card_vertical.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../Effects/vertical_car_shimmer.dart';
import '../../../authentication/screens/home/widgets/home.dart';
import '../../controllers/car/favourites_controller.dart';
import '../../models/car_model.dart';
import '../../models/tour_guide_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());

    return Scaffold(
      appBar: SAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          SCircularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
        ],
      ),
      body: SingleChildScrollView( // To make it scrollable
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),

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

                return SGridLayout(
                  itemCount: cars.length + guides.length,
                  itemBuilder: (_, index) {
                    // Display cars and guides in the grid
                    if (index < cars.length) {
                      return SCarCardVertical(car: cars[index]);
                    } else {
                      return SGuideCardVertical(guide: guides[index - cars.length]);
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
import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import 'package:adventure_rides/features/book/screens/wishlist/responsive_screens/desktop/wishlist_desktop.dart';
import 'package:adventure_rides/features/book/screens/wishlist/responsive_screens/mobile/wishlist_mobile.dart';
import 'package:adventure_rides/features/book/screens/wishlist/responsive_screens/tablet/wishlist_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../common/icons/s_circular_icon.dart';
import '../../../authentication/screens/home/widgets/home.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FixedScreenAppbar(title: "Wishlist"),
      body: Stack(
        children: [
          // Layout for different screen sizes
          SSiteTemplate(
            useLayout: false,
            desktop: WishlistDesktop(),
            tablet: WishlistMobile(),
            mobile: WishlistTablet(),
          ),
          // Floating Plus Icon positioned below the AppBar
          Positioned(
            top: 2,  // Adjust vertical position
            right: 2,   // Adjust horizontal position
            child: SCircularIcon(
              icon: Iconsax.add,
              onPressed: () => Get.to(const HomeScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
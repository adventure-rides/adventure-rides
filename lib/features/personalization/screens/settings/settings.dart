import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/appbar/appbar.dart';
import '../../../../common/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/Text/section_heading.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../authentication/screens/profile/profile.dart';
import '../../../book/screens/booking/bookings.dart';
import '../../../book/screens/cart/cart.dart';
import '../address/address.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///header
            SPrimaryHeaderContainer(
              child: Column(
                children: [
                  SAppBar(
                      title: Text('Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: SColors.white))),

                  //User profile card
                  SUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: SSizes.spaceBtwSections),
                ],
              ),
            ),

            ///body
            Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace),
              child: Column(
                children: [
                  ///Account Settings
                  const SSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: SSizes.spaceBtwItems),

                  SSettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: 'My Addresses',
                      subTitle: 'Set the pickup location address',
                      onTap: () => Get.to(() => const UserAddressScreen())),
                  SSettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Bookings Cart',
                      subTitle: 'Add, remove cars and move to checkout',
                      onTap: () => Get.to(() => const CartScreen())),
                  SSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Bookings',
                      subTitle: 'In-progress and completed bookings',
                      onTap: () => Get.to(() => BookingScreen())),
                  SSettingsMenuTile(
                      icon: Iconsax.bank,
                      title: 'Bank Account',
                      subTitle: 'Withdraw balance to registered bank account',
                      onTap: () {}),
                  SSettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: 'My Coupons',
                      subTitle: 'List of all the discounted coupons',
                      onTap: () {}),
                  SSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notification message',
                      onTap: () {}),
                  SSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts',
                      onTap: () {}),

                  /*
                  ///App Settings
                  const SizedBox(height: SSizes.spaceBtwSections),
                  const SSectionHeading(
                      title: 'App Settings', showActionButton: false),
                  const SizedBox(height: SSizes.spaceBtwItems),
                  SSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subTitle: 'Upload data to the cloud',
                      onTap: () => Get.to(() => const UploadDataScreen()),
                  ),
                 //for the location
                  SSettingsMenuTile(
                      icon: Iconsax.location,
                      title: 'Geolocation',
                      subTitle: 'Set recommendation based on location',
                     // onTap: () => Get.to(() => const UploadDataScreen()),
                      trailing: Switch(value: true, onChanged: (value) {}), //Switch is for toggle with trailing
                  ),
                  //for the security
                  SSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                 //for the image quality settings
                  SSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),


                   */
                  ///Logout button
                  const SizedBox(height: SSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text('Logout')),
                  ),
                  const SizedBox(height: SSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

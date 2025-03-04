import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import 'package:adventure_rides/features/authentication/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/Text/section_heading.dart';
import '../../../../common/widgets/images/s_circular_image.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../../personalization/screens/address/widgets/change_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SDevicesUtils.getAppBarBarHeight()), // the height of the AppBar
        child: FixedScreenAppbar(title: 'Profile', // The fixed AppBar
      ),
      ),
      ///Body
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
              ///Profile Picture
              SizedBox(
                width: double.infinity, // takes the complete width of any screen
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : SImages.user;
                      return controller.imageUploading.value
                          ? SCircularImage(image: image, width: 80, height: 80)
                              : SCircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                  ],
                ),
              ),
              ///Details
              const SizedBox(height: SSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: SSizes.spaceBtwItems),

              ///Heading Profile info
              SProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName())),
              SProfileMenu(title: 'Username', value: controller.user.value.username, onPressed: (){}),

              const SizedBox(height: SSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: SSizes.spaceBtwItems),

              ///Heading Personal Information
              const SSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: SSizes.spaceBtwItems),

              SProfileMenu(title: 'User ID', value: controller.user.value.id,icon: Iconsax.copy, onPressed: (){}),
              SProfileMenu(title: 'E-Mail', value: controller.user.value.email, onPressed: (){}),
              SProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber, onPressed: (){}),
              SProfileMenu(title: 'Gender', value: 'Male', onPressed: (){}),
              SProfileMenu(title: 'Date', value: '10th Oct, 1995', onPressed: (){}),
              const Divider(),
              const SizedBox(height: SSizes.spaceBtwItems),

              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text('Close Account', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
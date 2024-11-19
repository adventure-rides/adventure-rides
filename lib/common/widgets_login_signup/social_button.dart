import 'package:adventure_rides/utils/constraints/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/authentication/controllers_backend/login/login_controller.dart';
import '../../utils/constraints/colors.dart';
import '../../utils/constraints/sizes.dart';

class SSocialButtons extends StatelessWidget {
  const SSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());//Create instance of the controller
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///Google
        Container(
          decoration: BoxDecoration(border: Border.all(color: SColors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              width: SSizes.iconMd,
              height: SSizes.iconMd,
              image: AssetImage(SImages.google),
            ),
          ),
        ),
        const SizedBox(width: SSizes.spaceBtwItems),
       ///Facebook
        Container(
          decoration: BoxDecoration(border: Border.all(color: SColors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: (){},
            icon: const Image(
              width: SSizes.iconMd,
              height: SSizes.iconMd,
              image: AssetImage(SImages.facebook),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/personalization/controllers/user_controller.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../images/s_circular_image.dart';


class SUserProfileTile extends StatelessWidget {
  const SUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const SCircularImage(
        image: SImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: SColors.black)),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: SColors.black)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: SColors.primary)), // to edit the icon

    );
  }
}

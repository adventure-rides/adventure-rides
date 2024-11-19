import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/container/rounded_container.dart';
import '../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/car/checkout_controller.dart';

class SBillingPaymentSection extends StatelessWidget {
  const SBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckOutController());
    final dark = SHelperFunctions().isDarkMode(context);
    return Column(
      children: [
        SSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () => controller.selectPaymentMethod(context)),
        const SizedBox(height: SSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              SRoundedContainer(
                width: 60,
                height: 60,
                backgroundColor: dark ? SColors.light : SColors.white,
                padding: const EdgeInsets.all(SSizes.md),
                child: Image(image: AssetImage(controller.selectedPaymentMethod.value.image), fit: BoxFit.contain),

              ),
              const SizedBox(width: SSizes.spaceBtwItems / 2),
              Text(controller.selectedPaymentMethod.value.name.capitalize.toString(), style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        )

      ],
    );
  }
}

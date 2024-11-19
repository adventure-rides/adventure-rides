import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers_backend/signup/signup_controller.dart';

class STermsAndConditions extends StatelessWidget {
  const STermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = SHelperFunctions().isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value),
            ),
        ),
        const SizedBox(width: SSizes.spaceBtwItems),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '${SText.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
              text: '${SText.privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? SColors.white : SColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? SColors.white : SColors.primary,
                  ),
            ),
            TextSpan(
                text: '${SText.and} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
              text: '${SText.termsOfUse} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? SColors.white : SColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? SColors.white : SColors.primary,
                  ),
            ),
          ]),
        ),
      ],
    );
  }
}

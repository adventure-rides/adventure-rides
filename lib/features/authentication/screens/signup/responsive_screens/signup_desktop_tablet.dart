import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/layouts/templates/login_template.dart';
import '../../../../../common/widgets_login_signup/form_divider.dart';
import '../../../../../common/widgets_login_signup/social_button.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../signup_widgets/signup_form.dart';


class SignupScreenDesktopTablet extends StatelessWidget {
  const SignupScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SLoginTemplate(
      child: Column(
        children: [

          /// Form
          const SSignupForm(),
          SizedBox(height: SSizes.spaceBtwSections),

          /// Divider
          SFormDivider(dividerText: SText.orSignUpWith.capitalize!),
          SizedBox(height: SSizes.spaceBtwSections),

          /// Social Buttons
          const SSocialButtons(),
        ],
      ),
    );
  }
}

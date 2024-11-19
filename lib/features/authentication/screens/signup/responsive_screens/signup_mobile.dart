import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets_login_signup/form_divider.dart';
import '../../../../../common/widgets_login_signup/social_button.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../signup_widgets/signup_form.dart';

class SignupScreenMobile extends StatelessWidget {
  const SignupScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? SColors.black : Colors.white,
      body: Container(
        padding: EdgeInsets.all(SSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Form
              const SSignupForm(),

              /// Divider
              SFormDivider(dividerText: SText.orSignUpWith.capitalize!),
              const SizedBox(height: SSizes.spaceBtwSections),

              /// Social Buttons
              const SSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

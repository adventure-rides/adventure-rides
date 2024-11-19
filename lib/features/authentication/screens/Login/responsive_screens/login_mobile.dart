import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets_login_signup/form_divider.dart';
import '../../../../../common/widgets_login_signup/social_button.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

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
              ///  Header
              const SLoginHeader(),

              /// Form
              const SLoginForm(),

              ///Divider
              SFormDivider(dividerText: SText.orSignInWith.capitalize!),
              const SizedBox(height: SSizes.spaceBtwSections),

              ///Footer
              const SSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}

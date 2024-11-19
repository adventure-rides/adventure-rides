import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/layouts/templates/login_template.dart';
import '../../../../../common/widgets_login_signup/form_divider.dart';
import '../../../../../common/widgets_login_signup/social_button.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';


class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SLoginTemplate(
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
    );
  }
}

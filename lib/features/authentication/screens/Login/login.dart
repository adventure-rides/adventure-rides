import 'package:adventure_rides/features/authentication/screens/Login/responsive_screens/login_desktop_tablet.dart';
import 'package:adventure_rides/features/authentication/screens/Login/responsive_screens/login_mobile.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final dark = SHelperFunctions().isDarkMode(context);
    return const SSiteTemplate(useLayout: false, desktop: LoginScreenDesktopTablet(), mobile: LoginScreenMobile()
      /*
      body: SingleChildScrollView(
        child: Padding(
            padding: SSPacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Logo Title & Subtitle
              const SLoginHeader(),
              ///Form
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


       */
    );
  }
}


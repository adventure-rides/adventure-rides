import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import 'package:adventure_rides/features/authentication/screens/signup/responsive_screens/signup_desktop_tablet.dart';
import 'package:adventure_rides/features/authentication/screens/signup/responsive_screens/signup_mobile.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: FixedScreenAppbar(title: 'Sign up'),
      body: SSiteTemplate(useLayout: false, desktop: SignupScreenDesktopTablet(), mobile: SignupScreenMobile()));
    }
}

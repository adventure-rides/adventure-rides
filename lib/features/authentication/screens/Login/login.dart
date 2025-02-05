import 'package:adventure_rides/features/authentication/screens/Login/responsive_screens/login_desktop_tablet.dart';
import 'package:adventure_rides/features/authentication/screens/Login/responsive_screens/login_mobile.dart';
import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final dark = SHelperFunctions().isDarkMode(context);
    return Scaffold(appBar: FixedScreenAppbar(title: 'Sign in'),
      body: SSiteTemplate(useLayout: false, desktop: LoginScreenDesktopTablet(), mobile: LoginScreenMobile()));
  }
}


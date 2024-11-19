import 'package:adventure_rides/features/authentication/screens/password_configuration/responsive_screens/forget_password_desktop.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(useLayout: false, desktop: ForgetPasswordScreenDesktop());
  }
}

import 'package:adventure_rides/common/widgets/responsive/responsive_design.dart';
import 'package:adventure_rides/navigation_menu.dart';
import 'package:adventure_rides/route/app_routes.dart';
import 'package:adventure_rides/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'bindings/general_bindings.dart';

// Use this class to setup themes, initialize bindings, any animations
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false, // Remove the debug banner
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          initialBinding: GeneralBindings(),
          getPages: AppRoutes.pages,
          home: SResponsiveWidget(
                  mobile: NavigationMenu(), // Define or customize these as needed
                  tablet: NavigationMenu(),
                  desktop: NavigationMenu(),
          ),
          //home: NavigationMenu(),
          ///Show loader or circular progress indicator meanwhile Authentication Repository is deciding to show the relevant screen
          //home: const Scaffold(backgroundColor: SColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),

      );
     }
}

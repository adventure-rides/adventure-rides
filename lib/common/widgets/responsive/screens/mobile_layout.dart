import 'package:flutter/material.dart';


/// Widget for the mobile layout
class MobileLayout extends StatelessWidget {
  MobileLayout({super.key, this.body});

  /// Widget to be displayed as the body of the mobile layout
  final Widget? body;

  /// Key for the scaffold widget
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //appBar: THeader(scaffoldKey: scaffoldKey), // Header
      body: body ?? Container(), // Body
    );
  }
}

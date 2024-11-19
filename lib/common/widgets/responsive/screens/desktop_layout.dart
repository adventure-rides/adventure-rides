import 'package:adventure_rides/common/container/rounded_container.dart';
import 'package:flutter/material.dart';

/// Widget for the desktop layout
class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});

  /// Widget to be displayed as the body of the desktop layout
  final Widget? body;

  /// Key for the scaffold widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                //Header
                SRoundedContainer(
                  width: double.infinity,
                  height: 75,
                  backgroundColor: Colors.yellow.withOpacity(0.2),
                ),
                //THeader(), // Header
                body ?? Container() // Body
              ],
            ),
          ),
        ],
      ),
    );
  }
}


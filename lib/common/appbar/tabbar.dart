import 'package:flutter/material.dart';

import '../../utils/constraints/colors.dart';
import '../../utils/device/device_utility.dart';
import '../../utils/helpers/helper_functions.dart';

class STabBar extends StatelessWidget implements PreferredSizeWidget {
  const STabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    return Material(
      color: dark ? SColors.black : SColors.white,
      child: TabBar(
          tabs: tabs,
        isScrollable: true,
        indicatorColor: SColors.primary,
        labelColor: dark ? SColors.white : SColors.primary,
        unselectedLabelColor : SColors.darkGrey,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(SDevicesUtils.getAppBarBarHeight());
}
